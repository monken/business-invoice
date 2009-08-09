use MooseX::Declare;

class Business::Invoice::Items {
    
    use List::Object;
    use Business::Invoice::Item;
    use MooseX::StrictConstructor;
    use MooseX::AttributeHelpers;
    
    has _list => (
        is  => 'ro',
        metaclass => 'Collection::Array',
        isa => 'ArrayRef[Item]',
        provides => {first => 'first', count => 'count', insert => 'insert', push => 'push'},
        default => sub { [] },
        
    );

    has _args => ( is => 'ro', isa => 'ArrayRef', trigger => \&_merge_args );
    
    
    method _merge_args($list) {
        $self->push(@$list) if(@$list);
    }
    
    sub BUILDARGS {
        my $class = shift;
        return { _args => ref $_[0] eq 'ARRAY' ? shift : \@_ };
    }
    

}