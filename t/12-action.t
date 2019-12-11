#!perl
use 5.006;
use strict;
use warnings;
use Test::More;
use Data::Dumper; $Data::Dumper::Sortkeys = 1;

plan tests => 1;

use Office365::MessageCard::Action;
use Office365::MessageCard::Action::OpenUri;

{
    my $mc = Office365::MessageCard::Action::OpenUri->new(
	name => 'button text',
	targets => {
	    default => 'some_uri',
	},
    );
    # diag( Dumper($mc->as_hash()) );
    is_deeply($mc->as_hash(),
	      {
		  '@type' => 'OpenUri',
		  'name' => 'button text',
		  'targets' => [
		      {
			  'os' => 'default',
			  'uri' => 'some_uri'
		      }
		  ],
	      },
	      "OpenUri action");
}

# end of file
