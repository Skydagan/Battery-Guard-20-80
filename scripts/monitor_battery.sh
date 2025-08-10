#!/usr/bin/env bash
# monitor_battery.sh for Battery Guard 20/80
# High alert: >= 80% on AC, suggest unplugging.
# Low alert: <= 20% on Battery, suggest plugging in.
# Hysteresis prevents repeat notifications.
set -euo pipefail

STATE_DIR="${HOME}/.local/share/batteryguard2080"
HIGH_STATE="${STATE_DIR}/notified_high"
LOW_STATE="${STATE_DIR}/notified_low"
mkdir -p "${STATE_DIR}"

battery_info="$(pmset -g batt)"
percent="$(echo "$battery_info" | grep -Eo '[0-9]+%' | head -n1 | tr -d '%')"

power_source="Battery"
if echo "$battery_info" | grep -q "AC Power"; then
  power_source="AC"
fi

if [[ -z "${percent}" ]]; then
  exit 0
fi

HIGH_UPPER=80
HIGH_LOWER=78

LOW_LOWER=20
LOW_UPPER=22

high_notified="no"
low_notified="no"
[[ -f "${HIGH_STATE}" ]] && high_notified="yes"
[[ -f "${LOW_STATE}" ]] && low_notified="yes"

if [[ "${percent}" -lt "${HIGH_LOWER}" || "${power_source}" != "AC" ]]; then
  rm -f "${HIGH_STATE}" 2>/dev/null || true
  high_notified="no"
fi

if [[ "${percent}" -gt "${LOW_UPPER}" || "${power_source}" != "Battery" ]]; then
  rm -f "${LOW_STATE}" 2>/dev/null || true
  low_notified="no"
fi

if [[ "${power_source}" == "AC" && "${percent}" -ge "${HIGH_UPPER}" && "${high_notified}" == "no" ]]; then
  /usr/bin/osascript -e 'display notification "Battery at or above 80%, you can unplug now" with title "Battery Guard 20/80"'
  touch "${HIGH_STATE}"
fi

if [[ "${power_source}" == "Battery" && "${percent}" -le "${LOW_LOWER}" && "${low_notified}" == "no" ]]; then
  /usr/bin/osascript -e 'display notification "Battery at or below 20%, consider plugging in" with title "Battery Guard 20/80"'
  touch "${LOW_STATE}"
fi

exit 0
