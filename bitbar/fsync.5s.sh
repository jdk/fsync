#!/usr/bin/env bash

# <bitbar.title>Fsync</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Jason Kotzin</bitbar.author>
# <bitbar.author.github>jdk</bitbar.author.github>
# <bitbar.desc>Shows Fsync status</bitbar.desc>
# <bitbar.image>http://photos.paulwrankin.com/screenshots/cpu-load.png</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>

# Test BitBar CPU Load plugin

STATUS=":new_moon:"
STATUS=":last_quarter_moon:"
STATUS=":full_moon:"
	
LOCL_PATH="${HOME}/.fsync/staging"

ignore=(
".excludes"
"*.jpg"
"*.nfo"
"*.png"
".DS_Store"
)
EXCL=''

# Assemble ignore list
for i in "${ignore[@]}"
do
    EXCL+='-not -name '"$i"' '
done

files=()
while IFS=  read -r -d $'\0'; do
	files+=("$REPLY")
done < <(find ${LOCL_PATH} -type f ${EXCL} -print0)

FILES=$(find ${LOCL_PATH} -type f ${EXCL} | sed 's|^.*/||')

if [[ "$#" -ge 1 ]];then
    if [[ "$1" == 'open' ]] ; then
		/usr/bin/open "${files[$2]}"
    fi
    if [[ "$1" == 'dir' ]] ; then
		FILE_PATH=$(echo ${files[$2]} | sed -e 's/\(.*\/\).*/\1/')
		/usr/bin/open "${FILE_PATH}"
    fi
    if [[ "$1" == 'staging' ]] ; then
		/usr/bin/open "${LOCL_PATH}"
    fi
	exit
fi

# Make sure Status is empty
STATUS=

# check to see if lock file present
if [ -f "${HOME}/.fsync/.running_sync" ];
then
	echo ":lock: Syncing: ${#files[@]}"
	sleep 3
	echo ":cyclone: Syncing: ${#files[@]}"
	echo "---"
elif [ -f "${HOME}/.fsync/.running_dump" ];
then
	echo ":lock: Dumping: ${#files[@]}"
	sleep 3
	echo ":full_moon: Dumping: ${#files[@]}"
	echo "---"
elif [ -f "${HOME}/.fsync/.lock" ];
then
	echo ":lock: Incomplete"
elif [ -z "$FILES" ];
then
	STATUS=":new_moon: Fsync"
else
	STATUS=":full_moon: ${#files[@]}"
fi

CLEAN=()
for i in "${files[@]}"
do
	CLEAN+=("$(echo "${i}" | sed 's|^.*/||')")
done

echo ${STATUS} 
echo "---"
for (( i=0; i < ${#CLEAN[@]}; i++))
do
	echo "${CLEAN[$i]} | bash='$0' param1=open param2='$i' terminal=false"
	echo "--open path | bash='$0' param1=dir param2='$i' terminal=false"
done
echo "Open Staging Dir | bash='$0' param1=staging param2='$i' terminal=false"
