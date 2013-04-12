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

addResult "ofnavaction" "back" "yes" "Back" "Go back to previous search" "img/detail/${THEME}/back.png"
addResult "oftaskaction" "done" "yes" "Complete" "Mark task completed" "img/detail/${THEME}/done.png"
if [ "${TFLAGGED}" = "0" ]; then
  addResult "oftaskaction" "flag" "yes" "Flag" "Flag the task" "img/detail/${THEME}/flag.png"
else
  addResult "oftaskaction" "unflag" "yes" "Un-Flag" "Un-Flag the task" "img/detail/${THEME}/flag.png"
fi
addResult "oftaskaction" "${SEARCH:4:1}view" "yes" "Show in OF" "Open the task in OF" "img/detail/${THEME}/view.png"

addResult "oftaskinfo" "-" "no" "${TNAME}" "Task name" "img/detail/${THEME}/task${TSOON}${TOVERDUE}.png"
addResult "oftaskinfo" "-" "no" "${PROJECT}" "Project" "img/detail/${THEME}/project.png"
addResult "oftaskinfo" "-" "no" "${CONTEXT}" "Context" "img/detail/${THEME}/context.png"
addResult "oftaskinfo" "-" "no" "${TSTART}" "Start date" "img/detail/${THEME}/cal.png"
addResult "oftaskinfo" "-" "no" "${TDUE}" "Due date" "img/detail/${THEME}/cal.png"

getXMLResults

IFS="$OLDIFS"
