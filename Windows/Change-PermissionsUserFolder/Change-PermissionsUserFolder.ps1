# Name:     User Folder Permissions Changer
# Purpose:  This script will replace the permissions on a given domain's user folders with
#           user-specific permissions per folder. 
# Author:	Tom Spettigue
# Version:  0.1.2
# Date:     3 December 2018

# Declare your variables!
$users = Get-Content 'D:\TSP1\CRE-user-list.txt'
$path = D:\CRE-DATA\Users


Invoke-Expression -Command ('icacls $path $replaceInherit $Grant "${useraccount1}${permission }"')

New-TransportRule "Blocked Senders to Junk Folder" -HeaderContainsMessageHeader "X-Forefront-Antispam-Report" -HeaderContainsWords "SFV:SKB" -SetSCL 6