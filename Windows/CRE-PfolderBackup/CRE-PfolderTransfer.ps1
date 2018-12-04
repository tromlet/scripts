# Name:     CRE Data Copy
# Purpose:  Single-purpose script to responsibly copy all of the CRE data from the
#		    old CRIMSONMIDSTRM domain controller to the new CRE domain controller.
# Author:	Tom Spettigue
# Version:  0.1.2
# Date:     2 December 2018

# get your list of users
$users = Get-Content 'F:\CRE_Move\CRE-user-list.txt'
New-Item -ItemType directory -Path "$newpfolderdir"

foreach($user in Get-Content $users) {
    # First, create the user's pfolder in the correct place
    New-Item -ItemType directory -Path "$newpfolderdir\$user"

    # Then, take the current production pfolders, and robocopy over them.
    robocopy "$oldpfolderdir\$user" "$newpfolderdir\$user" /e /mt /xjd /z /log+:"$logdir\20181202_cre_pfolders_transfer.log"
    
    # Finally, robocopy all of the folders in D:\CMS-DATA\CRE\CREUsers
    robocopy "$oddpfolderdir\$user" "$newpfolderdir\$user" /e /mt /xjd /z /log+:"$logdir\20181202_cre_pfolders_transfer.log"
}

