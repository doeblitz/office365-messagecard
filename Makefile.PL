use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Office365::MessageCard',
    AUTHOR           => q{Ralf Doeblitz <doeblitz@netzverwaltung.net>},
    VERSION_FROM     => 'lib/Office365/MessageCard.pm',
    ABSTRACT         => 'MessageCard for Office365 webhook',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.20.0,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Office365-MessageCard-*' },
);
