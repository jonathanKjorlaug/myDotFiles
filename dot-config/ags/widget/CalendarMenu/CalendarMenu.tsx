import {
    App,
    Astal,
    Gtk,
    Gdk,
    astalify,
    type ConstructProps,
} from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import GObject from "gi://GObject";
import PopupWindow from "../common/PopupWindow";
import NotificationWindow from "./NotificationWindow";

type CalendarProps = ConstructProps<
    Gtk.Calendar,
    Gtk.Calendar.ConstructorProps
>;
const Calendar = astalify<Gtk.Calendar, Gtk.Calendar.ConstructorProps>(
    Gtk.Calendar,
    {
        // if it is a container widget, define children setter and getter here
        getChildren(self) {
            return [];
        },
        setChildren(self, children) {},
    },
);

export const CALENDAR_MENU_NAME = "calendarmenu";

export default function (_gdkmonitor: Gdk.Monitor) {
    function setup(button: Gtk.Calendar) {}
    return (
        <PopupWindow
            name={CALENDAR_MENU_NAME}
            layout="top_center"
            animation="slide top"
            child=<box
                cssClasses={["window-content", "calendarmenu"]}
                hexpand={false}
                vertical={false}
            >
                <NotificationWindow />
                <Calendar
                    setup={setup}
                    onDaySelected={(self) => {
                        print(self.day);
                    }}
                />
            </box>
        ></PopupWindow>
    );
}
