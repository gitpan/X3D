#!/usr/bin/perl -w
#package generator_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

can_ok 'X3DGenerator', 'TRUE';
can_ok 'X3DGenerator', 'FALSE';
can_ok 'X3DGenerator', 'NULL';

can_ok 'X3DGenerator', 'tab';
can_ok 'X3DGenerator', 'space';
can_ok 'X3DGenerator', 'break';

can_ok 'X3DGenerator', 'indent';

can_ok 'X3DGenerator', 'inc';
can_ok 'X3DGenerator', 'dec';

can_ok 'X3DGenerator', 'tidy_space';
can_ok 'X3DGenerator', 'tidy_break';

is (X3DGenerator->getPrecisionOfFloat, 7);
is (X3DGenerator->getPrecisionOfDouble, 14);
is (X3DGenerator->getOutputStyle, "TIDY");

__END__

