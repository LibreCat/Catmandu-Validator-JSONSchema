#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

my @pkgs = qw(
    Catmandu::Validator::JSONSchema
);

require_ok $_ for @pkgs;

done_testing scalar(@pkgs);
