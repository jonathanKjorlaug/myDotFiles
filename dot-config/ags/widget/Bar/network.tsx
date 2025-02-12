import { App } from "astal/gtk4";
import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PanelButton from "../common/PanelButton";
import Network from "gi://AstalNetwork";

import { WINDOW_NAME } from "../Quicksettings/Quicksettings";

export default function NetworkButton() {
    const network = Network.get_default();
    const wifi = bind(network, "wifi");

    return (
        <PanelButton
            window={WINDOW_NAME}
            onClicked={() => {
                App.toggle_window(WINDOW_NAME);
            }}
            child=<box cssClasses={[]}>
                <box
                    visible={
                        wifi.as(Boolean) &&
                        bind(network, "primary").as((primary) => primary == 2)
                    }
                    cssClasses={["SystemIcon"]}
                >
                    {wifi.as(
                        (wifi) =>
                            wifi && (
                                <image
                                    tooltipText={bind(wifi, "ssid").as(String)}
                                    cssClasses={["Wifi"]}
                                    iconName={bind(wifi, "iconName")}
                                />
                            ),
                    )}
                </box>
                <box
                    visible={bind(network, "primary").as(
                        (primary) => primary == 1,
                    )}
                    cssClasses={["SystemIcon"]}
                >
                    <image iconName={bind(network.wired, "iconName")} />
                </box>

                <box
                    visible={bind(network, "primary").as(
                        (primary) => primary == 0,
                    )}
                    cssClasses={["SystemIcon"]}
                >
                    <image iconName="network-wired-disconnected-symbolic" />
                </box>
            </box>
        />
    );
}
