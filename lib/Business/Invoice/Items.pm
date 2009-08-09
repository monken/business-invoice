use MooseX::Declare;

class Business::Invoice::Items {
    
    use List::Object;
    use Business::Invoice::Item;
    use MooseX::StrictConstructor;
    use MooseX::AttributeHelpers;
    
    has _list => (
        is  => 'ro',
        isa => 'List::Object',
        default =>
          sub { List::Object->new( type => 'Business::Invoice::Item' ) },
        handles => [qw(first count)]
    );

    has _args => ( is => 'ro', isa => 'ArrayRef', trigger => \&_merge_args );
    
    
    method _merge_args($list) {
        $self->add(@$list);
    }
    
    sub BUILDARGS {
        my $class = shift;
        return { _args => ref $_[0] eq 'ARRAY' ? shift : \@_ };
    }
    
    method _coerce_hashref(@args) {
        return map { ref $_ eq 'HASH' ? Business::Invoice::Item->new($_) : $_ } @args;
    }
    
    method add(@items) {
        map { $self->_list->add($self->_coerce_hashref($_)) } @items;
        return $self->count;
    }

}