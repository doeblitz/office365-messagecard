#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 7;

BEGIN {
    # modules for MessageCard proper
    use_ok( 'Office365::MessageCard' ) || print "Bail out!\n";
    use_ok( 'Office365::MessageCard::Action' ) || print "Bail out!\n";
    use_ok( 'Office365::MessageCard::Action::OpenUri' ) || print "Bail out!\n";
    use_ok( 'Office365::MessageCard::Fact' ) || print "Bail out!\n";
    use_ok( 'Office365::MessageCard::Image' ) || print "Bail out!\n";
    use_ok( 'Office365::MessageCard::Section' ) || print "Bail out!\n";
    # factory modules for pre-cooked layouts
    use_ok( 'Office365::MessageCard::Layout::Icinga' ) || print "Bail out!\n";
}

diag( "Testing Office365::MessageCard $Office365::MessageCard::VERSION, Perl $], $^X" );
