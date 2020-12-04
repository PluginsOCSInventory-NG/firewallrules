# Plugin "Firewall Rules" OCSInventory
# Author: Léa DROGUET

package Ocsinventory::Agent::Modules::Firewallrules;


sub new {
    my $name="firewallrules";   #Set the name of your module here
    

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
        start_handler => $name."_start_handler",    #or undef if don't use this hook 
        prolog_writer => $name."_prolog_writer",    #or undef if don't use this hook  
        prolog_reader => $name."_prolog_reader",    #or undef if don't use this hook  
        inventory_handler => $name."_inventory_handler",    #or undef if don't use this hook 
        end_handler => $name."_end_handler"    #or undef if don't use this hook 
    };
 
    bless $self;
}



######### Hook methods ############

sub firewallrules_inventory_handler {        #Use this hook to add or modify entries in the inventory XML
    my $self = shift;
    my $logger = $self->{logger};
    my $common = $self->{context}->{common};

    
    my $col1 = 42;
    my $col2 = "some info";

    push @{$common->{xmltags}->{FIREWALL}},
    {
        COLUMN_1  => [$col1],
        COLUMN_2  => [$col2],
    };
    
    $logger->debug("Yeah you are in firewallrules_inventory_handler :)");

}

1;