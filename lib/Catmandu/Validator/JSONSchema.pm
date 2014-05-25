package Catmandu::Validator::JSONSchema;
use Catmandu::Sane;
use Moo;
use Catmandu::Util qw(:is :check);
use JSON::Schema;

our $VERSION = "0.1";

with qw(Catmandu::Validator);

has schema => (
    is => 'ro',
    isa => sub { check_hash_ref($_[0]); },
    required => 1
);
has _schema => (
    is => 'ro',
    lazy => 1,
    builder => '_build_schema'    
);
sub _build_schema {
    JSON::Schema->new($_[0]->schema(),format => \%JSON::Schema::FORMATS);
}
sub validate_data {
    my($self,$hash)=@_;

    my $errors = undef;

    my $result = $self->_schema()->validate($hash);

    unless($result){
        $errors = [
            map { 
                +{ 
                    property => $_->property, 
                    message => $_->message 
                }; 
            } $result->errors
        ];   
    }

    $errors;
}

=head1 NAME

Catmandu::Validator::JSONSchema - An implementation of Catmandu::Validator to support JSON Schema

=head1 SYNOPSIS

    use Catmandu::Validator::JSONSchema;
    use Data::Dumper;

    my $validator = Catmandu::Validator::JSONSchema->new(
        schema => {
            "properties"=> {
                "_id"=> {
                    "type"=> "string",
                    required => 1
                },
                "title"=> {
                    "type"=> "string",
                    required => 1
                },
                "author"=> {
                    "type"=> "array",
                    "items" => {
                        "type" => "string"
                    },
                    minItems => 1,
                    uniqueItems => 1
                }
            },
        }
    );

    my $object = {
        _id => "rug01:001963301",
        title => "In gesprek met Etienne Vermeersch : een zoektocht naar waarheid",
        author => [
            "Etienne Vermeersch",
            "Dirk Verhofstadt"
        ]
    };

    unless($validator->validate($object)){
        print Dumper($validator->last_errors());
    }

=head1 NOTE

This module uses JSON::Schema. Therefore the behaviour of
your schema should apply to draft 03 of the json schema:

http://json-schema.org/draft-03/schema

http://tools.ietf.org/html/draft-zyp-json-schema-03

=head1 SEE ALSO

L<Catmandu::Validator>

L<JSON::Schema>

http://json-schema.org

=head1 AUTHOR

Nicolas Franck, C<< <nicolas.franck at ugent.be> >>

=head1 LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
