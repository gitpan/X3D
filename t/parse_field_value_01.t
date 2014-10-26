#!/usr/bin/perl -w
#package parse_field_value_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

my ( $s, $v );

$s = sprintf "%g %g %g", rand, rand, rand;
print ref X3D::Parse::FieldValue::sfvec3fValue( \$s );

#use Benchmark ':hireswallclock';
#timethis( 100_000, sub { pos($s) = undef; X3D::Parse::FieldValue::sfvec3fValue( \$s ) } );#3.78163

for ( 1 .. 100 ) {
	pos($s) = undef;
	ok X3D::Parse::FieldValue::sfvec3fValue( \$s );
}

1;
__END__
