#!/bin/bash

QUERY=$1

OFOC="com.omnigroup.OmniFocus"
if [ ! -d "$HOME/Library/Caches/$OFOC" ]; then OFOC=$OFOC.MacAppStore; fi

SQL="SELECT p.pk, t.name, p.status, p.numberOfAvailableTasks, p.numberOfRemainingTasks, p.containsSingletonActions, f.name FROM (ProjectInfo p LEFT JOIN Task t ON p.task=t.persistentIdentifier) LEFT JOIN Folder f ON p.folder=f.persistentIdentifier WHERE p.status = 'active' AND lower(t.name) LIKE lower('%${QUERY}%') ORDER BY p.containsSingletonActions DESC, t.name ASC"

OLDIFS=$IFS
IFS='
'
PROJECTS=$(sqlite3 ${HOME}/Library/Caches/${OFOC}/OmniFocusDatabase2 "${SQL}")

echo "<?xml version='1.0'?><items>"

for P in ${PROJECTS[*]}; do
  PID=${P%%|*}
  REST=${P#*|}
  PNAME=${REST%%|*}
  REST=${REST#*|}
  PSTATUS=${REST%%|*}
  REST=${REST#*|}
  PAVAILABLE=${REST%%|*}
  REST=${REST#*|}
  PREMAINING=${REST%%|*}
  REST=${REST#*|}
  PSINGLE=${REST%%|*}
  PFOLDER=${REST##*|}
  echo "<item uid='${PID}' arg='${PNAME}'><title>${PNAME} (${PFOLDER})</title><subtitle>Status: ${PSTATUS}  |  Available Tasks: ${PAVAILABLE}</subtitle><icon>img/project${PSINGLE}.png</icon></item>"
done
echo "</items>"

IFS=$OLDIFS
