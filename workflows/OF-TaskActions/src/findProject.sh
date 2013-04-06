#!/bin/bash

QUERY=$1

OFOC="com.omnigroup.OmniFocus"
if [ ! -d "$HOME/Library/Caches/Metadata/$OFOC" ]; then OFOC=$OFOC.MacAppStore; fi

OLDIFS=$IFS
IFS='
'
PROJECTS=($(mdfind -onlyin ~/Library/Caches/Metadata/${OFOC} "kMDItemTitle == '*${QUERY}*'"))

#echo ${#PROJECTS[@]}

echo "<?xml version='1.0'?><items>"

for P in ${PROJECTS[*]}; do
  PNAME=$(mdls ${P} |grep "kMDItemTitle")
  PNAME=${PNAME##*= \"}
  PNAME=${PNAME%%\"*}
  PFOLDER=$(mdls ${P} |grep "com_omnigroup_OmniFocus_DirectFolderName")
  PFOLDER=${PFOLDER##*= \"}
  PFOLDER=${PFOLDER%%\"*}
  PSTATUS=$(mdls ${P} |grep "com_omnigroup_OmniFocus_Status")
  PSTATUS=${PSTATUS##*= \"}
  PSTATUS=${PSTATUS%%\"*}
  TASKCOUNT=$(mdls ${P} |grep "com_omnigroup_OmniFocus_TaskCount")

  echo "<item uid='${P##*/}' arg='${PNAME}'><title>${PNAME} (${PFOLDER})</title><subtitle>Status: ${PSTATUS}  |  Tasks: ${TASKCOUNT##*= }</subtitle><icon>icon.png</icon></item>"
done

echo "</items>"

IFS=$OLDIFS
