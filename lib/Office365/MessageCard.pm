package Office365::MessageCard;

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
use JSON;

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

    my @title
	:Field
	:Type('scalar')
	:Arg('Name' => 'title', 'Mandatory' => 1)
	:Acc('title')
	;

    my @summary
	:Field
	:Type('scalar')
	:All('summary')
	;

    my @themeColor
	:Field
	:Type('scalar')
	:All('themeColor')
	;

    my @text
	:Field
	:Type('scalar')
	:All('text')
	;

    my @sections
	:Field
	:Type('list(Office365::MessageCard::Section)')
	:All('sections')
	;

    my @potentialAction
	:Field
	:Type('list(Office365::MessageCard::Action)')
	:All('potentialAction')
	;

    method as_hash() {
	my %raw = (
	    '@type' => 'MessageCard',
	    '@context' => 'https://schema.org/extensions',
	    'title' => $title[$$self],
	);
	if (my $x = $summary[$$self]) {
	    $raw{'summary'} = $x;
	}
	if (my $x = $themeColor[$$self]) {
	    $raw{'themeColor'} = $x;
	}
	if (my $x = $text[$$self]) {
	    $raw{'text'} = $x;
	}
	if (my $x = $sections[$$self]) {
	    $raw{'sections'} =
		[ map { $_->as_hash() } $x->@* ];
	}
	if (my $x = $potentialAction[$$self]) {
	    $raw{'potentialAction'} =
		[ map { $_->as_hash() } $x->@* ];
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
