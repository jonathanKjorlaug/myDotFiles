import Bluetooth from "gi://AstalBluetooth?version=0.1";
import QSButton from "../qsbutton";
import { bind } from "astal";

export default function () {
    const bluetooth = Bluetooth.get_default();
    return (
        <QSButton
            visible={bind(bluetooth, "is_powered").as(Boolean)}
            cssClasses={bind(bluetooth, "is_powered").as((mute) => {
                const classes = ["qs-button"];
                !mute && classes.push("active");
                return classes;
            })}
            iconName={bind(bluetooth, "is_powered").as((powered) =>
                powered
                    ? "bluetooth-active-symbolic"
                    : "bluetooth-disabled-symbolic",
            )}
            label={"Bluetooth toggle"}
            onClicked={() => {
                const enabled = bluetooth.get_is_powered();
                bluetooth.adapter.set_powered(!enabled);
            }}
        />
    );
}
