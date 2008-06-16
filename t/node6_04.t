#!/usr/bin/perl -w
#package node6_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

X3DGenerator->setOutputStyle("COMPACT");
ok my $X3D = new X3D;
ok my $id   = $X3D->size->getId;
ok my $size = $X3D->size;
#ok $X3D->size->getId != $size->getId;

is $X3D->size, 1;
is $size, 1;

$X3D->size = $X3D->size + 1;
is $X3D->size, 2;

$X3D->size = $X3D->size - 1;
is $X3D->size, 1;

$X3D->size = 10 - $X3D->size;
is $X3D->size, 9;

$X3D->size = 2 + $X3D->size;
is $X3D->size, 11;
is $X3D->size + 3, 14;
#is ref($X3D->size + 3), NO;

is $size, 1;
is $id,   $X3D->size->getId;

is $size++, 1;
is $size++, 2;
is $size, 3;

is $size--, 3;
is $size--, 2;
is $size, 1;

is ++$size, 2;
is ++$size, 3;
is $size, 3;

is --$size, 2;
is --$size, 1;
is $size, 1;

my $s = $size;
#print $size->getId;
is $size += 2, 3;
#print $size->getId;
is $size += 2, 5;
#print $size->getId;
is $size -= 2, 3;
is $size -= 4, -1;
#print $size->getId;

is( $size = $size + 0, -1 );
is( $size = 0 + $size, -1 );
#isa_ok $size, 'SFFloat';

is $s, 1;
#ok $s->getId != $size->getId;

$X3D->size = 16;

is $X3D->size, 16;

#isa_ok $X3D->size, '';
is $X3D->size += 3, 19;

is $X3D->size += 3, 22;
is $X3D->size += 3, 25;
is $X3D->size -= 3, 22;
is $X3D->size -= 3, 19;
is $X3D->size, 19;

is ++$X3D->size, 20;
is ++$X3D->size, 21;
is ++$X3D->size, 22;
is $X3D->size++, 22;
is $X3D->size++, 23;
is $X3D->size++, 24;
is $X3D->size, 25;

is --$X3D->size, 24;
is --$X3D->size, 23;
is --$X3D->size, 22;
is --$X3D->size, 21;
is $X3D->size--, 21;
is $X3D->size--, 20;
is $X3D->size--, 19;
is $X3D->size--, 18;
is $X3D->size, 17;

is $X3D->size, 17;
is $X3D->size += 3, 20;
is $X3D->size, 20;

is $X3D->size += 3, 23;
is $X3D->size += 3, 26;
is $X3D->size, 26;
is $X3D->size, 26;

is $X3D->size -= 3, 23;
is $X3D->size -= 3, 20;
is $X3D->size -= 3, 17;
is $X3D->size, 17;

is $size, -1;
#isa_ok $size, 'SFFloat';
#ok $X3D->size->getId != $size->getId;

is $X3D->floats, '[ 1, 2, 3 ]';
#$X3D->floats->[2] = 3;
#is $X3D->floats, '[ 1, 2, 3 ]';

print "x" x 23;

is $X3D->getField('size'),     17;
isa_ok $X3D->getField('size'), 'SFFloat';
is $X3D->getField('size'),     $X3D->size;
is $X3D->getField('size')->getId, $X3D->size->getId;
is $X3D->getField('size')->getId, $id;
is $X3D->size->getId, $id;

eval { $X3D->getValue };
ok $@;

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



