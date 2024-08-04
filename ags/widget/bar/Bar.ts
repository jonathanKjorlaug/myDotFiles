import Date from "./buttons/Date";
import SysTray from "./buttons/SysTray";
import SystemIndicators from "./buttons/SystemIndicators";
import Workspaces from "./buttons/Workspaces";
import options from "options";

const { transparent, position } = options.bar;

export type BarWidget = keyof typeof widget;

export default (monitor: number) =>
    Widget.Window({
        monitor,
        class_name: "bar",
        name: `bar${monitor}`,
        exclusivity: "exclusive",
        anchor: ["top", "right", "left"],
        child: Widget.CenterBox({
            css: "min-width: 2px; min-height: 2px;",
            startWidget: Widget.Box({
                hexpand: true,
                children: [Workspaces()],
            }),
            centerWidget: Widget.Box({
                hpack: "center",
                children: [Date()],
            }),
            endWidget: Widget.Box({
                hexpand: true,
                hpack: "end",
                children: [SysTray(), SystemIndicators()],
            }),
        }),
    });
