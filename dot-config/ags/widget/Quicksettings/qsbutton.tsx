import { Astal, Gtk, Gdk } from "astal/gtk4";
import { Variable, GLib, bind } from "astal";

type QSMenuProps = {
    child: Gtk.Widget;
    iconName: string;
    label: string;
    setup: () => void;
    cssClasses: string[];
};

export function QSMenuButton({
    child,
    iconName,
    label,
    setup,
    cssClasses,
}: QSMenuProps) {
    return (
        <menubutton
            setup={setup}
            cssClasses={cssClasses ?? ["qs-button"]}
            tooltipText={label}
        >
            <image halign={Gtk.Align.CENTER} iconName={iconName} />
            {child}
        </menubutton>
    );
}

type QSButtonProps = {
    iconName: string;
    label: string;
    setup: () => void;
    onClicked: () => void;
    cssClasses: string[];
};
export default function QSButton({
    iconName,
    label,
    setup,
    onClicked,
    cssClasses,
}: QSButtonProps) {
    return (
        <button
            setup={setup}
            cssClasses={cssClasses ?? ["qs-button"]}
            onClicked={onClicked}
            tooltipText={label}
        >
            <image iconName={iconName} halign={Gtk.Align.CENTER} />
        </button>
    );
}
