#!/bin/bash

# Script for adding new users

if [ $# -eq 0 ]; then # if number of command line args = 0
    read -p "Enter a username:" user
else
    user=$1
fi
sudo adduser $user
# starts interactive script.

array=(Arduino Desktop Documents Downloads Music Pictures)
# array  containing the directories to be duplicated

for i in "${array[@]}"; do
    sudo cp -r /home/template/$i /home/$user/.
    sudo chown -R $user /home/$user
    sudo chgrp -R $user /home/$user
done
# adds directories and files from template

echo "Enter the name of an account whos group memberships you want to duplicate,"
read -p "or <Enter> for none:" acct
if [ "$acct" != "" ]; then
    read myGroups < <(sudo awk -F: -v acct="$acct" '$4 ~ acct {print $1}' ORS="," /etc/group)
    # This mess uses awk to extract the group memberships of the user $acct from /etc/group
    # using 'ORS=","' (Output Record Seperator) to keep all of the records on one line
    # Then it redirects awks output to the varible 'myGroups' (thats why it all has to be on one line).

    myGroups2=${myGroups%?}
    # This just removes the last char from 'myGroups', saves to 'myGroups2'.
    # 'myGroups' as extraced using awk ends up with a trailing comma that effs everything up

    sudo usermod -a -G $myGroups2 $user
    # This adds the user $user to the groups $myGroups using -a (append) and -G (group(s))

    echo "Group memberships updated."
else
    echo "No group changes made"
fi
