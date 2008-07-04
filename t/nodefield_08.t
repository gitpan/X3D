#!/usr/bin/perl -w
#package nodefield_06
use Test::More no_plan;
use strict;

BEGIN {
   $| = 1;
   chdir 't' if -d 't';
   unshift @INC, '../lib';
   use_ok 'X3D';
}

use X3D::Package 'TestNode : X3DBaseNode {
	SFInt32		[in,out] sfint32	   0
}
';

ok my $testNode = new TestNode;
use Benchmark ':hireswallclock';

is ref($testNode->sfint32 + 1), '';

my $i = new SFInt32(1);
my $j;
$j = $i++;
#timethis( -1, sub { $j = $i++  } );	# 10048.92/s
isa_ok $i, 'SFInt32';
is $i, $j +1;

$i = new X3DInt32(1);
is $i << new SFFloat(1), 2;
is $i << new SFFloat(2), 4;
is $i << new SFFloat(3), 8;

$i = new SFFloat(1);
is $i << new X3DInt32(1), 2;
is $i << new X3DInt32(2), 4;
is $i << new X3DInt32(3), 8;


$i = new SFFloat(1);
$j = $i++;
#timethis( -1, sub { $j = $i++  } );	# 10048.92/s
isa_ok $i, 'SFFloat';
is $i, $j +1;

$i **= 2;
print $i;

$i = new SFVec3f(1,2,3);
#timethis( 1000, sub { $i++  } );	# 23809523.81/s
$j = $i++;
isa_ok $i, 'SFVec3f';
is $i, $j +1;

1;
__END__
