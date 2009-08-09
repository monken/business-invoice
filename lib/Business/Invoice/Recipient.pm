use MooseX::Declare;

class Business::Invoice::Recipient {
    use MooseX::StrictConstructor;
    
    has address      => ( is => 'rw', isa => 'Str' );
    has address2     => ( is => 'rw', isa => 'Str' );
    has address3     => ( is => 'rw', isa => 'Str' );
    has city         => ( is => 'rw', isa => 'Str' );
    has company      => ( is => 'rw', isa => 'Str' );
    has country      => ( is => 'rw', isa => 'Str' );
    has email        => ( is => 'rw', isa => 'Str' );
    has first_name   => ( is => 'rw', isa => 'Str' );
    has last_name    => ( is => 'rw', isa => 'Str' );
    has postal_code  => ( is => 'rw', isa => 'Str' );

}
