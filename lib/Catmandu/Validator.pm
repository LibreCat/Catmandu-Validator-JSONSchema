package Catmandu::Validator;
use Catmandu::Sane;
use Moo::Role;

requires qw(validate);

=head1 PROPOSAL

use Catmandu;

use Catmandu::Env;

sub Catmandu::Env::default_validator {
    'default';
}

sub Catmandu::Env::validator_namespace { 
    'Catmandu::Validator';
}

sub Catmandu::Env::validators {
    state $validators = {};
    $validators;
}

sub Catmandu::Env::validator {
    my $self = shift;
    my $name = shift;

    my $validators = $self->validators;

    my $key = $name || $self->default_validator;

    $validators->{$key} || do {
        my $ns = $self->validator_namespace;
        if (my $c = $self->config->{validator}->{$key}) {
            check_hash_ref($c);
            check_string(my $package = $c->{package});
            my $opts = $c->{options} || {};
            if (@_ > 1) {
                $opts = {%$opts, @_};
            } elsif (@_ == 1) {
                $opts = {%$opts, %{$_[0]}};
            }
            return $validators->{$key} = require_package($package, $ns)->new($opts);
        }
        if ($name) {
            return require_package($name, $ns)->new(@_);
        }
        Catmandu::BadArg->throw("unknown validator ".$self->default_validator);
    }
}

=cut

1;
