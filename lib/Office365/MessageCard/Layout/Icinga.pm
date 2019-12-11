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

=head1 NAME

Icinga - message card factory with layouts for Icinga2 notifications

=head1 SYNOPSIS



=head1 DESCRIPTION



=cut

use URI::Escape;
use Office365::MessageCard;
use Office365::MessageCard::Action::OpenUri;

my %color_host = (
    'UP' => '008000',
    'DOWN' => 'ff0000',
    'UNREACHABLE' => 'ff8700',
);

my %color_service = (
    'OK' => '008000',
    'WARNING' => 'ffff00',
    'UNKNOWN' => '808080',
    'CRITICAL' => 'ff0000',
);

method new_host_notification (
    :$type!,
    :$hostname!,
    :$hostdisplayname!,
    :$state!,
    :$output!,
    :$date!,
    :$ipv4,
    :$ipv6,
    :$author,
    :$comment,
    :$icingaurl
) {
    my $color = $color_host{$state};
    carp("need valid state, one of: ".join(", ", keys %color_host)) unless ($color);
    my $mc = Office365::MessageCard->new(
	'title' => sprintf("[%s] Host %s is %s!", $type, $hostdisplayname, $state),
	'summary' => sprintf("[%s] Host %s is %s!", $type, $hostdisplayname, $state),
	'themeColor' => $color,
    );
    my $sect = $mc->add_section(
	'title' => sprintf("%s is %s", $hostdisplayname, $state),
	'text' => $output,
    );
    $sect->add_fact('name' => 'host', 'value' => $hostname);
    $sect->add_fact('name' => 'status', 'value' => $state);
    $sect->add_fact('name' => 'date', 'value' => $date);
    $sect->add_fact('name' => 'ipv4', 'value' => $ipv4) if ($ipv4);
    $sect->add_fact('name' => 'ipv6', 'value' => $ipv6) if ($ipv6);
    if ($comment) {
	$sect->add_fact('name' => 'comment by '.$author, 'value' => $comment);
    }
    if ($icingaurl) {
	$sect->add_action(Office365::MessageCard::Action::OpenUri->new(
	    'name' => 'View in Icinga',
	    'targets' => {
		'default' => $icingaurl.'/monitoring/host/show?host='.uri_escape_utf8($hostname),
	    },
	));
    }
    return $mc;
}

method new_service_notification (
    :$type!,
    :$hostname!,
    :$hostdisplayname!,
    :$servicename!,
    :$servicedisplayname!,
    :$state!,
    :$output!,
    :$date!,
    :$ipv4,
    :$ipv6,
    :$author,
    :$comment,
    :$icingaurl
) {
    my $color = $color_service{$state};
    carp("need valid state, one of: ".join(", ", keys %color_service)) unless ($color);
    my $mc = Office365::MessageCard->new(
	'title' => sprintf("[%s] Service %s on %s is %s!", $type, $servicedisplayname, $hostdisplayname, $state),
	'summary' => sprintf("[%s] Service %s on %s is %s!", $type, $servicedisplayname, $hostdisplayname, $state),
	'themeColor' => $color,
    );
    my $sect = $mc->add_section(
	'title' => sprintf("%s on %s is %s", $servicedisplayname, $hostdisplayname, $state),
	'text' => $output,
    );
    $sect->add_fact('name' => 'host', 'value' => $hostname);
    $sect->add_fact('name' => 'service', 'value' => $servicename);
    $sect->add_fact('name' => 'status', 'value' => $state);
    $sect->add_fact('name' => 'date', 'value' => $date);
    $sect->add_fact('name' => 'ipv4', 'value' => $ipv4) if ($ipv4);
    $sect->add_fact('name' => 'ipv6', 'value' => $ipv6) if ($ipv6);
    if ($comment) {
	$sect->add_fact('name' => 'comment by '.$author, 'value' => $comment);
    }
    if ($icingaurl) {
	$sect->add_action(Office365::MessageCard::Action::OpenUri->new(
	    'name' => 'View in Icinga',
	    'targets' => {
		'default' => $icingaurl.'/monitoring/service/show?host='.uri_escape_utf8($hostname).'&service='.uri_escape_utf8($servicename),
	    },
	));
    }
    return $mc;
}

1;

#=encoding utf8
#
# Local variables:
# mode: perl
# coding: utf-8
# End:
