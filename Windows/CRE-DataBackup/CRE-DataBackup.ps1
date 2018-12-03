# Name:     CRE Data Copy
# Purpose:  Single-purpose script to responsibly copy all of the CRE data from the
#		    old CRIMSONMIDSTRM domain controller to the new CRE domain controller.
# Author:	Tom Spettigue
# Version:  0.1.2
# Date:     2 December 2018

# get your list of users
$users = Get-Content # path to file

# map directories beforehand
$logdir = F:\CRE_Move\Logs
$cmsdatadir = D:\CMS-DATA
$hypervip = 192.168.39.14
$oldcredatadir = D:\CMS-DATA\CRE
$newcredatadir = \\192.168.39.14\D$\CRE-DATA
$pfolderbackup = F:\CMS-DATA\Pfolders
$oddpfolderdir = D:\CMS-DATA\CREUsers
$oldpfolderdir = D:\CMS-DATA\Pfolders
$newpfolderdir = \\192.168.39.14\D$\CRE-DATA\pfolders

# primary CRE data transfers (plus one excel file)
# robocopy "$oldcredatadir" "$newcredatadir" /e /mt /xjd /z /r:5 /l /log:"$logdir\20181202_cre_primary_data_backup.log"
robocopy "$cmsdatadir\SRS" "$newcredatadir\SRS" /e /mt /xjd /z /r:5 /l /log:"$logdir\20181202_cre_srs_data_backup.log"

# pfolder CRE data transfers

# Create the new pfolder directory
New-Item -ItemType directory -Path "$newpfolderdir"

foreach($user in Get-Content $users) {
    # First, create the user's pfolder in the correct place
    New-Item -ItemType directory -Path "$newpfolderdir\$user"

    # Then, take the current production pfolders, and robocopy over them.
    robocopy "$oldpfolderdir\$user" "$newpfolderdir\$user" /e /mt /xjd /z /log+:"$logdir\20181202_cre_pfolders_transfer.log"
    
    # Finally, robocopy all of the folders in D:\CMS-DATA\CRE\CREUsers
    robocopy "$oddpfolderdir\$user" "$newpfolderdir\$user" /e /mt /xjd /z /log+:"$logdir\20181202_cre_pfolders_transfer.log"
}

