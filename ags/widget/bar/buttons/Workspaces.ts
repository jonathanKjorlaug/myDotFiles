import PanelButton from "../PanelButton";
import options from "options";
import { sh, range } from "lib/utils";

const hyprland = await Service.import("hyprland");
const { workspaces } = options.bar.workspaces;

const dispatch = (arg: string | number) => {
    sh(`hyprctl dispatch workspace ${arg}`);
};

const Workspaces = (ws: number) =>
    Widget.Box({
        children: range(ws || 20).map((i) =>
            Widget.Label({
                attribute: i,
                vpack: "center",
                label: `${i}`,
                setup: (self) =>
                    self.hook(hyprland, () => {
                        self.toggleClassName(
                            "active",
                            hyprland.active.workspace.id === i,
                        );
                        self.toggleClassName(
                            "occupied",
                            (hyprland.getWorkspace(i)?.windows || 0) > 0,
                        );
                        self.visible = hyprland.workspaces.some(
                            (ws) => ws.id + 1 >= self.attribute,
                        );
                    }),
            }),
        ),
    });

export default () =>
    PanelButton({
        window: "overview",
        class_name: "workspaces",
        css: "border-radius: 0 0 12px 0;",
        on_scroll_up: () => dispatch("m+1"),
        on_scroll_down: () => dispatch("m-1"),
        on_clicked: () => App.toggleWindow("overview"),
        child: workspaces.bind().as(Workspaces),
    });
