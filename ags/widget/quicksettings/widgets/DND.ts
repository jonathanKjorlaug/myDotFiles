import { SimpleToggleButton } from "../ToggleButton"
import icons from "lib/icons"

const n = await Service.import("notifications")
const dnd = n.bind("dnd")

export const DND = () => SimpleToggleButton({
    icon: dnd.as(dnd => icons.notifications[dnd ? "silent" : "noisy"]),
    label: dnd.as(dnd => dnd ? "On" : "Off"),
    toggle: () => n.dnd = !n.dnd,
    connection: [n, () => n.dnd],
})
