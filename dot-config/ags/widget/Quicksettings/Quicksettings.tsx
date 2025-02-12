import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PopupWindow from "../common/PopupWindow";
import PowerButtons from "./Widgets/PowerButtons";
import BluetoothButton from "./Widgets/BluetoothButton";
import NetworkButton from "./Widgets/NetworkButton";
import VolumeBar from "./Widgets/VolumeBar";
import BrightnessBox from "./Widgets/BrightnessBar";
import { FlowBox } from "../common/FlowBox";
import MicQS from "./Widgets/micButton";
import WifiButton from "./Widgets/WifiButton";

import AstalBattery from "gi://AstalBattery?version=0.1";

export const WINDOW_NAME = "quicksettings";

function BatteryLevel() {
    const bat = AstalBattery.get_default();

    return (
        <box
            cssClasses={["Battery"]}
            visible={bind(bat, "isPresent")}
            // xalign={0}
        >
            <image iconName={bind(bat, "batteryIconName")} />
            <label
                label={bind(bat, "percentage").as(
                    (p) => ` ${Math.floor(p * 100)}%`,
                )}
            />
        </box>
    );
}

const Row = ({
    toggles,
    menus = [],
}: {
    toggles: Gtk.Widget[];
    menus: Gtk.Widget[];
}) => (
    <box vertical cssClasses={["QSRow"]}>
        <box homogeneous> {toggles.map((w) => w)} </box>
        {...menus.map((w) => w)}
    </box>
);

export default function (_gdkmonitor: Gdk.Monitor) {
    return (
        <PopupWindow
            name={WINDOW_NAME}
            layout="top_right"
            animation="slide top"
            child=<box
                cssClasses={["window-content", "quicksettings"]}
                hexpand={false}
                vertical
            >
                <box cssClasses={["QSRow"]}>
                    <BatteryLevel />
                    <box hexpand />
                    <PowerButtons />
                </box>
                <box cssClasses={["QSRow"]} vertical>
                    <VolumeBar />
                    <BrightnessBox />
                </box>
                <FlowBox maxChildrenPerLine={2} homogeneous>
                    <WifiButton />
                    <BluetoothButton />
                    <MicQS />
                </FlowBox>
                {
                    // <Row
                    //     toggles={[NetworkButton(), BluetoothButton()]}
                    //     menus={[]}
                    // />
                }
            </box>
        ></PopupWindow>
    );
}
