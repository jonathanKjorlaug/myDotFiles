import Network from "gi://AstalNetwork?version=0.1";
import QSButton from "../qsbutton";
import { bind } from "astal";

export default function () {
    const network = Network.get_default();
    return (
        <QSButton
            visible={bind(network, "wifi").as(Boolean)}
            cssClasses={bind(network, "wifi").as((mute) => {
                const classes = ["qs-button"];
                !mute && classes.push("active");
                return classes;
            })}
            iconName={bind(network.wifi, "iconName")}
            label={"Wifi toggle"}
            onClicked={() => {
                const enabled = network.wifi.enabled;
                network.wifi.set_enabled(!enabled);
            }}
        />
    );
}
