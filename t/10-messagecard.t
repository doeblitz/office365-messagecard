#!perl
use 5.006;
use strict;
use warnings;
use Test::More;
use Data::Dumper; $Data::Dumper::Sortkeys = 1;

plan tests => 1;

use Office365::MessageCard;

my $mc = Office365::MessageCard->new(
    'title' => 'simple card'
);
# diag( Dumper($mc->as_hash()) );
is_deeply($mc->as_hash(),
	  {
	      '@context' => 'https://schema.org/extensions',
	      '@type' => 'MessageCard',
	      'title' => 'simple card'
	  },
	  "simple MessageCard");

# end of file
