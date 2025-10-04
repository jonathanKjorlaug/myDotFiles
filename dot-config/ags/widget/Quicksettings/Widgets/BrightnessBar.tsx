import { bind } from "astal";
import Brightness from "../../../services/Brightness";
import { Gtk } from "astal/gtk4";
import AstalBattery from "gi://AstalBattery?version=0.1";

export default function BrightnessBox() {
    const brightness = Brightness.get_default();
    const battery = AstalBattery.get_default();
    return (
        <box
            cssClasses={["brightness-box"]}
            valign={Gtk.Align.CENTER}
            visible={bind(battery, "isPresent")}
        >
            <image
                iconName={"display-brightness-symbolic"}
                valign={Gtk.Align.CENTER}
            />
            <slider
                onChangeValue={(self) => {
                    brightness.screen = self.value;
                }}
                min={0.1}
                value={bind(brightness, "screen")}
                hexpand
            />
        </box>
    );
}
