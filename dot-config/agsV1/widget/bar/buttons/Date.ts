import { clock } from "lib/variables";
import PanelButton from "../PanelButton";
import options from "options";

const { format, action } = options.bar.date;
const time = Utils.derive(
    [clock, format],
    (c, f) => c.format("%a %b %d %H:%M") || "",
);

export default () =>
    PanelButton({
        window: "datemenu",
        on_clicked: action.bind(),
        css: "border-radius: 0 0 12px 12px;",
        child: Widget.Label({
            justification: "center",
            label: time.bind(),
        }),
    });
