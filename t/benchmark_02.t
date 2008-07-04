#!/usr/bin/perl -w
#package benchmark_02
use Test::More no_plan;
#use Test::Benchmark;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeFields';
}

no warnings;
use Benchmark ':hireswallclock';
use warnings;

my $var =  new SFInt32(32.2);
print $var;
print $var + 0.8;

#timethis( -6, sub { $var->toString1 } );
#timethis( -6, sub { $var->toString } );
#timethis( -3, sub { $int32->setValue1("xxx") } );

1;
__END__

Sort::Naturally 

use Math::Int64;
my $a = Math::Int32::int32(1);

timethis( -6, sub { $a|=1 } );
timethis( -6, sub { $b|=1 } );

:
my $a = Math::Int32::int32(1);
timethis( -6, sub { $a++ } );
timethis for 6: 6.04528 wallclock secs ( 6.05 usr +  0.00 sys =  6.05 CPU) @ 1308656.86/s (n=7917374) 

