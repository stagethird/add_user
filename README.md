# Add User (add_user.sh)
This Bash script will create a new user account from a name passed as an input argument.
If no argument / name is provided the script will ask for one.
The script will:
* Take the user through the interactive 'adduser' process
* Copy a list of  user directories from a template (i.e. Desktop, Documents, Downloads...)
* Prompt the user for an account name to copy group memberships from. If one is provided
all of it's group memberships will be duplicated for the new account. This step can be 
skipped by simply pressing [Enter] when prompted for a name.
