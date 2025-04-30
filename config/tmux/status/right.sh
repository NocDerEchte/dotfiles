#!/usr/bin/env bash
#
# Configuration for the left satus bar in tmux

function _delimiter() {
  printf "%s" " | "
}

function _kube_info() {
  local kube_current_context kube_cluster kube_namespace

  if [[ $(which kubectl) ]]; then
    kube_current_context="$(kubectl config get-contexts | grep '\*')"
    kube_cluster="$(echo "${kube_current_context}" | awk '{print $3}')"
    kube_namespace="$(echo "${kube_current_context}" | awk '{print $5}')"

    printf '%s' "󱃾 ${kube_cluster}:${kube_namespace}"
  fi

}

function _memory_usage() {
  local mem_total mem_available mem_usage using_percent

  mem_total="$(grep 'MemTotal' '/proc/meminfo' | awk '{print $2}')"
  mem_available="$(grep 'MemAvailable' '/proc/meminfo' | awk '{print $2}')"
  mem_usage="$(("${mem_total}" - "${mem_available}"))"
  using_percent="$(("${mem_usage}" * 100 / "${mem_total}" ))"

  printf '%s' "mem: ${using_percent}%"
}

function main() {
  _kube_info
  _delimiter
  _memory_usage
}

main
