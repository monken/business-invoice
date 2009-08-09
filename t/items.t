use Test::More;

use Business::Invoice;

ok(my $i = Business::Invoice::Items->new(), 'new empty list');

is($i->count, 0, 'empty list');

ok($i = Business::Invoice::Items->new({ quantity => 2 }, { quantity => 3 }), 'construct with two items');

is($i->count, 2, 'list contains two items');

ok($i = Business::Invoice::Items->new(Business::Invoice::Item->new( quantity => 3 )), 'construct with Item');

is($i->count, 1, 'list contains one item');

$i->push(Business::Invoice::Item->new( quantity => 4 ));

is($i->count, 2, 'add via ->insert(Object)');

$i->push({ quantity => 4 });

is($i->count, 3, 'add via ->insert(HashRef)');

ok(my $invoice = Business::Invoice->new(items => $i), 'add items to Invoice via Items');

ok($invoice = Business::Invoice->new(items => [{ quantity => 3 },{ quantity => 4 }]), 'add items to Invoice via ArrayRef[HashRef]');

is($invoice->items->count, 2, 'added two items');

ok($invoice = Business::Invoice->new(items => [Business::Invoice::Item->new( quantity => 3.3 ),Business::Invoice::Item->new( quantity => 4 )]), 'add items to Invoice via ArrayRef[HashRef]');

is($invoice->items->count, 2, 'added two items');

is($invoice->items->first->quantity, 3.3, 'quantity of first item is 3.3');

done_testing;