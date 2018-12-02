$ouname = Read-Host 'Enter the name of the Organizational Unit you want the list of contents from.'

foreach($line in Get-Content $userlistpath) {
    $counter += 1

    if ($counter > 1) {
        Get-ADUser -Filter {SamAccountName -eq "$line"} -properties Name, SamAccountName, ScriptPath | 
        Format-Table Name, SamAccountName, ScriptPath
    }   else {
        Get-ADUser -Filter {SamAccountName -eq "$line"} -properties Name, SamAccountName, ScriptPath | 
        Format-Table Name, SamAccountName, ScriptPath |
        findstr $line
    }
}