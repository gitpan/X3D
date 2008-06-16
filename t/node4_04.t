#!/usr/bin/perl -w
#package node4_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

ok new SFNode( new X3D );
ok my $X3D = new X3D;
isa_ok $X3D->getField('style'),   'X3DField';
isa_ok $X3D->getField('spacing'), 'X3DField';
isa_ok $X3D->getField('string'),  'X3DField';

my $style = $X3D->getField('style');

is $style, '"BOLD"';
is $X3D->getField('style'), '"BOLD"';

$X3D->getField('style')->setValue('PLAIN');
is $X3D->getField('style'), '"PLAIN"';

$X3D->getField('style')->setValue('BOLD');
is $X3D->getField('style'), '"BOLD"';

isa_ok $X3D->getField('style'),   'X3DField';
isa_ok $X3D->getField('spacing'), 'X3DField';
isa_ok $X3D->getField('string'),  'X3DField';

is $X3D->getField('style'),   $X3D->getField('style');
is $X3D->getField('spacing'), $X3D->getField('spacing');
is $X3D->getField('string'),  $X3D->getField('string');

ok $X3D->getField('style') eq 'BOLD';
ok !( $X3D->getField('style') eq 'sss' );

ok !( $X3D->getField('style') ne 'BOLD' );
ok $X3D->getField('style') ne 'sss';

is $X3D->getField('spacing'), $X3D->getField('spacing');
is $X3D->getField('string'),  $X3D->getField('string');

is $X3D->getField('size'), 1;
my $field = $X3D->getField('size');
ok $X3D->getField('size')->getId == $field->getId;

is $field, 1;
is ++$field, 2;
is $field++, 2;
is $field, 3;
is $X3D->getField('size'), 1;
#ok $X3D->getField('size')->getId != $field->getId;

1;
__END__



