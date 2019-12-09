package Office365::MessageCard::Action::OpenUri;

use 5.20.0;
use Modern::Perl '2014';
use warnings qw( FATAL utf8 );
use utf8;
use open qw( :encoding(UTF-8) :std );
use charnames qw( :full :short );
use autodie;
use Carp qw( carp croak confess cluck );
use Encode qw( encode decode );
use Unicode::Normalize qw( NFD NFC );
use Data::Dumper; $Data::Dumper::Sortkeys = 1;
use Method::Signatures;

our $VERSION = 0.01;

use List::Util qw(pairs);
use Object::InsideOut qw(Office365::MessageCard::Action);

my @name
    :Field
    :Type('scalar')
    :All('name')
    ;

my @targets
    :Field
    :Type('HASH')
    :All('targets')
    ;

method as_hash() {
    my %raw = (
	'@type' => 'OpenUri',
    );
    if (my $x = $name[$$self]) {
	$raw{'name'} = $x;
    }
    if (my $x = $targets[$$self]) {
	$raw{'targets'} = [ map { { 'os' => $_->key(), 'uri' => $_->value() } } pairs($x->%*) ];
    }
    return \%raw;
}

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
