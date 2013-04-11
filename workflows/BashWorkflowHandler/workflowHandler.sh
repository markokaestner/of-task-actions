#!/bin/bash

VPREFS="${HOME}/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/"
NVPREFS="${HOME}/Library/Application Support/Alfred 2/Workflow Data/"

RESULTS=()

################################################################################
# Adds a result to the result array
#
# $1 uid
# $2 arg
# $3 valid
# $4 title
# $5 subtitle
# $6 icon
# $7 autocomplete
###############################################################################
addResult() {
  RESULT="<item uid='$1' arg='$2' valid='$3' autocomplete='$7'><title>$4</title><subtitle>$5</subtitle><icon>$6</icon></item>"
  RESULTS+=("$RESULT")
}

###############################################################################
# Prints the feedback xml to stdout
###############################################################################
getXMLResults() {
  echo "<?xml version='1.0'?><items>"

  for R in ${RESULTS[*]}; do
    echo "$R" | tr '\n' ' '
  done

  echo "</items>"
}

###############################################################################
# Read the bundleid from the workflow's info.plist
###############################################################################
getBundleId() {
  /usr/libexec/PlistBuddy  -c "Print :bundleid" "info.plist"
}

###############################################################################
# Save key=value to the workflow properties
#
# $1 key
# $2 value
# $3 non-volatile 0/1
###############################################################################
setPref() {
  local BUNDLEID=$(getBundleId)
  if [ "$3" = "0" ]; then
    local PREFDIR="${VPREFS}${BUNDLEID}"
  else
    local PREFDIR="${NVPREFS}${BUNDLEID}"
  fi

  if [ ! -d "$PREFDIR" ]; then
    mkdir -p "$PREFDIR"
  fi

  local PREFFILE="${PREFDIR}/settings"
  if [ ! -f "$PREFFILE" ]; then
    touch "$PREFFILE"
  fi

  local KEY_EXISTS=$(grep -c "$1=" "$PREFFILE")
  if [ "$KEY_EXISTS" = "0" ]; then
    echo "$1=$2" >> "$PREFFILE"
  else
    sed -i "" "s/$1=.*/$1=$2/" "$PREFFILE"
  fi
}

###############################################################################
# Read a value for a given key from the workflow preferences
#
# $1 key
# $2 non-volatile 0/1
###############################################################################
getPref() {
  local BUNDLEID=$(getBundleId)
  if [ "$2" = "0" ]; then
    local PREFDIR="${VPREFS}${BUNDLEID}"
  else
    local PREFDIR="${NVPREFS}${BUNDLEID}"
  fi

  if [ ! -d "$PREFDIR" ]; then
    return
  fi

  local PREFFILE="${PREFDIR}/settings"
  if [ ! -f "$PREFFILE" ]; then
    return
  fi

  local VALUE=$(sed "/^\#/d" "$PREFFILE" | grep "$1"  | tail -n 1 | cut -d "=" -f2-)
  echo "$VALUE"
}
