package Office365::MessageCard::Layout::Icinga;

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

use Office365::MessageCard;
use Office365::MessageCard::Action::OpenUri;

method new (:$title) {
    my $mc = Office365::MessageCard->new(
	title => 'Icinga Event',
    );
    my $sect = $mc->add_section('title' => $title);
    $sect->add_image('title' => 'Test Image', 'image' => 'https://some.uri');
    $sect->add_fact('name' => 'host', 'value' => 'some host');
    $sect->add_fact('name' => 'service', 'value' => 'some service');
    $sect->add_fact('name' => 'status', 'value' => 'down');
    $sect->add_action(Office365::MessageCard::Action::OpenUri->new(
	'name' => 'View in Icinga',
	'targets' => {
	    'default' => 'https://some.uri',
	},
    ));
    return $mc;
}

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
