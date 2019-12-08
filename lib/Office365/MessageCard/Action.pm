package Office365::MessageCard::Action;

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

use Object::InsideOut qw(Office365::MessageCard::_Base);

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
