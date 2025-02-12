import { App } from "astal/gtk4";
import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PanelButton from "../common/PanelButton";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";

import { WINDOW_NAME } from "../Quicksettings/Quicksettings";

function time(seconds: number) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    return `${h}h ${m < 10 ? "0" + m : m}m`;
}

export default function audioButton() {
    const bat = Battery.get_default();
    const speaker = Wp.get_default()?.audio.defaultSpeaker!;
    const network = Network.get_default();
    const wifi = bind(network, "wifi");

    return (
        <PanelButton
            window={WINDOW_NAME}
            onClicked={() => {
                App.toggle_window(WINDOW_NAME);
            }}
            child=<box cssClasses={["audioButton"]}>
                <box>
                    <image iconName={bind(speaker, "volumeIcon")} />
                </box>
            </box>
        />
    );
}
