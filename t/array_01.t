#!/usr/bin/perl -w
#package array_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

X3DGenerator->setOutputStyle("COMPACT");

ok !new X3DArray [];
ok new X3DArray [ 1, 2, 3 ];
is new X3DArray( [ 1, 2, 3 ] ), '[ 1, 2, 3 ]';
is( X3DArray->new( [ 1, 2, 3 ] )->getLength, 3 );
is( X3DArray->new( [ 1, 2, 3 ] )->getLength, 3 );
is( X3DArray->new( [ [ 1, 2, 3 ], [ 1, 2, 3 ] ] )->getLength, 2 );

################################################################################
ok not my $array = new X3DArray;
X3DGenerator->setOutputStyle("CLEAN");
is $array, '[]';
X3DGenerator->setOutputStyle("COMPACT");
is $array, '[ ]';
X3DGenerator->setOutputStyle("TIDY");
is $array, '[ ]';
X3DGenerator->setOutputStyle("ALL");
is $array, '[ ]';
is $array->getLength, 0;
################################################################################

################################################################################
ok $array = new X3DArray [ 1 ];
X3DGenerator->setOutputStyle("CLEAN");
is $array, '1';
X3DGenerator->setOutputStyle("COMPACT");
is $array, '1';
X3DGenerator->setOutputStyle("TIDY");
is $array, '1';
X3DGenerator->setOutputStyle("ALL");
is $array, '1';
is $array->getLength, 1;
################################################################################

################################################################################
ok $array = new X3DArray [ 1, 2 ];
X3DGenerator->setOutputStyle("CLEAN");
is $array, '[1 2]';
X3DGenerator->setOutputStyle("COMPACT");
is $array, '[ 1, 2 ]';
X3DGenerator->setOutputStyle("TIDY");
is $array, '[
  1,
  2
]';
X3DGenerator->setOutputStyle("ALL");
is $array, '[
  1,
  2
]';
is $array->getLength, 2;
################################################################################

################################################################################
ok $array = new X3DArray [ 1, 2, 3, 4 ];
X3DGenerator->setOutputStyle("CLEAN");
is $array, '[1 2 3 4]';
X3DGenerator->setOutputStyle("COMPACT");
is $array, '[ 1, 2, 3, 4 ]';
X3DGenerator->setOutputStyle("TIDY");
is $array, '[
  1,
  2,
  3,
  4
]';
X3DGenerator->setOutputStyle("ALL");
is $array, '[
  1,
  2,
  3,
  4
]';
is $array->getLength, 4;
################################################################################

#
ok $array = new X3DArray [ 1 .. 100 ];

ok @$array;
ok @$array == 100;
ok( X3DArray->new( [@$array] )->getLength == 100 );
ok $array->getClone->getLength == 100;
ok $array->random->getLength == 100;

is $array <=> 100, 0;
is $array <=> 99,  1;
is $array <=> 101, -1;
ok $array == 100;
ok $array >= 100;
ok $array >= 99;
ok $array > 99;
ok $array <= 100;
ok $array <= 101;
ok $array < 101;

is 100 <=> $array, 0;
is 99 <=> $array,  -1;
is 101 <=> $array, 1;
ok 100 == $array;
ok 100 >= $array;
ok 101 >= $array;
ok 101 > $array;
ok 100 <= $array;
ok 99 <= $array;
ok 99 < $array;

is $array <=> new SFDouble(100), 0;
is $array <=> new SFDouble(99),  1;
is $array <=> new SFDouble(101), -1;
ok $array == new SFDouble(100);
ok $array >= new SFDouble(100);
ok $array >= new SFDouble(99);
ok $array > new SFDouble(99);
ok $array <= new SFDouble(100);
ok $array <= new SFDouble(101);
ok $array < new SFDouble(101);

is new SFDouble(100) <=> $array, 0;
is new SFDouble(99) <=> $array,  -1;
is new SFDouble(101) <=> $array, 1;
ok new SFDouble(100) == $array;
ok new SFDouble(100) >= $array;
ok new SFDouble(101) >= $array;
ok new SFDouble(101) > $array;
ok new SFDouble(100) <= $array;
ok new SFDouble(99) <= $array;
ok new SFDouble(99) < $array;

ok $array == $array;
ok !( $array != $array );

#print $array->shuffle;

ok X3DMath::sum( map {
		$array != $array->random
} 1 .. 1 );

ok X3DMath::sum( map {
		$array ne $array->random
} 1 .. 100 );

ok $array == $array->random->sort;
ok $array->random->sort == $array;

is $array->setLength(-23), undef;
is $array->getLength, 0;

ok $array = new X3DArray [ 'a10', 'a2', 'a1', 'a4', '1a', '10a', '5a', '2a' ];

1;
__END__
