#!/usr/bin/env bash
set -euo pipefail
LAUNCH_AGENTS="${HOME}/Library/LaunchAgents"
PLIST="com.user.batteryguard2080.plist"
APP_DIR="${HOME}/Library/Application Support/BatteryGuard20_80"

launchctl unload "${LAUNCH_AGENTS}/com.user.batteryguard2080.plist" 2>/dev/null || true
rm -f "${LAUNCH_AGENTS}/com.user.batteryguard2080.plist" 2>/dev/null || true
rm -rf "${APP_DIR}" 2>/dev/null || true

echo "Battery Guard 20/80 removed."
