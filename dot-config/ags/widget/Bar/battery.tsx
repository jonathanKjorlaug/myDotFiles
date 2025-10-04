import { App } from "astal/gtk4";
import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PanelButton from "../common/PanelButton";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import PowerProfiles from "gi://AstalPowerProfiles?version=0.1";

import { WINDOW_NAME } from "../Quicksettings/Quicksettings";

function time(seconds: number) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    return `${h}h ${m < 10 ? "0" + m : m}m`;
}

export default function () {
    const bat = Battery.get_default();
    const powerProfiles = PowerProfiles.get_default();

    return (
        <box cssClasses={["batteryButton"]}>
            <box visible={bind(bat, "isPresent")} cssClasses={["SystemIcon"]}>
                <image
                    iconName={bind(bat, "batteryIconName")}
                    tooltipText={bind(bat, "timeToEmpty").as(time)}
                />
            </box>

            <box
                visible={bind(bat, "isPresent").as((present) => !present)}
                cssClasses={["SystemIcon"]}
            >
                <image iconName={bind(powerProfiles, "iconName")} />
            </box>
        </box>
    );
}
