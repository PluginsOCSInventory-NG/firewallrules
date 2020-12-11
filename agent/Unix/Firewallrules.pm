# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

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
    $displayName = "TEST";
    $description = "DESCR TEST";
    $enabled = "TRUE";
    $port = "ANY";

    $logger->debug("Yeah you are in firewallrules_inventory_handler:)");

    my %rules;
    foreach my $rule (_getFirewallRules()) {
        # if line contains "chain", second word is direction
        if ($rule =~ /Chain/) {
            my (undef, $direction, undef, undef) = split(' ', $rule);

        } else {
            # if line contains target, go next
            next if $rule =~ /target/;
            my ($action, $protocol, undef, undef, undef, undef) = split(' ', $rule);
        }

        push @{$common->{xmltags}->{FIREWALLRULES}},
        {
            DISPLAYNAME => [$displayName],
            DESCRIPTION    => [$description],
            ENABLED   => [$enabled],
            DIRECTION  => [$direction],
            ACTION  => [$action],
            PORT  => [$port],
            PROTOCOL => [$protocol]
        };
    }

}



sub _getFirewallRules {
    # iptables -n --list | sed '/^num\|^$\|^target\|^Chain/d'
    my @rules = `iptables -L -n`;
    return @rules;
}

1;