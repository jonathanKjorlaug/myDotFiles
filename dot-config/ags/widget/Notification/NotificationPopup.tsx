import { timeout } from "astal";
import { App, Astal, Gdk } from "astal/gtk4";
import AstalNotifd from "gi://AstalNotifd?version=0.1";
import Notification from "./Notification";

export default function NotificationPopup(gdkmonitor: Gdk.Monitor) {
    const { TOP, RIGHT } = Astal.WindowAnchor;
    const notifd = AstalNotifd.get_default();

    return (
        <window
            namespace={"notification-popup"}
            setup={(self) => {
                const notificationQueue: number[] = [];
                let isProcessing = false;

                notifd.connect("notified", (_, id) => {
                    if (notifd.dont_disturb) return;
                    notificationQueue.push(id);
                    processQueue();
                });

                notifd.connect("resolved", (_, __) => {
                    self.visible = false;
                    isProcessing = false;
                    timeout(300, () => {
                        processQueue();
                    });
                });

                function processQueue() {
                    if (isProcessing || notificationQueue.length === 0) return;
                    isProcessing = true;
                    const id: any = notificationQueue.shift();

                    self.set_child(
                        Notification({ n: notifd.get_notification(id) }),
                    );
                    self.visible = true;

                    timeout(5000, () => {
                        self.set_child(null);
                        self.visible = false;
                        isProcessing = false;
                        timeout(300, () => {
                            processQueue();
                        });
                    });
                }
            }}
            gdkmonitor={gdkmonitor}
            application={App}
            anchor={TOP | RIGHT}
        ></window>
    );
}
