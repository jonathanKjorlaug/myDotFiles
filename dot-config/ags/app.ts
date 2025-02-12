import { App } from "astal/gtk4";
import style from "./style/style.scss";
import Bar from "./widget/Bar/Bar";
import Quicksettings from "./widget/Quicksettings/Quicksettings";
import CalendarMenu from "./widget/CalendarMenu/CalendarMenu";
import NotificationPopup from "./widget/Notification/NotificationPopup";
import Volume from "./widget/osd/Volume";
import Brightness from "./widget/osd/Brightness";

App.start({
    css: style,
    // instanceName: "astal",
    requestHandler(request, res) {
        print(request);
        res("ok");
    },
    main: () => [
        App.get_monitors().map(Bar),
        App.get_monitors().map(Quicksettings),
        App.get_monitors().map(CalendarMenu),
        App.get_monitors().map(NotificationPopup),
        App.get_monitors().map(Volume),
        App.get_monitors().map(Brightness),
    ],
});

let countVolume = 0;
let volumeInterval: any;

let countBrightness = 0;
let brightnessInterval: any;

App.requestHandler = (request, res) => {
    if (request === "show_brightness") {
        let brightness_window = App.get_window("brightness");
        if (brightness_window) {
            brightness_window.visible = true;
        }
        countBrightness = 2;
        if (brightnessInterval == null) {
            brightnessInterval = setInterval(() => {
                countBrightness--;
                if (countBrightness < 1) {
                    clearInterval(brightnessInterval);
                    if (brightness_window) {
                        brightness_window.visible = false;
                    }
                    brightnessInterval = null;
                }
            }, 1000);
        }
        return res("ok");
    }
    if (request === "show_volume") {
        let volume_window = App.get_window("volume");
        if (volume_window) {
            volume_window.visible = true;
        }
        countVolume = 2;
        if (volumeInterval == null) {
            volumeInterval = setInterval(() => {
                if (volume_window?.has_focus) {
                    countVolume = 2;
                } else {
                    countVolume--;
                    if (countVolume < 1) {
                        clearInterval(volumeInterval);
                        if (volume_window) {
                            volume_window.visible = false;
                        }
                        volumeInterval = null;
                    }
                }
            }, 1000);
        }
        return res("ok");
    }

    return res("huh?");
};
