#!/usr/bin/env bash
# toggle_batteryguard2080.sh, one click toggle
set -euo pipefail
LAUNCH_AGENTS="${HOME}/Library/LaunchAgents"
PLIST="com.user.batteryguard2080.plist"
PLIST_PATH="${LAUNCH_AGENTS}/${PLIST}"

if [[ ! -f "${PLIST_PATH}" ]]; then
  echo "LaunchAgent not installed. Run install_batteryguard2080.sh first."
  exit 1
fi

if launchctl list | grep -q "com.user.batteryguard2080"; then
  echo "Battery Guard 20/80 is ENABLED. Disabling now..."
  launchctl unload "${PLIST_PATH}"
  echo "Disabled."
else
  echo "Battery Guard 20/80 is DISABLED. Enabling now..."
  launchctl load "${PLIST_PATH}"
  echo "Enabled."
fi
