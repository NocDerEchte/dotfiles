#!/usr/bin/env bash
#
# Configuration for the left satus bar in tmux

function _show_date() {
  local date

  date=$(date "+%Y-%m-%d")

  printf '%s' "${date}"
}

function main() {
  _show_date
}

main
