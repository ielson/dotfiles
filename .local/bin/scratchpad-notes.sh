#!/usr/bin/env bash
set -euo pipefail

SCRATCH_NAME="scratch"
FILE="$HOME/fleeting_notes"

# app-id/classe única do terminal do scratchpad
TERM_APPID="scratchpad-term"
TITLE="Scratchpad"

# garante o arquivo
[ -f "$FILE" ] || : > "$FILE"

# se já existe algo no special, apenas alterna
if hyprctl -j clients | grep -q "\"workspace\":.*\"special\":true"; then
  hyprctl dispatch togglespecialworkspace "$SCRATCH_NAME"
  exit 0
fi

# se já existe nossa janela (por classe/app-id), alterna
if hyprctl -j clients | grep -q "\"class\": *\"$TERM_APPID\""; then
  hyprctl dispatch togglespecialworkspace "$SCRATCH_NAME"
  exit 0
fi

# --- LANCE APENAS UMA das opções abaixo ---

# KITTY (recomendado): --class define app-id (Wayland) / WM_CLASS (X11)
kitty --class "$TERM_APPID" --title "$TITLE" nvim --cmd 'set notitle' "$FILE" &

sleep 0.15
hyprctl dispatch movetoworkspace "special:$SCRATCH_NAME"
hyprctl dispatch togglespecialworkspace "$SCRATCH_NAME"
