#!perl
use 5.006;
use strict;
use warnings;
use Test::More;
use Data::Dumper; $Data::Dumper::Sortkeys = 1;

plan tests => 3;

use Office365::MessageCard::Fact;
use Office365::MessageCard::Image;
use Office365::MessageCard::Section;

my $mc_fact = Office365::MessageCard::Fact->new(
    name => 'fact name',
    value => 'fact value',
);
# diag( Dumper($mc_fact->as_hash()) );
is_deeply($mc_fact->as_hash(),
	  {
	      'name' => 'fact name',
	      'value' => 'fact value'
	  },
	  "MessageCard Fact");

my $mc_image = Office365::MessageCard::Image->new(
    image => 'image url',
    title => 'image title',
);
# diag( Dumper($mc_image->as_hash()) );
is_deeply($mc_image->as_hash(),
	  {
	      'image' => 'image url',
	      'title' => 'image title'
	  },
	  "MessageCard Image");

my $mc_sect = Office365::MessageCard::Section->new(
    'title' => 'section title',
);
# diag( Dumper($mc_sect->as_hash()) );
is_deeply($mc_sect->as_hash(),
	  {
	      'title' => 'section title',
	  },
	  "MessageCard Section");

# end of file
