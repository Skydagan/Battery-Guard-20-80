#!/usr/bin/env bash
set -euo pipefail
APP_DIR="${HOME}/Library/Application Support/BatteryGuard20_80"
LAUNCH_AGENTS="${HOME}/Library/LaunchAgents"
PLIST="com.user.batteryguard2080.plist"

mkdir -p "${APP_DIR}" "${LAUNCH_AGENTS}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

cp "${SCRIPT_DIR}/monitor_battery.sh" "${APP_DIR}/monitor_battery.sh"
chmod +x "${APP_DIR}/monitor_battery.sh"
cp "${SCRIPT_DIR}/com.user.batteryguard2080.plist" "${LAUNCH_AGENTS}/com.user.batteryguard2080.plist"

launchctl unload "${LAUNCH_AGENTS}/com.user.batteryguard2080.plist" 2>/dev/null || true
launchctl load "${LAUNCH_AGENTS}/com.user.batteryguard2080.plist"

echo "Installed Battery Guard 20/80. Checks every 5 minutes. Alerts at >=80% on AC, <=20% on Battery."
