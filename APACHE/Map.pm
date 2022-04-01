# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

package Apache::Ocsinventory::Plugins::Firewallrules::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;
$DATA_MAP{firewallrules} = {
   mask => 0,
   multi => 1,
   auto => 1,
   delOnReplace => 1,
   sortBy => 'RULE_ID',
   writeDiff => 0,
   cache => 0,
   fields => {
       RULE_ID => {},
       DISPLAYNAME => {},
       DESCRIPTION => {},
       SOURCE => {},
       DESTINATION => {},
       ENABLED => {},
       DIRECTION => {},
       ACTION => {},
       PORT => {},
       PROTOCOL => {}
   }
};
1;