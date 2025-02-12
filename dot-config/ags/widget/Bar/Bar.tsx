import { App } from "astal/gtk4";
import { Astal, Gtk, Gdk } from "astal/gtk4";
import Workspaces from "./Workspaces";
import SystemIndicators from "./SystemIndicators";
import Time from "./Time";
import NetworkButton from "./network";
import BatteryButton from "./battery";
import AudioButton from "./audio";

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
        <window
            cssClasses={["Bar"]}
            gdkmonitor={monitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            visible
        >
            <centerbox css_classes={["mainBar"]}>
                <box hexpand halign={Gtk.Align.START}>
                    <Workspaces />
                </box>
                <box>
                    <Time />
                </box>
                <box hexpand halign={Gtk.Align.END}>
                    {
                        // <SysTray />
                    }
                    <NetworkButton />
                    <AudioButton />
                    <BatteryButton />
                    <SystemIndicators />
                </box>
            </centerbox>
        </window>
    );
}
