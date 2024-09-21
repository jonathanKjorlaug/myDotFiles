import PanelButton from "../PanelButton";
import icons from "lib/icons";
import asusctl from "service/asusctl";

const notifications = await Service.import("notifications");
const bluetooth = await Service.import("bluetooth");
const audio = await Service.import("audio");
const network = await Service.import("network");
const battery = await Service.import("battery");

const BatteryIndicator = () =>
    Widget.Icon({
        visible: battery.bind("available"),
        icon: battery.bind("icon_name"),
    });

const MicrophoneIndicator = () =>
    Widget.Icon()
        .hook(
            audio,
            (self) =>
                (self.visible =
                    audio.recorders.length > 0 ||
                    !audio.microphone.is_muted ||
                    false),
        )
        .hook(audio.microphone, (self) => {
            const vol = audio.microphone.is_muted ? 0 : audio.microphone.volume;
            const { muted, low, medium, high } = icons.audio.mic;
            const cons = [
                [67, high],
                [34, medium],
                [1, low],
                [0, muted],
            ] as const;
            self.icon = cons.find(([n]) => n <= vol * 100)?.[1] || "";
        });

const DNDIndicator = () =>
    Widget.Icon({
        visible: notifications.bind("dnd"),
        icon: icons.notifications.silent,
    });

const BluetoothIndicator = () =>
    Widget.Overlay({
        class_name: "bluetooth",
        passThrough: true,
        visible: bluetooth.bind("connected_devices").as((c) => c.length > 0),

        child: Widget.Icon({
            icon: icons.bluetooth.enabled,
        }),
    });

const NetworkIndicator = () =>
    Widget.Icon().hook(network, (self) => {
        let icon = network[network.primary || "wifi"]?.icon_name;
        if (
            network.primary == "wifi" &&
            network.wifi.internet == "disconnected"
        ) {
            icon = "network-wireless-disabled-symbolic";
        }
        self.icon = icon || "";
        self.visible = !!icon;
    });

const AudioIndicator = () =>
    Widget.Icon().hook(audio.speaker, (self) => {
        const vol = audio.speaker.is_muted ? 0 : audio.speaker.volume;
        const { muted, low, medium, high, overamplified } = icons.audio.volume;
        const cons = [
            [101, overamplified],
            [67, high],
            [34, medium],
            [1, low],
            [0, muted],
        ] as const;
        self.icon = cons.find(([n]) => n <= vol * 100)?.[1] || "";
    });

function updateIcon() {
    let icon = Widget.Icon();
    Utils.interval(
        10000,
        () => {
            Utils.execAsync(`bash -c "checkupdates | wc -l"`).then(
                (updates) => {
                    if (Number(updates) >= 50) {
                        icon.icon = [
                            [200, "software-update-urgent-symbolic"],
                            [50, "software-update-available-symbolic"],
                        ].find(([threshold]) => threshold <= updates)?.[1];
                        icon.visible = true;
                    } else {
                        icon.visible = false;
                    }
                },
            );
        },
        icon,
    );

    Utils.timeout(1, () => {
        icon.visible = false;
    });
    return icon;
}
export default () =>
    PanelButton({
        window: "quicksettings",
        css: "border-radius: 0 0 0 12px;",
        on_clicked: () => App.toggleWindow("quicksettings"),
        on_scroll_up: () => (audio.speaker.volume += 0.02),
        on_scroll_down: () => (audio.speaker.volume -= 0.02),
        child: Widget.Box([
            updateIcon(),
            BluetoothIndicator(),
            NetworkIndicator(),
            AudioIndicator(),
            MicrophoneIndicator(),
            BatteryIndicator(),
        ]),
    });
