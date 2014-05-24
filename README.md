Catmandu-Validator-JSONSchema
========

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

##SEE ALSO

Catmandu::Validator
JSON::Schema
http://json-schema.org

##LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

