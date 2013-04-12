#!/bin/bash

QUERY=$1

OFOC="com.omnigroup.OmniFocus"
if [ ! -d "$HOME/Library/Caches/Metadata/$OFOC" ]; then OFOC=$OFOC.MacAppStore; fi

OLDIFS=$IFS
IFS='
'
PROJECTS=($(mdfind -onlyin ~/Library/Caches/Metadata/${OFOC} "kMDItemTitle == '*${QUERY}*'c"))

echo "<?xml version='1.0'?><items>"

for P in ${PROJECTS[*]}; do
  P_DATA=$(mdls ${P})
  PNAME=$(echo "$P_DATA" |grep "kMDItemTitle")
  PNAME=${PNAME##*= \"}
  PNAME=${PNAME%%\"*}
  PFOLDER=$(echo "$P_DATA" |grep "com_omnigroup_OmniFocus_DirectFolderName")
  PFOLDER=${PFOLDER##*= \"}
  PFOLDER=${PFOLDER%%\"*}
  PSTATUS=$(echo "$P_DATA" |grep "com_omnigroup_OmniFocus_Status")
  PSTATUS=${PSTATUS##*= \"}
  PSTATUS=${PSTATUS%%\"*}
  TASKCOUNT=$(echo "$P_DATA" |grep "com_omnigroup_OmniFocus_TaskCount")

  echo "<item uid='ofproject' arg='${PNAME}'><title>${PNAME} (${PFOLDER})</title><subtitle>Status: ${PSTATUS}  |  Tasks: ${TASKCOUNT##*= }</subtitle><icon>img/project.png</icon></item>"
done

echo "</items>"

IFS=$OLDIFS
