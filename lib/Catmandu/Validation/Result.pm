package Catmandu::Validation::Result;
use Catmandu::Sane;
use Moo;

has errors => (
    is => 'rw',
    isa => sub { check_array_ref($_[0]); },
    lazy => 1,
    default => sub { []; }
);
sub valid { 
    scalar(@{ $_[0]->errors() }) == 0; 
}

1;
