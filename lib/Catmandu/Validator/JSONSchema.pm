package Catmandu::Validator::JSONSchema;
use Catmandu::Sane;
use Moo;
use Catmandu::Util qw(:is :check require_package);
use JSON::Schema;
use Catmandu::Validation::Result;

our $VERSION = "0.1";

with qw(Catmandu::Validator);

has schema => (
    is => 'rw',
    isa => sub { check_hash_ref($_[0]); },
    required => 1
);

sub validate {
    my($self,$object)=@_;

    my @errors;

    my $validator = JSON::Schema->new($self->schema());

    my $result = $validator->validate($object);

    unless($result){
        @errors = map { +{ property => $_->property, message => $_->message }; } $result->errors;
    }

    Catmandu::Validation::Result->new(errors => \@errors);
}

1;
