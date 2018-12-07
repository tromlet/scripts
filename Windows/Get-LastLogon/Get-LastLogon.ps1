# Name:     Domain Logon Finder
# Purpose:  This script will fetch the last logon time/date of the users in a domain, and spit it out to a .csv file.
# Author:	Tom Spettigue
# Version:  0.1.1
# Date:     7 December 2018

$users = Read-Host 'Enter the path to the file containing active directory users, by username, one per line'
$outputpath = Read-Host 'Enter the path to the file where you want the user information to be stored'

function Record-LastLogon () {
    "Display Name,AD Username,Last Logon,Email" | Out-File -FilePath $outputpath

    foreach($username in Get-Content $users) {
        $user = Get-ADUser -Filter {SamAccountName -eq $username} -Properties *
        
        if ($user.proxyAddresses -ne $null) {
            $email = ($user.proxyAddresses | findstr SMTP).ToString().Remove(0,5)
        } else {
            $email = "No Email Address"
        }
        
        $user.DisplayName + ","`
         + $user.SamAccountName + ","`
         + [datetime]::FromFileTime($user.LastLogon).ToString('d MMM yyyy hh:mm:ss')`
         + $email`
         | Out-File -FilePath $outputpath -Append
    }
}

Record-LastLogon