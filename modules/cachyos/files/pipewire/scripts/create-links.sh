#!/bin/sh
sleep 2 # hackyyyyy
pw-link 'Chatot Out - OBS Monitoring:monitor_1' X18/XR18:playback_AUX4
pw-link 'Chatot Out - OBS Monitoring:monitor_2' X18/XR18:playback_AUX4
pw-link 'Chatot Out - Discord:monitor_1' X18/XR18:playback_AUX5
pw-link 'Chatot Out - Discord:monitor_2' X18/XR18:playback_AUX5
pw-link X18/XR18:capture_AUX4 'Chatot In - VOD Ignored:input_1'
pw-link X18/XR18:capture_AUX5 'Chatot In - VOD Ignored:input_2'
pw-link 'Chatot Out - PC 1:monitor_1' X18/XR18:playback_AUX0
pw-link 'Chatot Out - PC 1:monitor_2' X18/XR18:playback_AUX1
pw-link 'Chatot Out - PC 2:monitor_1' X18/XR18:playback_AUX2
pw-link 'Chatot Out - PC 2:monitor_2' X18/XR18:playback_AUX3
pw-link X18/XR18:capture_AUX2 'Chatot In - Mic:input_1'
pw-link X18/XR18:capture_AUX3 'Chatot In - Mic:input_2'
pw-link X18/XR18:capture_AUX6 'Chatot In - Stream Mix:input_1'
pw-link X18/XR18:capture_AUX7 'Chatot In - Stream Mix:input_2'