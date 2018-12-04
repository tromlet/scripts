# Name:     Spam Email Rule Creator
# Purpose:  This script makes it easy to add an email or a domain to the blocked senders
#           list for all users on a domain.
# Author:	Tom Spettigue
# Version:  0.0.1
# Date:     3 December 2018

$ServerFQDN = Read-Host 'Enter the fully-qualified domain name (FQDN) of the Exchange server'

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri "http://$ServerFQDN/PowerShell/" `
    -Authentication Kerberos `
    -Credential $UserCredential

Import-PSSession $Session -DisableNameChecking

Get-Mailbox

Remove-PSSession $Session

