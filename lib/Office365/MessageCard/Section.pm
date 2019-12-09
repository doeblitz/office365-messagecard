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

our $VERSION = 0.01;

use Office365::MessageCard::Fact;
use Office365::MessageCard::Image;
use Object::InsideOut qw(Office365::MessageCard::_Base);

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
    :Type('list(Office365::MessageCard::Fact)')
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

method add_fact(@_) {
    $facts[$$self] //= [];
    my $obj = Office365::MessageCard::Fact->_copy_or_new(@_);
    push $facts[$$self]->@*, $obj;
    return $obj;
}

method add_image(@_) {
    $images[$$self] //= [];
    my $obj = Office365::MessageCard::Image->_copy_or_new(@_);
    push $images[$$self]->@*, $obj;
    return $obj;
}

method add_action(@_) {
    $potentialAction[$$self] //= [];
    my $obj = Office365::MessageCard::Action->_copy_or_new(@_);
    push $potentialAction[$$self]->@*, $obj;
    return $obj;
}

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
	$raw{'facts'} =
	    [ map { $_->as_hash() } $x->@* ];
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

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
