#!/usr/bin/perl -w
#package node5_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

ok my $X3D = new X3D;
ok my $id = $X3D->size->getId;
ok my $size = $X3D->size;
#ok $X3D->size->getId != $size->getId;
is $X3D->size, 1;
is $size, 1;
is $X3D->size, $size;

is $X3D->size = 2, 2;
is $X3D->size, 2;

ok $X3D->size != $size;
ok !( $X3D->size == $size);
ok $X3D->size ne $size;
ok !( $X3D->size eq $size);

is $X3D->size, 2;
$X3D->size = $X3D->size + 1;
is $X3D->size, 3;

is $size, 1;

is $id, $X3D->size->getId;
1;
__END__


isa_ok $X3D->getField('style'),   'X3DField';
isa_ok $X3D->getField('spacing'), 'X3DField';
isa_ok $X3D->getField('string'),  'X3DField';

my $style = $X3D->style;

is $style, '"BOLD"';
is $X3D->style, '"BOLD"';

$X3D->style = 'PLAIN';
is $X3D->style, '"PLAIN"';

$X3D->style = 'BOLD';
is $X3D->style, '"BOLD"';

isa_ok $X3D->style,   'X3DField';
isa_ok $X3D->spacing, 'X3DField';
isa_ok $X3D->string,  'X3DField';

is $X3D->style,   $X3D->getField('style');
is $X3D->spacing, $X3D->getField('spacing');
is $X3D->string,  $X3D->getField('string');

ok $X3D->style eq 'BOLD';
is $X3D->style eq 'BOLD', "TRUE";
ok !( $X3D->style eq 'sss' );
is $X3D->style eq 'sss', "FALSE";

ok !( $X3D->style ne 'BOLD' );
is $X3D->style ne 'BOLD', "FALSE";
ok $X3D->style ne 'sss';
is $X3D->style ne 'sss',  "TRUE";

is $X3D->spacing, $X3D->getField('spacing');
is $X3D->string,  $X3D->getField('string');

my $field = $X3D->size;
is $X3D->size->getId, $field->getId;
 
#is $field, 1;
#is ++$field, 2;
#is $field++, 2;
#is $field, 3;
#is $X3D->size->getId, $field->getId;

#print ++( $X3D->size );
#print ++( $X3D->size );
#print ++( $X3D->size );
#print ($X3D->size)++;



