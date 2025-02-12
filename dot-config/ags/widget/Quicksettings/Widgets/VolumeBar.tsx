import Wp from "gi://AstalWp";
import { bind, Binding, Variable } from "astal";
import { App, Gtk } from "astal/gtk4";
import { WINDOW_NAME } from "../Quicksettings";

/**
 * An Endpoint is either a speaker or microphone
 *
 * @param defaultEndpoint either [Wp.Audio.default_speaker] or [Wp.Audio.default_microphone]
 * @param getIcon function that takes an Endpoint and returns the proper string icon
 * @param endpointsBinding binding obtained via [bind(Wp.Audio, "speakers")] or [bind(Wp.Audio, "microphones"]
 */
export default function () {
    const { audio } = Wp.get_default()!;
    const speaker = audio.defaultSpeaker;
    const endpointChooserRevealed = Variable(false);

    const endpointLabelVar = Variable.derive([
        bind(speaker, "description"),
        bind(speaker, "volume"),
        bind(speaker, "mute"),
    ]);

    setTimeout(() => {
        bind(App.get_window(WINDOW_NAME)!, "visible").subscribe((visible) => {
            if (!visible) {
                endpointChooserRevealed.set(false);
            }
        });
    }, 1_000);

    return (
        <box vertical={true}>
            <box vertical={false} cssClasses={["row"]}>
                <button
                    cssClasses={["systemMenuIconButton"]}
                    iconName={bind(speaker, "volumeIcon")}
                    onClicked={() => {
                        speaker.set_mute(!speaker.mute);
                    }}
                />
                <slider
                    hexpand
                    onChangeValue={(self) => {
                        speaker.volume = self.value;
                    }}
                    value={bind(speaker, "volume")}
                />
                <button
                    cssClasses={["iconButton"]}
                    label={endpointChooserRevealed((revealed): string => {
                        if (revealed) {
                            return "";
                        } else {
                            return "";
                        }
                    })}
                    onClicked={() => {
                        endpointChooserRevealed.set(
                            !endpointChooserRevealed.get(),
                        );
                    }}
                />
            </box>
            <revealer
                cssClasses={["rowRevealer"]}
                revealChild={endpointChooserRevealed()}
                transitionDuration={200}
                transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
            >
                <box vertical={true}>
                    {bind(audio, "speakers").as((endpoints) => {
                        return endpoints.map((endpoint) => {
                            return (
                                <button
                                    hexpand={true}
                                    cssClasses={["transparentButton"]}
                                    onClicked={() => {
                                        endpoint.set_is_default(true);
                                    }}
                                >
                                    <label
                                        halign={Gtk.Align.START}
                                        cssClasses={["labelSmall"]}
                                        label={bind(endpoint, "isDefault").as(
                                            (isDefault) => {
                                                if (isDefault) {
                                                    return `  ${endpoint.description}`;
                                                } else {
                                                    return `   ${endpoint.description}`;
                                                }
                                            },
                                        )}
                                    />
                                </button>
                            );
                        });
                    })}
                </box>
            </revealer>
        </box>
    );
}
