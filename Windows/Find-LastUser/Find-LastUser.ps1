$ComputerName = Read-Host -Prompt "Enter the name of the computer you're trying to find the last user on: "

(Get-WmiObject -Class win32_process -ComputerName $ComputerName | Where-Object name -Match explorer).getowner().user

Get-ChildItem "\\$ComputerName\c$\Users" | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime -first 1
