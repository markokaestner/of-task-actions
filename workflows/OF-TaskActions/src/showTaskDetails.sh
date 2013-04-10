#!/bin/bash

THEME="dark"
TMPDIR="${HOME}/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.markokaestner.oftaskactions"

if [ ! -d "$TMPDIR" ]; then
  exit
fi

if [ ! -f "$TMPDIR/task" ]; then
  exit
fi

TASK=$(cat "${TMPDIR}/task")

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

echo "<?xml version='1.0'?><items>"
echo "<item uid='ofnavaction' arg='back'><title>Back</title><subtitle></subtitle><icon>img/detail/${THEME}/back.png</icon></item>"
echo "<item uid='oftaskaction' arg='done'><title>Complete</title><subtitle></subtitle><icon>img/detail/${THEME}/done.png</icon></item>"
if [ "${TFLAGGED}" = "0" ]; then
  echo "<item uid='oftaskaction' arg='flag'><title>Flag</title><subtitle></subtitle><icon>img/detail/${THEME}/flag.png</icon></item>"
else
  echo "<item uid='oftaskaction' arg='unflag'><title>Un-Flag</title><subtitle></subtitle><icon>img/detail/${THEME}/flag.png</icon></item>"
fi
echo "<item uid='oftaskaction' arg='view'><title>Show in OF</title><subtitle></subtitle><icon>img/detail/${THEME}/view.png</icon></item>"
echo "<item uid='oftaskinfo' arg='' valid='no'><title>${TNAME}</title><subtitle>Title</subtitle><icon>img/detail/${THEME}/task${TSOON}${TOVERDUE}.png</icon></item>"
echo "<item uid='oftaskinfo' arg='' valid='no'><title>${PROJECT}</title><subtitle>Project</subtitle><icon>img/detail/${THEME}/project.png</icon></item>"
echo "<item uid='oftaskinfo' arg='' valid='no'><title>${CONTEXT}</title><subtitle>Context</subtitle><icon>img/detail/${THEME}/context.png</icon></item>"
echo "<item uid='oftaskinfo' arg='' valid='no'><title>${TSTART}</title><subtitle>Start</subtitle><icon>img/detail/${THEME}/cal.png</icon></item>"
echo "<item uid='oftaskinfo' arg='' valid='no'><title>${TDUE}</title><subtitle>Due</subtitle><icon>img/detail/${THEME}/cal.png</icon></item>"
echo "</items>"

IFS="$OLDIFS"
