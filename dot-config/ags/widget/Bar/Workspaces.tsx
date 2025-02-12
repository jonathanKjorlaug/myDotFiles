import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import Hyprland from "gi://AstalHyprland";

function WorkspaceButton({ ws, ...props }) {
    const hyprland = Hyprland.get_default();
    const classNames = Variable.derive(
        [bind(hyprland, "focused_workspace"), bind(hyprland, "clients")],
        (fws, _) => {
            const classes = ["workspace-button"];

            const active = fws.id == ws.id;
            active && classes.push("active");

            const occupied =
                hyprland.get_workspace(ws.id)?.get_clients().length > 0;
            occupied && classes.push("occupied");
            return classes;
        },
    );
    return (
        <button
            cssClasses={classNames()}
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.CENTER}
            onClicked={() => ws.focus()}
            {...props}
        >
            {ws.id}
        </button>
    );
}

export default function Workspaces() {
    const hypr = Hyprland.get_default();
    return (
        <box cssClasses={["workspace-container"]}>
            {bind(hypr, "workspaces").as((wss) =>
                wss
                    .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
                    .sort((a, b) => a.id - b.id)
                    .map((ws) => <WorkspaceButton ws={ws} />),
            )}
            {}
        </box>
    );
}
