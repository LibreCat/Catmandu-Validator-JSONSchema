Catmandu-Validator-JSONSchema
=============================

##PURPOSE

An implementation of Catmandu::Validator to support JSON Schema

## AUTHOR

Nicolas Franck

##EXAMPLE

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

##NOTE

This module uses JSON::Schema. Therefore the behaviour of
your schema should apply to draft 03 of the json schema:

[Draft for JSON Schema v3](http://tools.ietf.org/html/draft-zyp-json-schema-03)

[JSON Schema v3 in json](http://json-schema.org/draft-03/schema)

##SEE ALSO

[Catmandu::Validator on CPAN](http://search.cpan.org/~nics/Catmandu-0.9103/lib/Catmandu/Validator.pm)

[JSON::Schema on CPAN](http://search.cpan.org/~tobyink/JSON-Schema-0.015/lib/JSON/Schema.pm)

[JSON::Schema on github](https://github.com/tobyink/p5-json-schema)

[JSON Schema website](http://json-schema.org)

[Draft for JSON Schema v3](http://tools.ietf.org/html/draft-zyp-json-schema-03)

[JSON Schema v3 in json](http://json-schema.org/draft-03/schema)

##LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

