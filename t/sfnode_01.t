#!/usr/bin/perl -w
#package sfnode_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

#X3DGenerator->setOutputStyle("COMPACT");
ok my $sfnode1 = new SFNode(new X3D);
ok my $sfnode2 = new SFNode(new X3D);

1;
__END__
