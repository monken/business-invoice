package Business::Invoice::Types;

use strict;
use warnings;

use Business::Invoice::Item;
use Business::Invoice::Items;
use Business::Invoice::Recipient;


use MooseX::Types -declare => [qw(Items Item Recipient Processor)];

use MooseX::Types::Moose qw/Int Str HashRef ArrayRef/;

subtype Items, 
    as 'Business::Invoice::Items';

coerce Items,
    from HashRef,
    via {
        coerce_items(Business::Invoice::Item->new($_));
    };

coerce Items,
    from 'Business::Invoice::Item',
    via {
        coerce_items($_);
    };

coerce Items,
    from 'ArrayRef[Business::Invoice::Item]',
    via {
        coerce_items($_);
    };

coerce Items,
    from ArrayRef[HashRef],
    via {
        my @items = ();
        foreach my $item (@{$_}) {
          push(@items, Business::Invoice::Item->new(%$item));
        }
        coerce_items(@items);

    };

sub coerce_items {
    Business::Invoice::Items->new( @_ );
}

subtype Item, 
    as 'Business::Invoice::Item';

subtype Recipient, 
    as 'Business::Invoice::Recipient';

coerce Recipient,
    from HashRef,
    via {
        Business::Invoice::Recipient->new($_)
    };

subtype Processor,
    as 'Business::Invoice::Processor';

coerce Processor,
    from Str,
    via {
      my $class = $_ =~ /^\+(.*)$/ ? $1 : 'Business::Invoice::Processor::' . $_;
      Class::MOP::load_class($class);
      $class->new;
    };

1;