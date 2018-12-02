# Find-LogonScript
#  Date: 30 November 2018
#  Version: 0.0.1
#  Author: Tom Spettigue

$userlistpath = Read-Host 'Enter the full path to the file containing a list of users.'
$counter = 0

foreach($line in Get-Content $userlistpath) {
    $counter += 1

    if ($counter -gt 1) {
        Get-ADUser -Filter {SamAccountName -eq "$line"} -properties Name, SamAccountName, ScriptPath | 
        Format-Table Name, SamAccountName, ScriptPath
    }   else {
        Get-ADUser -Filter {SamAccountName -eq "$line"} -properties Name, SamAccountName, ScriptPath | 
        Format-Table Name, SamAccountName, ScriptPath |
        findstr $line
    }
}

