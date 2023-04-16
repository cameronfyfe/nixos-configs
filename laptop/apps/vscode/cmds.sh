#!/usr/bin/env bash

settings_file=/home/cameron/.config/VSCodium/User/settings.json

function rust_inlays_enable() {
  jq '
    .["rust-analyzer.inlayHints.typeHints.enable"] = true
  | .["rust-analyzer.inlayHints.parameterHints.enable"] = true
  | .["rust-analyzer.inlayHints.chainingHints.enable"] = true
  ' $settings_file | sponge $settings_file
}

function rust_inlays_disable() {
  jq '
    .["rust-analyzer.inlayHints.typeHints.enable"] = false
  | .["rust-analyzer.inlayHints.parameterHints.enable"] = false
  | .["rust-analyzer.inlayHints.chainingHints.enable"] = false
  ' $settings_file | sponge $settings_file
}

CMDS="\
rust_inlays_enable \
rust_inlays_disable \
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
