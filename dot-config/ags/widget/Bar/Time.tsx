import { Astal, Gtk, Gdk, App } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import PanelButton from "../common/PanelButton";

import { CALENDAR_MENU_NAME as WINDOW_NAME } from "../CalendarMenu/CalendarMenu";

export default function ({ format = "%a %b %d %H:%M" }) {
    const time = Variable<string>("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(format)!,
    );

    return (
        <PanelButton
            window={WINDOW_NAME}
            onClicked={() => {
                App.toggle_window(WINDOW_NAME);
            }}
            child=<label
                cssClasses={["Time"]}
                onDestroy={() => time.drop()}
                label={time()}
            />
        />
    );
}
