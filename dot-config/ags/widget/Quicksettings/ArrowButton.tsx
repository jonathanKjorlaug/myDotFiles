import { Astal, Gtk, Gdk, App } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import { timeout } from "astal";

export default function <T extends GObject.Object>({
    icon,
    title,
    subtitle,
    onClicked,
    onArrowClicked,
    connection: [gobject, property],
}: {
    icon: string | Binding<string>;
    title: string;
    subtitle: string | Binding<string>;
    onClicked: () => void;
    onArrowClicked: () => void;
    connection: [T, keyof T];
}) {
    return (
        <box
            cssClasses={bind(gobject, property).as((p) => {
                const classes = ["arrow-button"];
                p && classes.push("active");
                return classes;
            })}
        >
            <button onClicked={onClicked}>
                <box halign={Gtk.Align.START} spacing={6}>
                    <image iconName={icon} iconSize={Gtk.IconSize.LARGE} />
                    <box vertical hexpand>
                        <label
                            xalign={0}
                            label={title}
                            cssClasses={["title"]}
                        />
                        <label
                            xalign={0}
                            label={subtitle}
                            cssClasses={["subtitle"]}
                        />
                    </box>
                </box>
            </button>
            <button iconName={"go-next-symbolic"} onClicked={onArrowClicked} />
        </box>
    );
}
