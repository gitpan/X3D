#!/usr/bin/perl -w
#package field_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

ok !(my $sfnode1 = new SFNode);
is $sfnode1->getType, "SFNode";
is $sfnode1->getAccessType, X3DConstants->inputOutput;
#ok $sfnode1->isReadable;
#ok $sfnode1->isWritable;

__END__

