package main;
use strict;
use warnings;

BEGIN {
	our $VERSION = '0.00';

	our $package   = "SFTime";
	our $directory = "_Inline";
}

our ($VERSION, $package, $directory);

use Inline (CPP => 'DATA',
	NAME					=> $package,
#	VERSION 				=> $VERSION,
#	DIRECTORY 			=> $directory,
	TYPEMAPS				=> "map/$package.map",
#	LIBS					=> '-lfoo',
#	INC 					=> '-I/foo/include',
#	PREFIX				=> 'XXX_',
	FORCE_BUILD 		=> 1,
	CLEAN_AFTER_BUILD => 0,
	WARNINGS				=> 0,
);

system "mkdir -p ../auto" unless -e "../auto";
system "rm -r ../auto/$package" if -e "../auto/$package";
system "cp -r $directory/lib/auto/$package ../auto";

1;
__DATA__
__CPP__

class SFTime {
	private:
		double value;

	public:
		SFTime (const double v=0) { setValue(v); }

		inline const SFTime* copy () { return new SFTime(value); }

		inline void setValue (const double v) { value = v; }
		inline const double getValue () { return value; }
};
