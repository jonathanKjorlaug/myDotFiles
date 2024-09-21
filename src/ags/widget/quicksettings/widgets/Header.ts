import icons from "lib/icons";
import options from "options";
import powermenu, { Action } from "service/powermenu";

const battery = await Service.import("battery");
const { image, size } = options.quicksettings.avatar;

function time(seconds: number) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    return `${h}h ${m < 10 ? "0" + m : m}m`;
}

const Avatar = () =>
    Widget.Box({
        class_name: "avatar",
        css: Utils.merge(
            [image.bind(), size.bind()],
            (img, size) => `
        min-width: ${size}px;
        min-height: ${size}px;
        background-image: url('${img}');
        background-size: cover;
    `,
        ),
    });

export const Header = () =>
    Widget.Box(
        { class_name: "header horizontal" },
        Avatar(),
        Widget.Box({
            vertical: true,
            vpack: "center",
            children: [
                Widget.Box({
                    visible: battery.bind("available"),
                    children: [
                        Widget.Icon({ icon: battery.bind("icon_name") }),
                        Widget.Label({
                            label: battery.bind("percent").as((p) => `${p}%`),
                        }),
                    ],
                }),
                Widget.Box([
                    Widget.Icon({ icon: icons.ui.time }),
                    Widget.Label({
                        label: battery.bind("time_remaining").as(time),
                    }),
                ]),
            ],
        }),
        Widget.Box({ hexpand: true }),
        Widget.Button({
            vpack: "center",
            child: Widget.Icon(icons.ui.settings),
            on_clicked: () => {
                App.closeWindow("quicksettings");
                App.closeWindow("settings-dialog");
                App.openWindow("settings-dialog");
            },
        }),
        Widget.Button({
            vpack: "center",
            child: Widget.Icon(icons.powermenu["shutdown"]),
            on_clicked: () => App.toggleWindow("powermenu"),
        }),
    );
