// volume control

import { App, Astal, Gtk } from "astal/gtk4";
import { bind } from "astal";
import Brightness from "../../services/Brightness";
import { LevelBar } from "astal/gtk4/widget";

export default function () {
    const bs = Brightness.get_default();
    const { LEFT } = Astal.WindowAnchor;

    return (
        <window
            cssClasses={["BrightnessWindow", "OsdWindow"]}
            setup={(self) => App.add_window(self)}
            name="brightness"
            visible={false}
            margin={16}
            anchor={LEFT}
        >
            <box cssClasses={["BrightnessContainer", "OsdContainer"]} vertical>
                <image
                    iconName="display-brightness-symbolic"
                    cssClasses={["BrightnessIcon", "OsdIcon"]}
                />
                <box
                    cssClasses={[
                        "BrightnessPercentageContainer",
                        "OsdPercentageContainer",
                    ]}
                >
                    <LevelBar
                        inverted
                        orientation={Gtk.Orientation.VERTICAL}
                        cssClasses={["BrightnessPercentage", "OsdPercentage"]}
                        value={bind(bs, "screen").as((volume) =>
                            volume >= 0.07 ? volume : 0.07,
                        )}
                    />
                </box>
            </box>
        </window>
    );
}
