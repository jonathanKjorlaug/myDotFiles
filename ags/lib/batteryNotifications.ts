import icons from "./icons";

export default async function init() {
    const bat = await Service.import("battery");
    let percent = bat.percent;

    bat.connect("changed", () => {
        if (percent == bat.percent) return;
        if (bat.charging) return;
        percent = bat.percent;

        if (percent !== 30) return;

        Utils.notify({
            summary: `Low battery`,
            iconName: icons.battery.warning,
            urgency: "normal",
        });

        if (percent !== 10) return;

        Utils.notify({
            summary: `Battery about to go out`,
            iconName: icons.battery.critical,
            urgency: "critical",
        });
    });
}
