package Office365::MessageCard::Image;

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

BEGIN {
    use Exporter ();
    use vars qw ($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
    $VERSION     = 0.01;
    @ISA         = qw (Exporter);
    @EXPORT      = qw ();
    @EXPORT_OK   = qw ();
    %EXPORT_TAGS = ();
}

use Object::InsideOut; {

    my @image
	:Field
	:Type('scalar')
	:Arg('Name' => 'image', 'Mandatory' => 1)
	:Acc('image')
	;

    my @title
	:Field
	:Type('scalar')
	:All('title')
	;

    method as_hash() {
	my %raw = (
	);
	if (my $x = $image[$$self]) {
	    $raw{'image'} = $x;
	}
	if (my $x = $title[$$self]) {
	    $raw{'title'} = $x;
	}
	return \%raw;
    }

    method as_json(:$pretty=0) {
	my $json = JSON->new()->utf8();
	if ($pretty) {
	    $json = $json->pretty()->canonical();
	}
	return $json->encode($self->as_hash());
    }

}

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
