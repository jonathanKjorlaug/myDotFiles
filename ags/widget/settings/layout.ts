/* eslint-disable max-len */
import Row from "./Row";
import Group from "./Group";
import Page from "./Page";
import options from "options";
import icons from "lib/icons";

const {
    autotheme: at,
    font,
    theme,
    bar: b,
    launcher: l,
    overview: ov,
    powermenu: pm,
    quicksettings: qs,
    osd,
    hyprland: h,
} = options;

const {
    dark,
    light,
    blur,
    scheme,
    padding,
    spacing,
    radius,
    shadows,
    widget,
    border,
} = theme;

export default [
    Page(
        "Theme",
        icons.ui.themes,
        Group(
            "",
            Row({ opt: at, title: "Auto Generate Color Scheme" }),
            Row({
                opt: scheme,
                title: "Color Scheme",
                type: "enum",
                enums: ["dark", "light"],
            }),
        ),
        Group(
            "Dark Colors",
            Row({ opt: dark.bg, title: "Background", type: "color" }),
            Row({ opt: dark.fg, title: "Foreground", type: "color" }),
            Row({ opt: dark.primary.bg, title: "Primary", type: "color" }),
            Row({ opt: dark.primary.fg, title: "On Primary", type: "color" }),
            Row({ opt: dark.error.bg, title: "Error", type: "color" }),
            Row({ opt: dark.error.fg, title: "On Error", type: "color" }),
            Row({ opt: dark.widget, title: "Widget", type: "color" }),
            Row({ opt: dark.border, title: "Border", type: "color" }),
        ),
        Group(
            "Light Colors",
            Row({ opt: light.bg, title: "Background", type: "color" }),
            Row({ opt: light.fg, title: "Foreground", type: "color" }),
            Row({ opt: light.primary.bg, title: "Primary", type: "color" }),
            Row({ opt: light.primary.fg, title: "On Primary", type: "color" }),
            Row({ opt: light.error.bg, title: "Error", type: "color" }),
            Row({ opt: light.error.fg, title: "On Error", type: "color" }),
            Row({ opt: light.widget, title: "Widget", type: "color" }),
            Row({ opt: light.border, title: "Border", type: "color" }),
        ),
        Group(
            "Theme",
            Row({ opt: shadows, title: "Shadows" }),
            Row({ opt: widget.opacity, title: "Widget Opacity", max: 100 }),
            Row({ opt: border.opacity, title: "Border Opacity", max: 100 }),
            Row({ opt: border.width, title: "Border Width" }),
            Row({ opt: blur, title: "Blur", note: "0 to disable", max: 70 }),
        ),
        Group(
            "UI",
            Row({ opt: padding, title: "Padding" }),
            Row({ opt: spacing, title: "Spacing" }),
            Row({ opt: radius, title: "Roundness" }),
            Row({ opt: font.size, title: "Font Size" }),
            Row({ opt: font.name, title: "Font Name", type: "font" }),
        ),
    ),
    Page(
        "Bar",
        icons.ui.toolbars,
        Group(
            "General",
            Row({
                opt: b.transparent,
                title: "Transparent Bar",
                note: "Works best on empty-ish wallpapers",
            }),
            Row({ opt: b.flatButtons, title: "Flat Buttons" }),
            Row({
                opt: b.position,
                title: "Position",
                type: "enum",
                enums: ["top", "bottom"],
            }),
            Row({ opt: b.corners, title: "Corners" }),
        ),
        Group(
            "Launcher",
            Row({ opt: b.launcher.icon.icon, title: "Icon" }),
            Row({ opt: b.launcher.icon.colored, title: "Colored Icon" }),
            Row({ opt: b.launcher.label.label, title: "Label" }),
            Row({ opt: b.launcher.label.colored, title: "Colored Label" }),
        ),
        Group(
            "Workspaces",
            Row({
                opt: b.workspaces.workspaces,
                title: "Number of Workspaces",
                note: "0 to make it dynamic",
            }),
        ),
        Group(
            "Taskbar",
            Row({ opt: b.taskbar.iconSize, title: "Icon Size" }),
            Row({ opt: b.taskbar.monochrome, title: "Monochrome" }),
            Row({ opt: b.taskbar.exclusive, title: "Exclusive to workspaces" }),
        ),
        Group("Date", Row({ opt: b.date.format, title: "Date Format" })),
        Group(
            "Media",
            Row({ opt: b.media.monochrome, title: "Monochrome" }),
            Row({ opt: b.media.preferred, title: "Preferred Player" }),
            Row({
                opt: b.media.direction,
                title: "Slide Direction",
                type: "enum",
                enums: ["left", "right"],
            }),
            Row({ opt: b.media.format, title: "Format of the Label" }),
            Row({ opt: b.media.length, title: "Max Length of Label" }),
        ),
        Group(
            "Battery",
            Row({
                opt: b.battery.bar,
                title: "Style",
                type: "enum",
                enums: ["hidden", "regular", "whole"],
            }),
            Row({ opt: b.battery.blocks, title: "Number of Blocks" }),
            Row({ opt: b.battery.width, title: "Width of Bar" }),
            Row({
                opt: b.battery.charging,
                title: "Charging Color",
                type: "color",
            }),
        ),
        Group(
            "Powermenu",
            Row({ opt: b.powermenu.monochrome, title: "Monochrome" }),
        ),
    ),
    Page(
        "General",
        icons.ui.settings,
        Group(
            "Hyprland",
            Row({ opt: h.gapsWhenOnly, title: "Gaps When Only" }),
            Row({
                opt: h.inactiveBorder,
                type: "color",
                title: "Inactive Border Color",
            }),
        ),
        Group(
            "Launcher",
            Row({ opt: l.width, title: "Width" }),
            Row({ opt: l.apps.iconSize, title: "Icon Size" }),
            Row({ opt: l.apps.max, title: "Max Items" }),
        ),
        Group(
            "Overview",
            Row({ opt: ov.scale, title: "Scale", max: 100 }),
            Row({
                opt: ov.workspaces,
                title: "Workspaces",
                max: 11,
                note: "set this to 0 to make it dynamic",
            }),
            Row({ opt: ov.monochromeIcon, title: "Monochrome Icons" }),
        ),
        Group(
            "Powermenu",
            Row({
                opt: pm.layout,
                title: "Layout",
                type: "enum",
                enums: ["box", "line"],
            }),
            Row({ opt: pm.labels, title: "Show Labels" }),
        ),
        Group(
            "Quicksettings",
            Row({ opt: qs.avatar.image, title: "Avatar", type: "img" }),
            Row({ opt: qs.avatar.size, title: "Avatar Size" }),
            Row({
                opt: qs.media.monochromeIcon,
                title: "Media Monochrome Icons",
            }),
            Row({ opt: qs.media.coverSize, title: "Media Cover Art Size" }),
        ),
        Group(
            "On Screen Indicator",
            Row({ opt: osd.progress.vertical, title: "Vertical" }),
            Row({
                opt: osd.progress.pack.h,
                title: "Horizontal Alignment",
                type: "enum",
                enums: ["start", "center", "end"],
            }),
            Row({
                opt: osd.progress.pack.v,
                title: "Vertical Alignment",
                type: "enum",
                enums: ["start", "center", "end"],
            }),
        ),
    ),
] as const;
