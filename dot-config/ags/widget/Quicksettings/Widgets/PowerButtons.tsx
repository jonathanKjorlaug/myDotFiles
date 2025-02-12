import { App, Gtk } from "astal/gtk4";
import { execAsync } from "astal/process";
import { WINDOW_NAME } from "../Quicksettings";

export default function () {
    return (
        <box vertical={false} cssClasses={["row"]}>
            <button
                cssClasses={["PowerButton"]}
                iconName={"system-log-out-symbolic"}
                onClicked={() => {
                    App.toggle_window(WINDOW_NAME);
                    execAsync("uwsm stop");
                }}
            />
            <button
                cssClasses={["PowerButton"]}
                iconName={"system-reboot-symbolic"}
                onClicked={() => {
                    App.toggle_window(WINDOW_NAME);
                    execAsync("systemctl reboot");
                }}
            />
            <button
                cssClasses={["PowerButton"]}
                iconName={"system-shutdown-symbolic"}
                onClicked={() => {
                    App.toggle_window(WINDOW_NAME);
                    execAsync("systemctl poweroff");
                }}
            />
        </box>
    );
}
