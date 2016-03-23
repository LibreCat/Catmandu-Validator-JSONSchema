# NAME

Catmandu::Validator::JSONSchema - An implementation of Catmandu::Validator to support JSON Schema

# STATUS

[![Build Status](https://travis-ci.org/LibreCat/Catmandu-Validator-JSONSchema.svg?branch=master)](https://travis-ci.org/LibreCat/Catmandu-Validator-JSONSchema)
[![Coverage](https://coveralls.io/repos/LibreCat/Catmandu-Validator-JSONSchema/badge.png?branch=master)](https://coveralls.io/r/LibreCat/Catmandu-Validator-JSONSchema)
[![CPANTS kwalitee](http://cpants.cpanauthors.org/dist/Catmandu-Validator-JSONSchema.png)](http://cpants.cpanauthors.org/dist/Catmandu-Validator-JSONSchema)

# SYNOPSIS

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

# NOTE

This module uses JSON::Schema. Therefore the behaviour of
your schema should apply to draft 03 of the json schema:

http://json-schema.org/draft-03/schema

http://tools.ietf.org/html/draft-zyp-json-schema-03

# SEE ALSO

[Catmandu::Validator](https://metacpan.org/pod/Catmandu::Validator)

[JSON::Schema](https://metacpan.org/pod/JSON::Schema)

[http://json-schema.org](http://json-schema.org)

# AUTHOR

Nicolas Franck, `<nicolas.franck at ugent.be>`

# LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
