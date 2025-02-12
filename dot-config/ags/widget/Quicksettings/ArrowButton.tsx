import { Astal, Gtk, Gdk, App } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";
import { timeout } from "astal";

export const opened = Variable("");
App.connect("window-toggled", (_: any, name: string, visible: boolean) => {
    if (name === "quicksettings" && !visible)
        timeout(500, () => opened.set(""));
});
