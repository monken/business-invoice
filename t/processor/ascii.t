use Test::More;

use Business::Invoice;

ok(my $invoice = Business::Invoice->new(
    processor => 'ASCII',
    items => [{quantity => 2}],
    recipient => { first_name => 'Moritz', last_name => 'Onken' }
), 'instantiate object');

ok($invoice = Business::Invoice->new(
    processor => '+Business::Invoice::Processor::ASCII',
    items => [{quantity => 2}],
    recipient => { first_name => 'Moritz', last_name => 'Onken' }
), 'instantiate object with custom processor');

ok($invoice->process);

done_testing;