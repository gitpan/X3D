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
#	SFInt32		[in,out] sfdouble	   0
}
';

ok my $testNode = new TestNode;
print $testNode;

{
   is $testNode->sfint32->getType, 'SFInt32';
   is $testNode->sfint32, '0';
}
print "---";


use Benchmark ':hireswallclock';
#my $v = 0;
#timethis( -64, sub { $v = $testNode->sfint32 } );	# 5807.21/s
#timethis( -64, sub { $testNode->sfint32 = $v } );	# 5036.40/s

#open STDERR, ">/dev/null";
#timethis( -64, sub { print STDERR $testNode->sfint32  } );	# 5875.65/s

#timethis( -64, sub { $testNode = new TestNode  } );	# 3159.59/s

#timethis( -64, sub { $testNode->sfint32++  } );	# 2082.00/s

1;
__END__

ok 1 - use X3D;
ok 2
DEF _14671120 TestNode { }
ok 3
ok 4
X3DInt32::DESTROY at /home/holger/Desktop/holger/perl/cpan/X3D/t/nodefield_07.t line 26.	# created in line 24
---
X3DInt32::DESTROY.											# Value of the sfint32 in instance $testNode of TestNode
1..3
X3DInt32::DESTROY during global destruction.			# Default value of the sfint32 in TestNodes fieldDefinitions
X3DInt32::DESTROY during global destruction.			# Default value of an SFInt32 field; stored in the fieldDefinition
