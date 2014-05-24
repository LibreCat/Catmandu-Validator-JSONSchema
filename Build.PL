use warnings;
use strict;
use Module::Build;

my $requires = {
    perl => '>=5.10.0',
    Catmandu => '0.9103',  
    Moo => 0,
    'JSON::Schema' => '0'
};
my $recommends = {
};
my $build = Module::Build->new(
    module_name => 'Catmandu Validator JSON Schema',
    dist_version_from => 'lib/Catmandu/Validator/JSONSchema.pm',
    dist_author => [qw(
        nicolas.franck@ugent.be
    )],
    dist_abstract => 'Catmandu Validator for JSON Schema',
    configure_requires => {
        'Module::Build' => 0
    },
    build_requires => {
        'Module::Build' => 0,
        'Test::More' => 0,
        'Test::Exception' => 0
    },
    requires => $requires,
    recommends => $recommends,
    create_license => 1,
    license => 'perl',
    create_makefile_pl => 'traditional'
);
$build->create_build_script();
