#!/bin/bash

. workflowHandler.sh

THEME=$(getPref theme 1)
TASK=$(getPref task 0)
SEARCH=$(getPref lastSearch 0)

OLDIFS="$IFS"
IFS="|"

T=($TASK)

TID=${T[0]}
TNAME=${T[1]}
TSTART=${T[2]}
TDUE=${T[3]}
TSOON=${T[4]}
TOVERDUE=${T[5]}
TFLAGGED=${T[6]}
TREPTYPE=${T[7]}
TREPRULE=${T[8]}
CONTEXT=${T[9]}
PROJECT=${T[10]}
TDONE=${T[11]}

RANDOMUID=$(date +"%s")=

addResult "${RANDOMUID}1" "back" "yes" "Back" "Go back to previous search" "img/detail/${THEME}/back.png"

if [ "$TDONE" = "1" ]; then
  addResult "${RANDOMUID}2" "done" "yes" "${TNAME}" "Klick to uncheck" "img/detail/${THEME}/done.png"
else
  addResult "${RANDOMUID}3" "done" "yes" "${TNAME}" "Klick to check" "img/detail/${THEME}/task${TSOON}${TOVERDUE}.png"
fi
addResult "${RANDOMUID}4" "gotoproject" "yes" "${PROJECT}" "Project" "img/detail/${THEME}/project.png"
addResult "${RANDOMUID}5" "gotocontext" "yes" "${CONTEXT}" "Context" "img/detail/${THEME}/context.png"
addResult "${RANDOMUID}6" "deferstart" "yes" "${TSTART}" "Start date" "img/detail/${THEME}/cal.png"
addResult "${RANDOMUID}7" "deferdue" "yes" "${TDUE}" "Due date" "img/detail/${THEME}/cal.png"

if [ "${TFLAGGED}" = "0" ]; then
  addResult "${RANDOMUID}8" "flag" "yes" "Flag" "Flag the task" "img/detail/${THEME}/flag.png"
else
  addResult "${RANDOMUID}9" "flag" "yes" "Un-Flag" "Un-Flag the task" "img/detail/${THEME}/flag.png"
fi
addResult "${RANDOMUID}10" "${SEARCH:4:1}view" "yes" "Show in OF" "Open the task in OF" "img/detail/${THEME}/view.png"

getXMLResults

IFS="$OLDIFS"
