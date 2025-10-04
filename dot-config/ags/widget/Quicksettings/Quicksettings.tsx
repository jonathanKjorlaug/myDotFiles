import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PopupWindow from "../common/PopupWindow";
import PowerButtons from "./Widgets/PowerButtons";
import VolumeBar from "./Widgets/VolumeBar";
import BrightnessBox from "./Widgets/BrightnessBar";
import { FlowBox } from "../common/FlowBox";
import MicQS from "./Widgets/micButton";

import AstalBattery from "gi://AstalBattery?version=0.1";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import AstalNetwork from "gi://AstalNetwork?version=0.1";

export const WINDOW_NAME = "quicksettings";

export const qsPage = Variable("main");

import BatteryPage from "./pages/BatteryPage";
import WifiPage from "./pages/WifiPage";
import SpeakerPage from "./pages/SpeakerPage";
import AstalPowerProfiles from "gi://AstalPowerProfiles?version=0.1";

import ArrowButton from "./ArrowButton";

function Header() {
    const battery = AstalBattery.get_default();
    const powerProfiles = AstalPowerProfiles.get_default();

    return (
        <box hexpand={false} cssClasses={["QSRow"]} spacing={6}>
            <label label={"Quick Setting"} xalign={0} />
            <box hexpand />
            <button
                cssClasses={["battery"]}
                onClicked={() => {
                    qsPage.set("battery");
                }}
            >
                <box>
                    <box spacing={2} visible={bind(battery, "isPresent")}>
                        <image
                            iconName={bind(battery, "batteryIconName")}
                            iconSize={Gtk.IconSize.NORMAL}
                            cssClasses={["icon"]}
                        />
                        <label
                            label={bind(battery, "percentage").as(
                                (p) => `${Math.floor(p * 100)}%`,
                            )}
                        />
                    </box>

                    <box
                        visible={bind(battery, "isPresent").as(
                            (present) => !present,
                        )}
                        cssClasses={["SystemIcon"]}
                    >
                        <image iconName={bind(powerProfiles, "iconName")} />
                    </box>
                </box>
            </button>
            <PowerButtons />
        </box>
    );
}

function WifiBluetooth() {
    const bluetooth = AstalBluetooth.get_default();
    const btAdapter = bluetooth.adapter;
    const deviceConnected = Variable.derive(
        [bind(bluetooth, "devices"), bind(bluetooth, "isConnected")],
        (d, _) => {
            for (const device of d) {
                if (device.connected) return device.name;
            }
            return "No device";
        },
    );

    const wifi = AstalNetwork.get_default().wifi;
    const wifiSsid = Variable.derive(
        [bind(wifi, "state"), bind(wifi, "ssid")],
        (state, ssid) => {
            return state == AstalNetwork.DeviceState.ACTIVATED
                ? ssid
                : AstalNetwork.device_state_to_string();
        },
    );
    return (
        <box
            homogeneous
            spacing={6}
            onDestroy={() => {
                wifiSsid.drop();
                deviceConnected.drop();
            }}
        >
            <ArrowButton
                icon={bind(wifi, "iconName")}
                title="Wi-Fi"
                subtitle={wifiSsid()}
                onClicked={() => wifi.set_enabled(!wifi.get_enabled())}
                onArrowClicked={() => {
                    wifi.scan();
                    qsPage.set("wifi");
                }}
                connection={[wifi, "enabled"]}
            />
            <ArrowButton
                icon={bind(btAdapter, "powered").as(
                    (p) => `bluetooth-${p ? "" : "disabled-"}symbolic`,
                )}
                title="Bluetooth"
                subtitle={deviceConnected()}
                onClicked={() => bluetooth.toggle()}
                onArrowClicked={() => console.log("Will add bt page later")}
                connection={[btAdapter, "powered"]}
            />
        </box>
    );
}

function MainPage() {
    return (
        <box
            cssClasses={["window-content", "quicksettings"]}
            hexpand={false}
            vertical
            name="main"
        >
            <Header />
            <box cssClasses={["QSRow"]}>
                {
                    // <WifiBluetooth />
                }
            </box>
            <box cssClasses={["QSRow"]} vertical>
                <VolumeBar />
                <BrightnessBox />
            </box>
            <FlowBox maxChildrenPerLine={2} homogeneous>
                <MicQS />
            </FlowBox>
        </box>
    );
}

export default function (_gdkmonitor: Gdk.Monitor) {
    return (
        <PopupWindow
            name={WINDOW_NAME}
            layout="top_right"
            animation="slide top"
            child=<stack
                visibleChildName={qsPage()}
                transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
                cssClasses={["quicksettings"]}
            >
                <MainPage />
                <BatteryPage />
                <SpeakerPage />
                <WifiPage />
            </stack>
        ></PopupWindow>
    );
}
