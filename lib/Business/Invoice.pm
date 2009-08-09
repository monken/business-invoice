use MooseX::Declare;

class Business::Invoice {
    use Business::Invoice::Items;
    use Business::Invoice::Types qw(:all);
    use MooseX::StrictConstructor;

    has recipient => ( is => 'rw', isa => Recipient, coerce => 1 );
    has items => ( is => 'rw', isa => Items, lazy_build => 1, coerce => 1 );
    has processor => ( is => 'rw', isa => Processor, coerce => 1, handles => [qw(process)] );

    method _build_items(@args) {
        return Business::Invoice::Items->new(
            _list => \@args
        );
      }

}
