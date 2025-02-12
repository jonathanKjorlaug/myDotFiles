import PanelButton from "../PanelButton";
import icons from "lib/icons";

const notifications = await Service.import("notifications");
const bluetooth = await Service.import("bluetooth");
const audio = await Service.import("audio");
const network = await Service.import("network");
const battery = await Service.import("battery");

const MicrophoneIndicator = () =>
    Widget.Icon()
        .hook(
            audio,
            (self) =>
                (self.visible =
                    audio.recorders.length > 0 ||
                    audio.microphone.is_muted ||
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

const BluetoothIndicator = () =>
    Widget.Overlay({
        class_name: "bluetooth",
        passThrough: true,
        visible: bluetooth.bind("connected_devices").as((c) => c.length > 0),

        child: Widget.Icon({
            icon: icons.bluetooth.enabled,
        }),
    });

const BatteryIndicator = () =>
    Widget.Icon({
        visible: battery.bind("available"),
        icon: battery.bind("icon_name"),
    });

const NetworkIndicator = () =>
    Widget.Icon().hook(network, (self) => {
        const icon = network[network.primary || "wifi"]?.icon_name;
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

export default () =>
    PanelButton({
        window: "quicksettings",
        hpack: "end",
        on_clicked: () => App.toggleWindow("quicksettings"),
        on_scroll_up: () => (audio.speaker.volume += 0.02),
        on_scroll_down: () => (audio.speaker.volume -= 0.02),
        child: Widget.Box({
            class_name: "syshome",
            children: [
                BluetoothIndicator(),
                NetworkIndicator(),
                AudioIndicator(),
                MicrophoneIndicator(),
                BatteryIndicator(),
            ],
        }),
    });
