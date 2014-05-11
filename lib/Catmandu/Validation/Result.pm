package Catmandu::Validation::Result;
use Catmandu::Sane;
use Moo;

has _errors => (
    is => 'rw',
    isa => sub { check_array_ref($_[0]); },
    lazy => 1,
    default => sub { []; },
    handles => {
        errors => 'elements',
        has_errors => 'count',
        clear_errors => 'clear'
    }
);
sub valid { !($_[0]->has_errors()); }

1;
