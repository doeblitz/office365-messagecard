#!perl
use 5.006;
use strict;
use warnings;
use Test::More;
use Data::Dumper; $Data::Dumper::Sortkeys = 1;

plan tests => 2;

use Office365::MessageCard;
use Office365::MessageCard::Action::OpenUri;

# first the basic card itself

my $mc = Office365::MessageCard->new(
    'title' => 'complex card',
    'summary' => 'summary of the card contents',
    'themeColor' => 'color for this card',
    'text' => 'textual content for the card',
);
# diag( Dumper($mc->as_hash()) );
is_deeply($mc->as_hash(),
	  {
	      '@context' => 'https://schema.org/extensions',
	      '@type' => 'MessageCard',
	      'title' => 'complex card',
	      'summary' => 'summary of the card contents',
	      'themeColor' => 'color for this card',
	      'text' => 'textual content for the card',
	  },
	  "complex MessageCard");

# now lets add some sections

my $sect1 = $mc->add_section(
    'title' => 'section 1',
);
$sect1->add_fact(
    'name' => 'key1',
    'value' => 'value1',
);
$sect1->add_fact(
    'name' => 'key2',
    'value' => 'value2',
);
$sect1->add_fact(
    'name' => 'key3',
    'value' => 'value3',
);

my $sect2 = $mc->add_section(
    'activityTitle' => 'section 2',
    'activityImage' => 'image for section 2',
    'activitySubtitle' => 'subtitle 2',
    'activityText' => 'text for section 2',
);

# and also add an action

$mc->add_action(Office365::MessageCard::Action::OpenUri->new(
    'name' => 'Action Button',
    'targets' => {
	'default' => 'some action URI',
    },
));

# diag( Dumper($mc->as_hash()) );
is_deeply($mc->as_hash(),
	  {
	      '@context' => 'https://schema.org/extensions',
	      '@type' => 'MessageCard',
	      'title' => 'complex card',
	      'summary' => 'summary of the card contents',
	      'themeColor' => 'color for this card',
	      'text' => 'textual content for the card',
	      'potentialAction' => [
		  {
		      '@type' => 'OpenUri',
		      'name' => 'Action Button',
		      'targets' => [
			  {
			      'os' => 'default',
			      'uri' => 'some action URI'
			  }
		      ]
		  }
	      ],
	      'sections' => [
		  {
		      'facts' => [
			  {
			      'name' => 'key1',
			      'value' => 'value1'
			  },
			  {
			      'name' => 'key2',
			      'value' => 'value2'
			  },
			  {
			      'name' => 'key3',
			      'value' => 'value3'
			  }
		      ],
		      'title' => 'section 1'
		  },
		  {
		      'activityImage' => 'image for section 2',
		      'activitySubtitle' => 'subtitle 2',
		      'activityText' => 'text for section 2',
		      'activityTitle' => 'section 2'
		  }
	      ],
	  },
	  "more complex MessageCard");

# end of file
