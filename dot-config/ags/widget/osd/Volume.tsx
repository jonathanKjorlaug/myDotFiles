// volume control

import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { bind } from "astal";
import Wp from "gi://AstalWp";
import { LevelBar } from "astal/gtk4/widget";

export default function Volume(_gdkmonitor: Gdk.Monitor) {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!;
    const { RIGHT, BOTTOM } = Astal.WindowAnchor;

    return (
        <window
            cssClasses={["VolumeWindow", "OsdIcon"]}
            setup={(self) => App.add_window(self)}
            name="volume"
            visible={false}
            margin={16}
            anchor={RIGHT}
        >
            <box cssClasses={["VolumeContainer", "OsdContainer"]} vertical>
                <image
                    iconName={bind(speaker, "volumeIcon")}
                    cssClasses={["VolumeIcon", "OsdIcon"]}
                />
                <box
                    cssClasses={[
                        "VolumePercentageContainer",
                        "OsdPercentageContainer",
                    ]}
                >
                    <LevelBar
                        inverted
                        orientation={Gtk.Orientation.VERTICAL}
                        cssClasses={["VolumePercentage", "OsdPercentage"]}
                        value={bind(speaker, "volume").as((volume) =>
                            volume >= 0.07 ? volume : 0.07,
                        )}
                    />
                </box>
            </box>
        </window>
    );
}
