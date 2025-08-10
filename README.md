# Battery Guard 20/80 for macOS

Keeps your battery in the sweet spot with simple alerts, no extra apps.
- On AC power at or above 80 percent, notification to unplug.
- On battery at or below 20 percent, notification to plug in.
Hysteresis avoids spam, high alert resets below 78 percent or when leaving AC, low alert resets above 22 percent or when connecting AC.

## Files
- `scripts/monitor_battery.sh` checker script
- `scripts/com.user.batteryguard2080.plist` LaunchAgent
- `scripts/install_batteryguard2080.sh` installer
- `scripts/uninstall_batteryguard2080.sh` remover
- `scripts/toggle_batteryguard2080.sh` one click enable or disable

## Install
```
// Assuming this project is zipped and in your /Downloads directory
cd ~/Downloads
unzip battery_guard_20_80.zip
bash battery_guard_20_80/scripts/install_batteryguard2080.sh
```

## Toggle on or off
```
bash ~/Downloads/battery_guard_20_80/scripts/toggle_batteryguard2080.sh
```

## Test manually
```
/bin/bash -lc "~/Library/Application Support/BatteryGuard20_80/monitor_battery.sh"
```

## Uninstall
```
bash ~/Downloads/battery_guard_20_80/scripts/uninstall_batteryguard2080.sh
```

## Notes
- Uses only built in tools, pmset for battery state and osascript for notifications.
- To change cadence, edit `StartInterval` in the plist, 300 means 5 minutes.
- To change thresholds, edit HIGH_UPPER, HIGH_LOWER, LOW_LOWER, and LOW_UPPER in `monitor_battery.sh`.
