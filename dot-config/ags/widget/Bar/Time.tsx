import { Astal, Gtk, Gdk, App } from "astal/gtk4";
import { Variable, GLib, bind, execAsync } from "astal";
import PanelButton from "../common/PanelButton";

export default function ({ format = "%a %b %d %H:%M" }) {
    const time = Variable<string>("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(format)!,
    );

    return (
        <PanelButton
            window={"null"}
            onClicked={() => {
                execAsync("swaync-client -t -sw");
            }}
            child=<label
                cssClasses={["Time"]}
                onDestroy={() => time.drop()}
                label={time()}
            />
        />
    );
}
