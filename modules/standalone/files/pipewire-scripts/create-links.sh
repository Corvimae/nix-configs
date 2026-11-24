#!/bin/sh
sleep 2 # hackyyyyy
pw-link 'Chatot Out - OBS Monitoring:monitor_1' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX4
pw-link 'Chatot Out - OBS Monitoring:monitor_2' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX5
pw-link 'Chatot Out - Discord:monitor_1' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX6
pw-link 'Chatot Out - Discord:monitor_2' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX7
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX4 'Chatot In - VOD Ignored:input_1'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX5 'Chatot In - VOD Ignored:input_2'
pw-link 'Chatot Out - PC 1:monitor_1' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX0
pw-link 'Chatot Out - PC 1:monitor_2' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX1
pw-link 'Chatot Out - PC 2:monitor_1' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX2
pw-link 'Chatot Out - PC 2:monitor_2' alsa_output.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-output:playback_AUX3
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX0 'Chatot In - Mic:input_1'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX1 'Chatot In - Mic:input_2'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX2 'Chatot In - Stream Mix:input_1'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX3 'Chatot In - Stream Mix:input_2'
# pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX6 'Chatot In - Stream Mix:input_1'
# pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX7 'Chatot In - Stream Mix:input_2'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX6 'Chatot In - Aux:input_1'
pw-link alsa_input.usb-BEHRINGER_WING_010113U0604AAE214-00.multichannel-input:capture_AUX7 'Chatot In - Aux:input_2'