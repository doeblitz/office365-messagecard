#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Office365::MessageCard' ) || print "Bail out!\n";
}

diag( "Testing Office365::MessageCard $Office365::MessageCard::VERSION, Perl $], $^X" );
