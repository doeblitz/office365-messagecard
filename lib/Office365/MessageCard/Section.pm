package Office365::MessageCard::Section;

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

    my @title
	:Field
	:Type('scalar')
	:All('title')
	;

    my @activityImage
	:Field
	:Type('scalar')
	:All('activityImage')
	;

    my @activityTitle
	:Field
	:Type('scalar')
	:All('activityTitle')
	;

    my @activitySubtitle
	:Field
	:Type('scalar')
	:All('activitySubtitle')
	;

    my @activityText
	:Field
	:Type('scalar')
	:All('activityText')
	;

    my @text
	:Field
	:Type('scalar')
	:All('text')
	;

    my @facts
	:Field
	:Type('HASH')
	:All('facts')
	;

    my @images
	:Field
	:Type('list(Office365::MessageCard::Image)')
	:All('images')
	;

    my @potentialAction
	:Field
	:Type('list(Office365::MessageCard::Action)')
	:All('potentialAction')
	;

    method as_hash() {
	my %raw = (
	);
	if (my $x = $title[$$self]) {
	    $raw{'title'} = $x;
	}
	if (my $x = $activityImage[$$self]) {
	    $raw{'activityImage'} = $x;
	}
	if (my $x = $activityTitle[$$self]) {
	    $raw{'activityTitle'} = $x;
	}
	if (my $x = $activitySubtitle[$$self]) {
	    $raw{'activitySubtitle'} = $x;
	}
	if (my $x = $activityText[$$self]) {
	    $raw{'activityText'} = $x;
	}
	if (my $x = $text[$$self]) {
	    $raw{'text'} = $x;
	}
	if (my $x = $facts[$$self]) {
	    $raw{'facts'} = $x;
	}
	if (my $x = $images[$$self]) {
	    $raw{'images'} =
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
