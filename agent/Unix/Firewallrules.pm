# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

# TODO :
# must be a better way to skip lines

package Ocsinventory::Agent::Modules::Firewallrules;

sub new {

    my $name="firewallrules"; # Name of the module

    my (undef,$context) = @_;
    my $self = {};

    #Create a special logger for the module
    $self->{logger} = new Ocsinventory::Logger ({
        config => $context->{config}
    });
    $self->{logger}->{header}="[$name]";
    $self->{context}=$context;
    $self->{structure}= {
        name => $name,
        start_handler => undef,    #or undef if don't use this hook
        prolog_writer => undef,    #or undef if don't use this hook
        prolog_reader => undef,    #or undef if don't use this hook
        inventory_handler => $name."_inventory_handler",    #or undef if don't use this hook
        end_handler => undef       #or undef if don't use this hook
    };
    bless $self;
}

######### Hook methods ############
sub firewallrules_inventory_handler {

    my $self = shift;
    my $logger = $self->{logger};
    my $common = $self->{context}->{common};

    # default values for testing
    $displayName = "iptables rule";
    $enabled = "TRUE";
    

    $logger->debug("Yeah you are in firewallrules_inventory_handler:)");
    
    my %rules;
    my ($direction, $action, $protocol, $opt, $source, $destination, $comment);
    
    foreach my $rule (_getFirewallRules()) {
        if ($rule =~ /^target/) {
            next;
        }
        if ($rule =~ /^\s*$/) {
            next;
        }
        # if line contains "chain", second word is direction
        if ($rule =~ /Chain/) {
            (undef, $direction, undef, undef) = split(' ', $rule);
        } else {
            ($action, $protocol, $opt, $source, $destination, $comment) = split(' ', $rule);
        }

        push @{$common->{xmltags}->{FIREWALLRULES}},
        {
            DISPLAYNAME => [$displayName],
            DESCRIPTION    => ["$source => $destination"],
            ENABLED   => [$enabled],
            DIRECTION  => [$direction],
            ACTION  => [$action],
            PORT  => [$comment],
            PROTOCOL => [$protocol]
        };
    }

}


sub _getFirewallRules {
    my @rules = `iptables --list -n`;
    return @rules;
}

1;