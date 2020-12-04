# Plugin "Firewall Config" OCSInventory
# Author: Léa DROGUET

$rules = Get-NetFirewallRule | Select-Object -Property DisplayName, Description, Enabled, 
@{Name='Protocol';Expression={($PSItem | Get-NetFirewallPortFilter).Protocol}}, 
@{Name='LocalPort';Expression={($PSItem | Get-NetFirewallPortFilter).LocalPort}}, 
Direction, Action

$xml += "<FIREWALL_RULES>"
foreach ($rule in $rules) {
    $xml += "`t<RULE>`n"
    $xml += "`t`t<DISPLAY_NAME>"+ $rule.DisplayName +"</DISLAYNAME>`n" 
    $xml += "`t`t<DESCRIPTION>"+ $rule.Description +"</DESCRIPTION>`n"
    $xml += "`t`t<ENABLED>"+ $rule.Enabled +"</ENABLED>`n"
    $xml += "`t`t<DIRECTION>"+ $rule.Direction +"</DIRECTION>`n"
    $xml += "`t`t<ACTION>"+ $rule.Action +"</ACTION>`n"
    $xml += "`t`t<PORT>"+ $rule.LocalPort +"</PORT>`n"
    $xml += "`t`t<PROTOCOL>"+ $rule.Protocol +"</PROTOCOL>`n"
    $xml += "`t</RULE>`n"
    $instanceID = $rule.InstanceID
}

$xml += "</FIREWALL_RULES>"
echo $xml