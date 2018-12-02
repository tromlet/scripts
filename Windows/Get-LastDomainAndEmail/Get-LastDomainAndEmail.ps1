$users = Read-Host 'Enter the full path to the text file containing a list of usernames, with one username per line'
$csv = Read-Host 'Enter the full path to where you want the .csv file to be saved'

echo "Name,Username,Last Logon,ProxyAddresses" > $csv

foreach($user in Get-Content $users) {
    $line = ""

    $aduser = Get-ADUser -Filter {SamAccountName -eq "$user"} -properties 
    
    $firstlastname = $aduser.Name
    $samacctname = $aduser.SamAccountName
    $mostrecentlogon = [datetime]::FromFileTime($aduser.LastLogon).ToString('dd MMM yyyy HHmm')
    $proxyaddr = $aduser.ProxyAddresses

    $line = "$firstlastname,$samacctname,$mostrecentlogon,$proxyaddr" 
    
    echo $line >> $csv
}