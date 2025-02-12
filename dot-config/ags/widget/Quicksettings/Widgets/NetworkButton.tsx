import AstalNetwork from "gi://AstalNetwork";
import { bind, Variable } from "astal";
import { Gtk, App } from "astal/gtk4";
import { execAsync } from "astal/process";
import { WINDOW_NAME } from "../Quicksettings";

const wifiConnections = Variable<string[]>([]);
const activeWifiConnections = Variable<string[]>([]);

function ssidInRange(ssid: string) {
    const network = AstalNetwork.get_default();

    return (
        network.wifi.accessPoints.find((accessPoint) => {
            return accessPoint.ssid === ssid;
        }) != null
    );
}

function updateConnections() {
    // update active connections
    execAsync(["bash", "-c", `nmcli -t -f NAME,TYPE connection show --active`])
        .catch((error) => {
            print(error);
        })
        .then((value) => {
            if (typeof value !== "string") {
                return;
            }

            const wifiNames = value
                .split("\n")
                .filter((line) => line.includes("802-11-wireless"))
                .map((line) => line.split(":")[0].trim())
                .sort((a, b) => {
                    const aInRange = ssidInRange(a);
                    const bInRange = ssidInRange(b);
                    if (aInRange && bInRange) {
                        return 0;
                    } else if (aInRange) {
                        return -1;
                    } else {
                        return 1;
                    }
                });

            activeWifiConnections.set(wifiNames);
        })
        .finally(() => {
            // update inactive connections
            execAsync(["bash", "-c", `nmcli -t -f NAME,TYPE connection show`])
                .catch((error) => {
                    print(error);
                })
                .then((value) => {
                    if (typeof value !== "string") {
                        return;
                    }

                    const wifiNames = value
                        .split("\n")
                        .filter((line) => line.includes("802-11-wireless"))
                        .map((line) => line.split(":")[0].trim())
                        .filter(
                            (line) =>
                                !activeWifiConnections.get().includes(line),
                        )
                        .sort((a, b) => {
                            const aInRange = ssidInRange(a);
                            const bInRange = ssidInRange(b);
                            if (aInRange && bInRange) {
                                return 0;
                            } else if (aInRange) {
                                return -1;
                            } else {
                                return 1;
                            }
                        });

                    wifiConnections.set(wifiNames);
                });
        });
}

function deleteConnection(ssid: string) {
    execAsync(["bash", "-c", `nmcli connection delete "${ssid}"`]).finally(
        () => {
            updateConnections();
        },
    );
}

function PasswordEntry({
    accessPoint,
    passwordEntryRevealed,
}: {
    accessPoint: AstalNetwork.AccessPoint;
    passwordEntryRevealed: Variable<boolean>;
}) {
    const text = Variable("");

    const connect = () => {
        execAsync([
            "bash",
            "-c",
            `echo '${text.get()}' | nmcli device wifi connect "${accessPoint.ssid}" --ask`,
        ])
            .catch((error) => {
                print(error);
            })
            .then((value) => {
                print(value);
            })
            .finally(() => {
                passwordEntryRevealed.set(false);
                updateConnections();
            });
    };

    return (
        <box vertical={true} spacing={4}>
            {accessPoint.flags !== 0 && (
                <box vertical={true}>
                    <label
                        halign={Gtk.Align.START}
                        cssClasses={["labelSmall"]}
                        label="Password"
                    />
                    <entry
                        cssClasses={["networkPasswordEntry"]}
                        text={text()}
                        onChanged={(self) => text.set(self.text)}
                        onActivate={() => connect()}
                    />
                </box>
            )}
            <button
                cssClasses={["primaryButton"]}
                hexpand={true}
                label="Connect"
                onClicked={() => connect()}
            />
        </box>
    );
}

function WifiConnections() {
    const network = AstalNetwork.get_default();

    return (
        <box vertical={true}>
            <label
                halign={Gtk.Align.START}
                cssClasses={["labelLargeBold"]}
                label="Saved networks"
            />
            {wifiConnections((connectionsValue) => {
                return connectionsValue.map((connection) => {
                    const buttonsRevealed = Variable(false);

                    setTimeout(() => {
                        bind(App.get_window(WINDOW_NAME)!, "visible").subscribe(
                            (visible) => {
                                if (!visible) {
                                    buttonsRevealed.set(false);
                                }
                            },
                        );
                    }, 1_000);

                    let label: string;
                    let icon: string;
                    let canConnect: boolean;
                    const accessPoint = network.wifi.accessPoints.find(
                        (accessPoint) => {
                            return accessPoint.ssid === connection;
                        },
                    );
                    if (accessPoint != null) {
                        icon = bind(network.wifi, "get_icon_name").as(String);
                        label = connection;
                        canConnect =
                            network.wifi.activeAccessPoint.ssid !== connection;
                    } else {
                        icon = "network-wireless-hardware-disabled-symbolic";
                        label = connection;
                        canConnect = false;
                    }

                    return (
                        <box vertical={true}>
                            <button
                                hexpand={true}
                                cssClasses={["iconButton"]}
                                onClicked={() => {
                                    buttonsRevealed.set(!buttonsRevealed.get());
                                }}
                            >
                                <image
                                    iconName={icon}
                                    halign={Gtk.Align.START}
                                    cssClasses={["labelSmall"]}
                                />

                                <label
                                    halign={Gtk.Align.START}
                                    cssClasses={["labelSmall"]}
                                    label={label}
                                />
                            </button>
                            <revealer
                                revealChild={buttonsRevealed()}
                                transitionDuration={200}
                                transitionType={
                                    Gtk.RevealerTransitionType.SLIDE_DOWN
                                }
                            >
                                <box vertical={true} spacing={4}>
                                    {canConnect && (
                                        <button
                                            hexpand={true}
                                            cssClasses={["primaryButton"]}
                                            label="Connect"
                                            onClicked={() => {
                                                execAsync(
                                                    `nmcli c up ${connection}`,
                                                )
                                                    .catch((error) => {
                                                        print(error);
                                                    })
                                                    .finally(() => {
                                                        updateConnections();
                                                    });
                                            }}
                                        />
                                    )}
                                    <button
                                        hexpand={true}
                                        cssClasses={["primaryButton"]}
                                        label="Forget"
                                        onClicked={() => {
                                            deleteConnection(connection);
                                        }}
                                    />
                                </box>
                            </revealer>
                        </box>
                    );
                });
            })}
        </box>
    );
}

function WifiScannedConnections() {
    const network = AstalNetwork.get_default();

    return (
        <box vertical={true}>
            {bind(network.wifi, "scanning").as((scanning) => {
                if (scanning) {
                    return (
                        <label
                            halign={Gtk.Align.START}
                            cssClasses={["labelLargeBold"]}
                            label="Scanning…"
                        />
                    );
                } else {
                    const accessPoints = network.wifi.accessPoints;

                    const accessPointsUi = accessPoints
                        .filter((value) => {
                            return (
                                value.ssid != null &&
                                wifiConnections.get().find((connection) => {
                                    return value.ssid === connection;
                                }) == null
                            );
                        })
                        .sort((a, b) => {
                            if (a.strength > b.strength) {
                                return -1;
                            } else {
                                return 1;
                            }
                        })
                        .map((accessPoint) => {
                            const passwordEntryRevealed = Variable(false);

                            setTimeout(() => {
                                bind(
                                    App.get_window(WINDOW_NAME)!,
                                    "visible",
                                ).subscribe((visible) => {
                                    if (!visible) {
                                        passwordEntryRevealed.set(false);
                                    }
                                });
                            }, 1_000);

                            return (
                                <box vertical={true}>
                                    <box vertical={false}>
                                        <button
                                            hexpand={true}
                                            cssClasses={["iconButton"]}
                                            onClicked={() => {
                                                passwordEntryRevealed.set(
                                                    !passwordEntryRevealed.get(),
                                                );
                                            }}
                                        >
                                            <image
                                                halign={Gtk.Align.START}
                                                cssClasses={["labelSmall"]}
                                                iconName={bind(
                                                    network.wifi,
                                                    "iconName",
                                                )}
                                            />
                                            <label
                                                halign={Gtk.Align.START}
                                                cssClasses={["labelSmall"]}
                                                label={accessPoint.ssid}
                                            />
                                        </button>
                                    </box>
                                    <revealer
                                        revealChild={passwordEntryRevealed()}
                                        transitionDuration={200}
                                        transitionType={
                                            Gtk.RevealerTransitionType
                                                .SLIDE_DOWN
                                        }
                                    >
                                        <PasswordEntry
                                            accessPoint={accessPoint}
                                            passwordEntryRevealed={
                                                passwordEntryRevealed
                                            }
                                        />
                                    </revealer>
                                </box>
                            );
                        });

                    return (
                        <box vertical={true}>
                            <label
                                halign={Gtk.Align.START}
                                cssClasses={["labelLargeBold"]}
                                label="Available networks"
                            />
                            {accessPointsUi}
                        </box>
                    );
                }
            })}
        </box>
    );
}

export function getNetworkNameBinding() {
    const network = AstalNetwork.get_default();

    if (network.wifi != null) {
        const variable = Variable.derive([
            bind(network, "primary"),
            bind(network, "wifi"),
            bind(network.wifi, "ssid"),
        ]);

        return variable((value) => {
            const primary = value[0];
            const wifi = value[1];
            if (primary === AstalNetwork.Primary.WIFI) {
                return wifi.ssid;
            } else if (primary === AstalNetwork.Primary.WIRED) {
                return "Wired";
            } else if (network.wired !== null) {
                return "Wired";
            } else if (network.wifi !== null) {
                return network.wifi.ssid;
            } else {
                return "Not connected";
            }
        });
    } else {
        const variable = Variable.derive([
            bind(network, "primary"),
            bind(network, "wifi"),
        ]);

        return variable((value) => {
            const primary = value[0];
            const wifi = value[1];
            if (primary === AstalNetwork.Primary.WIFI) {
                return wifi.ssid;
            } else if (primary === AstalNetwork.Primary.WIRED) {
                return "Wired";
            } else if (network.wired !== null) {
                return "Wired";
            } else if (network.wifi !== null) {
                return network.wifi.ssid;
            } else {
                return "Not connected";
            }
        });
    }
}

export default function () {
    const network = AstalNetwork.get_default();
    const networkChooserRevealed = Variable(false);

    updateConnections();

    setTimeout(() => {
        bind(App.get_window(WINDOW_NAME)!, "visible").subscribe((visible) => {
            if (!visible) {
                networkChooserRevealed.set(false);
            } else {
                updateConnections();
            }
        });
    }, 1_000);

    const networkName = Variable.derive([getNetworkNameBinding()]);

    return (
        <box vertical={true}>
            <box vertical={false} cssClasses={["row"]}>
                <image
                    cssClasses={["systemMenuIconButton"]}
                    iconName={bind(network.wifi, "iconName")}
                />
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    label={networkName().as((value) => {
                        const networkNameValue = value[0];
                        return networkNameValue;
                    })}
                />
                <button
                    cssClasses={["iconButton"]}
                    label={networkChooserRevealed((revealed): string => {
                        if (revealed) {
                            return "";
                        } else {
                            return "";
                        }
                    })}
                    onClicked={() => {
                        networkChooserRevealed.set(
                            !networkChooserRevealed.get(),
                        );
                        if (networkChooserRevealed.get()) {
                            network.wifi?.scan();
                        }
                    }}
                />
            </box>
            <revealer
                cssClasses={["rowRevealer"]}
                revealChild={networkChooserRevealed()}
                transitionDuration={200}
                transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
            >
                <box vertical={true}>
                    {network.wifi &&
                        bind(network.wifi, "activeAccessPoint").as(
                            (activeAccessPoint) => {
                                return (
                                    <button
                                        cssClasses={["primaryButton"]}
                                        label="Forget"
                                        onClicked={() => {
                                            deleteConnection(
                                                activeAccessPoint.ssid,
                                            );
                                        }}
                                    />
                                );
                            },
                        )}
                    {network.wifi && (
                        <WifiConnections connections={wifiConnections} />
                    )}
                    <box />
                    {network.wifi && <WifiScannedConnections />}
                </box>
            </revealer>
        </box>
    );
}
