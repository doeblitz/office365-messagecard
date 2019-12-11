#!perl
use 5.006;
use strict;
use warnings;
use Test::More;
use Data::Dumper; $Data::Dumper::Sortkeys = 1;

plan tests => 2;

use Office365::MessageCard::Layout::Icinga;

my $mch = Office365::MessageCard::Layout::Icinga->new_host_notification(
    'type' => 'PROBLEM',
    'hostname' => 'somehost',
    'hostdisplayname' => 'somehost.domain',
    'state' => 'DOWN',
    'output' => 'what the failing check gave us',
    'date' => '2019-12-11 18:33:33 +0100',
    'ipv4' => '192.168.1.1',
    'ipv6' => 'fe80::204:76ff:fe8c:ab8d',
    'author' => 'Admin',
    'comment' => 'who cares?',
    'icingaurl' => 'https://monitoring.example.com/icingaweb2',
);
# diag( Dumper($mch->as_hash()) );
is_deeply($mch->as_hash(),
	  {
	      '@context' => 'https://schema.org/extensions',
	      '@type' => 'MessageCard',
	      'sections' => [
		  {
		      'facts' => [
			  {
			      'name' => 'host',
			      'value' => 'somehost'
			  },
			  {
			      'name' => 'status',
			      'value' => 'DOWN'
			  },
			  {
			      'name' => 'date',
			      'value' => '2019-12-11 18:33:33 +0100'
			  },
			  {
			      'name' => 'ipv4',
			      'value' => '192.168.1.1'
			  },
			  {
			      'name' => 'ipv6',
			      'value' => 'fe80::204:76ff:fe8c:ab8d'
			  },
			  {
			      'name' => 'comment by Admin',
			      'value' => 'who cares?'
			  }
		      ],
		      'potentialAction' => [
			  {
			      '@type' => 'OpenUri',
			      'name' => 'View in Icinga',
			      'targets' => [
				  {
				      'os' => 'default',
				      'uri' => 'https://monitoring.example.com/icingaweb2/monitoring/host/show?host=somehost'
				  }
			      ]
			  }
		      ],
		      'text' => 'what the failing check gave us',
		      'title' => 'somehost.domain is DOWN'
		  }
	      ],
	      'summary' => '[PROBLEM] Host somehost.domain is DOWN!',
	      'themeColor' => 'ff0000',
	      'title' => '[PROBLEM] Host somehost.domain is DOWN!'
	  },
	  "host notification");



my $mcs = Office365::MessageCard::Layout::Icinga->new_service_notification(
    'type' => 'PROBLEM',
    'hostname' => 'somehost',
    'hostdisplayname' => 'somehost.domain',
    'servicename' => 'someservice',
    'servicedisplayname' => 'some unimportant service',
    'state' => 'UNKNOWN',
    'output' => 'what the failing check gave us',
    'date' => '2019-12-11 18:33:33 +0100',
    'ipv4' => '192.168.1.1',
    'ipv6' => 'fe80::204:76ff:fe8c:ab8d',
    'author' => 'Admin',
    'comment' => 'who cares?',
    'icingaurl' => 'https://monitoring.example.com/icingaweb2',
);
# diag( Dumper($mcs->as_hash()) );
is_deeply($mcs->as_hash(),
	  {
	      '@context' => 'https://schema.org/extensions',
	      '@type' => 'MessageCard',
	      'sections' => [
		  {
		      'facts' => [
			  {
			      'name' => 'host',
			      'value' => 'somehost'
			  },
			  {
			      'name' => 'service',
			      'value' => 'someservice'
			  },
			  {
			      'name' => 'status',
			      'value' => 'UNKNOWN'
			  },
			  {
			      'name' => 'date',
			      'value' => '2019-12-11 18:33:33 +0100'
			  },
			  {
			      'name' => 'ipv4',
			      'value' => '192.168.1.1'
			  },
			  {
			      'name' => 'ipv6',
			      'value' => 'fe80::204:76ff:fe8c:ab8d'
			  },
			  {
			      'name' => 'comment by Admin',
			      'value' => 'who cares?'
			  }
		      ],
		      'potentialAction' => [
			  {
			      '@type' => 'OpenUri',
			      'name' => 'View in Icinga',
			      'targets' => [
				  {
				      'os' => 'default',
				      'uri' => 'https://monitoring.example.com/icingaweb2/monitoring/service/show?host=somehost&service=someservice'
				  }
			      ]
			  }
		      ],
		      'text' => 'what the failing check gave us',
		      'title' => 'some unimportant service on somehost.domain is UNKNOWN'
		  }
	      ],
	      'summary' => '[PROBLEM] Service some unimportant service on somehost.domain is UNKNOWN!',
	      'themeColor' => '808080',
	      'title' => '[PROBLEM] Service some unimportant service on somehost.domain is UNKNOWN!'
	  },
	  "service notification");

# end of file
