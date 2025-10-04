import AstalNetwork from "gi://AstalNetwork";
import { qsPage } from "../Quicksettings";
import { Gtk } from "astal/gtk4";
import { bind, execAsync } from "astal";

async function bash(strings: string | string[], ...values: unknown[]) {
    const cmd =
        typeof strings === "string"
            ? strings
            : strings.flatMap((str, i) => str + `${values[i] ?? ""}`).join("");

    return execAsync(["bash", "-c", cmd]).catch((err) => {
        console.error(cmd, err);
        return "";
    });
}

export default function WifiPage() {
    const wifi = AstalNetwork.get_default().wifi;

    return (
        <box
            name={"wifi"}
            cssClasses={["wifi-page", "qs-page"]}
            vertical
            spacing={6}
        >
            <box hexpand={false} cssClasses={["header"]} spacing={6}>
                <button
                    onClicked={() => {
                        qsPage.set("main");
                    }}
                    iconName={"go-previous-symbolic"}
                />
                <label label={"Wi-Fi"} hexpand xalign={0} />
            </box>
            <Gtk.Separator />
            <Gtk.ScrolledWindow vexpand>
                <box vertical spacing={6}>
                    {bind(wifi, "accessPoints").as((aps) =>
                        aps
                            .filter((ap) => !!ap.ssid)
                            .map((accessPoint) => {
                                return (
                                    <button
                                        cssClasses={bind(wifi, "ssid").as(
                                            (ssid) => {
                                                const classes = ["button"];
                                                ssid === accessPoint.ssid &&
                                                    classes.push("active");
                                                return classes;
                                            },
                                        )}
                                        onClicked={() => {
                                            bash(
                                                `nmcli device wifi connect ${accessPoint.bssid}`,
                                            );
                                        }}
                                    >
                                        <box>
                                            <image
                                                iconName={accessPoint.iconName}
                                            />
                                            <label label={accessPoint.ssid} />
                                        </box>
                                    </button>
                                );
                            }),
                    )}
                </box>
            </Gtk.ScrolledWindow>
        </box>
    );
}
