package Office365::MessageCard::_Base;

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

=head1 NAME

_Base - base class for Office365::MessageCard object hierarchy

=head1 SYNOPSIS



=head1 DESCRIPTION



=cut

use Scalar::Util qw(blessed);
use Object::InsideOut;

method _copy_or_new (@_) :Restricted {
    my $class = blessed($self) // $self;# object or class invocation
    if (ref($_[0]) and blessed($_[0])) {
	if ($_[0]->isa($class)) {
	    return $_[0];
	} else {
	    carp "need object of class $class";
	}
    } else {
	return $self->new(@_);
    }
}

method as_json(:$pretty=0) {
    my $json = JSON->new()->utf8();
    if ($pretty) {
	$json = $json->pretty()->canonical();
    }
    return $json->encode($self->as_hash());
}

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
