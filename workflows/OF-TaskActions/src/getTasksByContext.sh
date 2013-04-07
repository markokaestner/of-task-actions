#!/bin/bash

QUERY=$1
CONTEXT=${QUERY}

OFOC="com.omnigroup.OmniFocus"
if [ ! -d "$HOME/Library/Caches/$OFOC" ]; then OFOC=$OFOC.MacAppStore; fi

ZONERESET=$(date +%z | awk '
{if (substr($1,1,1)!="+") {printf "+"} else {printf "-"} print substr($1,2,4)}') 
YEARZERO=$(date -j -f "%Y-%m-%d %H:%M:%S %z" "2001-01-01 0:0:0 $ZONERESET" "+%s")
START="($YEARZERO + t.dateToStart)";
DUE="($YEARZERO + t.dateDue)";

SQL="SELECT t.persistentIdentifier, t.name, strftime('%Y-%m-%d|%H:%M',${START}, 'unixepoch'), strftime('%Y-%m-%d|%H:%M',${DUE}, 'unixepoch'), p.name FROM Task t, (Task tt left join ProjectInfo pp ON     tt.persistentIdentifier = pp.pk ) p, Context c WHERE t.blocked = 0 AND t.childrenCountAvailable = 0 AND t.blockedByFutureStartDate = 0 AND t.dateCompleted IS NULL AND t.containingProjectInfo = p.pk AND t.context = c.persistentIdentifier AND c.name = '${CONTEXT}'"

OLDIFS=$IFS
IFS='
'
TASKS=$(sqlite3 ${HOME}/Library/Caches/${OFOC}/OmniFocusDatabase2 "${SQL}")

echo "<?xml version='1.0'?><items>"

for T in ${TASKS[*]}; do
  TID=${T%%|*}
  REST=${T#*|}
  TNAME=${REST%%|*}
  REST=${REST#*|}
  TSTART=${REST%%|*}
  REST=${REST#*|}
  TDUE=${REST%%|*}
  PROJECT=${REST##*|}
  echo "<item uid='oftask' arg='${TID}'><title>${TNAME##*= } (${PROJECT})</title><subtitle>Start: ${TSTART}  |  Due: ${TDUE}  |  Context: ${CONTEXT}</subtitle><icon>icon.png</icon></item>"
done
echo "</items>"

IFS=$OLDIFS
