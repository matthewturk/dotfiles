#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
folder=$(basename "$cwd")

# Git branch (skip optional locks)
branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" -c gc.auto=0 symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context window usage
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# 5-hour session rate limit
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')

# 7-day weekly rate limit
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Format a unix timestamp as time remaining (e.g. "1h23m")
time_remaining() {
  local ts="$1"
  if [ -z "$ts" ]; then return; fi
  local now diff h m
  now=$(date +%s)
  diff=$(( ts - now ))
  if [ "$diff" -le 0 ]; then
    echo "now"
    return
  fi
  h=$(( diff / 3600 ))
  m=$(( (diff % 3600) / 60 ))
  if [ "$h" -gt 0 ]; then
    printf "%dh%02dm" "$h" "$m"
  else
    printf "%dm" "$m"
  fi
}

# Build output parts
parts=()

# Folder + branch
if [ -n "$branch" ]; then
  parts+=("$(printf '\033[0;36m%s\033[0m \033[0;33m(%s)\033[0m' "$folder" "$branch")")
else
  parts+=("$(printf '\033[0;36m%s\033[0m' "$folder")")
fi

# Model
if [ -n "$model" ]; then
  parts+=("$(printf '\033[0;96m%s\033[0m' "$model")")
fi

# Context usage
if [ -n "$ctx_used" ]; then
  ctx_int=$(printf "%.0f" "$ctx_used")
  parts+=("$(printf 'ctx:\033[0;32m%d%%\033[0m' "$ctx_int")")
fi

# 5-hour session usage + refresh
if [ -n "$five_pct" ]; then
  five_int=$(printf "%.0f" "$five_pct")
  five_remain=$(time_remaining "$five_reset")
  if [ -n "$five_remain" ]; then
    parts+=("$(printf '5h:\033[0;35m%d%%\033[0m resets:%s' "$five_int" "$five_remain")")
  else
    parts+=("$(printf '5h:\033[0;35m%d%%\033[0m' "$five_int")")
  fi
fi

# 7-day usage + refresh
if [ -n "$week_pct" ]; then
  week_int=$(printf "%.0f" "$week_pct")
  week_remain=$(time_remaining "$week_reset")
  if [ -n "$week_remain" ]; then
    parts+=("$(printf '7d:\033[0;35m%d%%\033[0m resets:%s' "$week_int" "$week_remain")")
  else
    parts+=("$(printf '7d:\033[0;35m%d%%\033[0m' "$week_int")")
  fi
fi

# Join with separator
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="$result $(printf '\033[0;90m|\033[0m') $part"
  fi
done

printf "%b" "$result"