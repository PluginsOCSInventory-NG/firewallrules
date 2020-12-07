# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

$ErrorActionPreference = 'silentlycontinue'
$rules = Get-NetFirewallRule | Select-Object -Property DisplayName, Description, Action, Direction, Enabled, InstanceID
$portsAndProtocols = Get-NetFirewallPortFilter | Select-Object -Property LocalPort, Protocol, InstanceID

$xml += "<FIREWALL_RULES>"
foreach ($rule in $rules) {
    $ruleDetails = $portsAndProtocols | Where-Object {$_.instanceID -eq $rule.instanceID}
    $xml += "`t<RULE>`n"
    $xml += "`t`t<DISPLAY_NAME>"+ $rule.DisplayName +"</DISLAYNAME>`n" 
    $xml += "`t`t<DESCRIPTION>"+ $rule.Description +"</DESCRIPTION>`n"
    $xml += "`t`t<ENABLED>"+ $rule.Enabled +"</ENABLED>`n"
    $xml += "`t`t<DIRECTION>"+ $rule.Direction +"</DIRECTION>`n"
    $xml += "`t`t<ACTION>"+ $rule.Action +"</ACTION>`n"
    $xml += "`t`t<PORT>"+ $ruleDetails.LocalPort +"</PORT>`n"
    $xml += "`t`t<PROTOCOL>"+ $ruleDetails.Protocol +"</PROTOCOL>`n"
    $xml += "`t</RULE>`n"
}
$xml += "</FIREWALL_RULES>"
echo $xml