# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

$ErrorActionPreference = 'silentlycontinue'
$rules = Get-NetFirewallRule | Select-Object -Property DisplayName, Description, Action, Direction, Enabled, InstanceID
$portsAndProtocols = Get-NetFirewallPortFilter | Select-Object -Property LocalPort, Protocol, InstanceID

foreach ($rule in $rules) {
    $ruleDetails = $portsAndProtocols | Where-Object {$_.instanceID -eq $rule.instanceID}
    $xml += "<FIREWALLRULES>`n"
    $xml += "<DISPLAYNAME>"+ $rule.DisplayName +"</DISPLAYNAME>`n" 
    $xml += "<DESCRIPTION>"+ $rule.Description +"</DESCRIPTION>`n"
    $xml += "<ENABLED>"+ $rule.Enabled +"</ENABLED>`n"
    $xml += "<DIRECTION>"+ $rule.Direction +"</DIRECTION>`n"
    $xml += "<ACTION>"+ $rule.Action +"</ACTION>`n"
    $xml += "<PORT>"+ $ruleDetails.LocalPort +"</PORT>`n"
    $xml += "<PROTOCOL>"+ $ruleDetails.Protocol +"</PROTOCOL>`n"
    $xml += "</FIREWALLRULES>`n"
}

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)