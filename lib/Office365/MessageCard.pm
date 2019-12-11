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

our $VERSION = 0.01;

=head1 NAME

MessageCard - legacy actionable message cards for office365 webhooks

=head1 SYNOPSIS



=head1 DESCRIPTION



=cut

use Office365::MessageCard::Action;
use Office365::MessageCard::Section;
use Object::InsideOut qw(Office365::MessageCard::_Base);

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

method add_section(@_) {
    $sections[$$self] //= [];
    my $obj = Office365::MessageCard::Section->_copy_or_new(@_);
    push $sections[$$self]->@*, $obj;
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

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
