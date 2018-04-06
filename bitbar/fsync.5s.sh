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

FILES=$(find ~/.fsync/staging/ -type f -not -name '.excludes' -not -name '.DS_Store' | sed 's|^.*/||')
COUNT=$(find ~/.fsync/staging/ -type f -not -name '.excludes' -not -name '.DS_Store' | sed 's|^.*/||' | wc -l)

# check to see if lock file present
if [ -f "${HOME}/.fsync/lock" ];
then
    STATUS=":cyclone: Syncing"
fi

if [ -z "$FILES" ];
then
	STATUS=":new_moon: Fsync"
else
	STATUS=":full_moon: ${COUNT}"
fi

echo ${STATUS} 
echo "---"
find ~/.fsync/staging/ -type f -not -name '.excludes' -not -name '.DS_Store' | sed 's|^.*/||'
