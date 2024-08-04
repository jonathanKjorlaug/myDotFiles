let icon = Widget.Icon({
    hpack: "end",
});

let iconUpdate = () => {
    Utils.execAsync(`bash -c "checkupdates | wc -l"`).then((updates) => {
        if (Number(updates) >= 50) {
            icon.icon = [
                [200, "software-update-urgent-symbolic"],
                [50, "software-update-available-symbolic"],
            ].find(([threshold]) => threshold <= updates)?.[1];
            icon.visible = true;
        } else {
            icon.visible = false;
        }
    });
};

export function updateTracker() {
    Utils.interval(
        10000,
        () => {
            iconUpdate();
        },
        icon,
    );

    Utils.timeout(1, () => {
        icon.visible = false;
    });
    return icon;
}
