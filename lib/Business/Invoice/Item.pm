use MooseX::Declare;

class Business::Invoice::Item {
    use MooseX::StrictConstructor;
    has quantity => ( is => 'rw', isa => 'Num');

    
}