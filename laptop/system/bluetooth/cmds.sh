#!/usr/bin/env bash

function _get_headphones_index() {
  echo $( \
    pacmd list-cards \
    | grep bluez_card -B1 \
    | grep index \
    | awk '{print $2}' \
  )
}

function _get_headphones_mac_address() {
  local mac="38:18:4C:3E:B4:5F"
  # To get while connected:
  # local tmp=$( \
  #   pacmd list-cards \
  #   | grep bluez_card -C20 \
  #   | grep 'device.string' \
  #   | cut -d' ' -f 3 \
  # )
  # tmp="${tmp%\"}"
  # local mac="${tmp#\"}"
  echo "$mac"
}

function _bluetoothctl() {
  local op=$1
  local mac=$2
  echo -e "$op $mac\n quit" | bluetoothctl
}

function _set_headphones_profile() {
  local profile=$1
  local hp_index=$(_get_headphones_index)
  pacmd set-card-profile $hp_index $profile
}

function headphones_connect() {
  local hp_mac=$(_get_headphones_mac_address)
  _bluetoothctl "connect" $hp_mac
}

function headphones_disconnect() {
  local hp_mac=$(_get_headphones_mac_address)
  _bluetoothctl "disconnect" $hp_mac
}

function headphones_set_a2dp() {
  _set_headphones_profile "a2dp_sink"
}

function headphones_set_hfp() {
  _set_headphones_profile "handsfree_head_unit"
}

function headphones_set_off() {
  _set_headphones_profile "off"
}

function headphones_get_profile() {
  local mac=$(_get_headphones_mac_address)
  local card="card.${mac//:/_}."
  local prof=$( \
    pacmd list-cards \
    | grep $card -m1 -A100 \
    | grep "active profile:" -m1 \
  )
  prof=${prof#*<}
  prof=${prof%>*}

  case $prof in
    handsfree_head_unit) echo "HFP"  ;;
    a2dp_sink)           echo "A2DP" ;;
    off)                 echo "OFF"  ;;
    *)                   echo "???"  ;;
  esac
}


CMDS="\
headphones_connect \
headphones_disconnect \
headphones_set_a2dp \
headphones_set_hfp \
headphones_set_off \
headphones_get_profile \
"

function main() {
  local CMD=$1; shift
  if [[ " ${CMDS[*]} " =~ " $CMD " ]]; then
    $CMD $@
  else
    echo "Invalid command '$CMD'."
    echo "Valid commands are:"
    echo $CMDS
  fi
}

main $@
