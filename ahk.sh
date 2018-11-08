#!/bin/bash

# Issue: Unable to paste a number of users/groups in Bitbucket using Stash. stash only accepts the first user and then waits an "Enter" from the user or a "Click" on the name of the user. 

# PURPOSE: This script generates a script for AutoHotKey software. Once ./type_enter.ahk is generated it can be used as a an autohotkey script. 
# To run the .ahk script, just start it and you can use it by pressing "Win+V" combination.

set -o errexit
set -o nounset
#set -o xtrace

#printf '#v:: ;Hotkey Win+V\n\n{\n'; cat list_of_users.txt| xargs -I {} sed -e 's/user/'{}'/g' templates.txt; printf '}\nreturn\n' 
USAGE="\nUsage: ahk.sh list_of_users.txt
list_of_users.txt - any filename with list of users, splitted with lines

e.g.:\ncat ./list.txt\n\ngroup1_readonly\ngroup2_readonly\n\n"

[[ -z ${1+x} ]] && { printf "$USAGE"; exit 1; }

GROUPSORUSERS=$1
AHK_TEMPLATE=/tmp/ahk_template.txt
printf "        Send {Enter}user{Enter}\n        Sleep, 1000\n" > $AHK_TEMPLATE
printf '#v:: ;Hotkey Win+V\n\n{\n'; cat $GROUPSORUSERS | xargs -I {} sed -e 's/user/'{}'/g' $AHK_TEMPLATE; printf '        Send {Enter}\n}\nreturn\n' | sudo tee ./type_enter.ahk
