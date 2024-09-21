import gtk from "./gtk";
import lowBattery from "./batteryNotifications";
import notifications from "./notifications";
import wallpaper from "service/wallpaper";

export default function init() {
    try {
        gtk();
        lowBattery();
        notifications();
    } catch (error) {
        logError(error);
    }
}
