#!/usr/bin/perl -w
#package nodefield_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

ok my $X3D    = new X3DTest;
ok my $styleId = $X3D->style->getId;
is $styleId, $X3D->style->getId;
is $X3D->metadata, undef;
is ref $X3D->metadata, '';
ok not my $sfnode = $X3D->metadata;
is ref $sfnode, '';


ok my $sizeId = $X3D->size->getId;
is $sizeId, $X3D->size->getId;

is $X3D->style, 'BOLD';
is ref $X3D->style, '';
#isa_ok $X3D->style, 'SFString';
#isa_ok $X3D->style, 'X3DField';    #8

ok not ref $X3D->style;
ok tied $X3D->style;
ok ref tied $X3D->style;
ok not new SFBool ref $X3D->style;
ok new SFBool tied $X3D->style;
ok new SFBool ref tied $X3D->style;
isa_ok tied $X3D->style, 'X3D::Tie::Field';    #15

isa_ok $X3D->getField('metadata'), 	'SFNode';
isa_ok $X3D->getField('metadata'), 	'SFNode';
isa_ok $X3D->getField('family'),		'MFString';
isa_ok $X3D->getField('horizontal'),  'SFBool';
isa_ok $X3D->getField('justify'),  	'MFString';
isa_ok $X3D->getField('string'),		'MFString';
isa_ok $X3D->getField('language'), 	'SFString';
isa_ok $X3D->getField('leftToRight'), 'SFBool';
isa_ok $X3D->getField('size'),  		'SFFloat';
isa_ok $X3D->getField('spacing'),  	'SFFloat';
isa_ok $X3D->getField('style'), 		'SFString';
isa_ok $X3D->getField('topToBottom'), 'SFBool';

isa_ok tied $X3D->getFields->getTiedField('metadata'),    'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('family'), 	  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('horizontal'),  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('justify'),	  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('string'), 	  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('language'),    'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('leftToRight'), 'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('size'),		  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('spacing'),	  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('style'),  	  'X3D::Tie::Field';
isa_ok tied $X3D->getFields->getTiedField('topToBottom'), 'X3D::Tie::Field';

ok tied $X3D->getFields->getTiedField('metadata');
ok tied $X3D->getFields->getTiedField('family');
ok tied $X3D->getFields->getTiedField('horizontal');
ok tied $X3D->getFields->getTiedField('justify');
ok tied $X3D->getFields->getTiedField('string');
ok tied $X3D->getFields->getTiedField('language');
ok tied $X3D->getFields->getTiedField('leftToRight');
ok tied $X3D->getFields->getTiedField('size');
ok tied $X3D->getFields->getTiedField('spacing');
ok tied $X3D->getFields->getTiedField('style');
ok tied $X3D->getFields->getTiedField('topToBottom');

is ref $X3D->getField('metadata'), 	'SFNode';
is ref $X3D->getField('family'),		'MFString';
is ref $X3D->getField('horizontal'),  'SFBool';
is ref $X3D->getField('justify'),  	'MFString';
is ref $X3D->getField('string'),		'MFString';
is ref $X3D->getField('language'), 	'SFString';
is ref $X3D->getField('leftToRight'), 'SFBool';
is ref $X3D->getField('size'),  		'SFFloat';
is ref $X3D->getField('spacing'),  	'SFFloat';
is ref $X3D->getField('style'), 		'SFString';
is ref $X3D->getField('topToBottom'), 'SFBool';

is ref $X3D->metadata,    '';
is ref $X3D->family,      'X3DArray';
is ref $X3D->horizontal,  '';
is ref $X3D->justify,     'X3DArray';
is ref $X3D->string,      'X3DArray';
is ref $X3D->language,    '';
is ref $X3D->leftToRight, '';
is ref $X3D->size,        '';
is ref $X3D->spacing,     '';
is ref $X3D->style,       '';
is ref $X3D->topToBottom, '';

# isa_ok $X3D->metadata,    'X3DField';
# isa_ok $X3D->family,      'X3DField';
# isa_ok $X3D->horizontal,  'X3DField';
# isa_ok $X3D->justify,     'X3DField';
# isa_ok $X3D->string,      'X3DField';
# isa_ok $X3D->language,    'X3DField';
# isa_ok $X3D->leftToRight, 'X3DField';
# isa_ok $X3D->size,        'X3DField';
# isa_ok $X3D->spacing,     'X3DField';
# isa_ok $X3D->style,       'X3DField';
# isa_ok $X3D->topToBottom, 'X3DField';

ok my $style = $X3D->style;
ok my $name  = $X3D->style->getName;

is $style, 'BOLD';
is $X3D->style, 'BOLD';

is $X3D->style->getName, 'style';
is $X3D->style->getName, $name;
#is $style->getName, '';

$X3D->style = 'PLAIN';
is $X3D->style, 'PLAIN';

$X3D->style = 'BOLD';
is $X3D->style, 'BOLD';

#isa_ok $X3D->style,   'X3DField';
#isa_ok $X3D->spacing, 'X3DField';
#isa_ok $X3D->string,  'X3DField';

is $X3D->style,   $X3D->getField('style')->getValue;
is $X3D->spacing, $X3D->getField('spacing')->getValue;
is $X3D->string,  $X3D->getField('string')->getValue;

ok $X3D->style eq 'BOLD';
ok !( $X3D->style eq 'sss' );

ok !( $X3D->style ne 'BOLD' );
ok $X3D->style ne 'sss';

is $X3D->spacing, $X3D->getField('spacing');
is $X3D->string,  $X3D->getField('string');

my $field = $X3D->size;                        #25 # $X3D->size->clone
is ref $field, '';
#ok $X3D->size->getId != $field->getId;         #26
ok $X3D->size->getId == $X3D->size->getId;    #27

is $field, 1;                                   #28
is ++$field, 2;                                 #29
is $field++, 2;                                 #30
is $field, 3;                                   #31
#ok $X3D->size->getId != $field->getId;         #32

$field = $X3D->size;                        #25 # $X3D->size->clone
#ok $X3D->size->getId != $field->getId;         #26
#$field->setValue(123);

ok $X3D->size = 2;                             #33
is $X3D, 'X3DTest {
  size 2
}';                                             #34

is ++$X3D->size, 3;                            #115
is ++$X3D->size, 4;                            #116
is ++$X3D->size, 5;                            #117
is ++$X3D->size, 6;                            #118
is $X3D->size++, 6;
is $X3D->size++, 7;
is $X3D->size++, 8;
is $X3D->size, 9;

is $X3D, 'X3DTest {
  size 9
}';

print '';
print $X3D->style;

print '';
my $style2 = $X3D->style;
print $style2 ;

#sub noop { shift }
#is noop($X3D->style)->getId, $X3D->style->getId;

#sub test_id { shift->getId }
#is test_id($X3D->style), $X3D->style->getId;

my $id1 = $X3D->style->getId;
my $id2 = $X3D->style->getId;
my $id3 = $X3D->style->getId;
is $id1, $id2;
is $id1, $id3;
is $id2, $id3;
is $id2, $X3D->getField('style')->getId;

#sub test_name{ shift->getName }
#is test_name($X3D->style), $X3D->style->getName;
#is test_name($X3D->style), 'style';

$X3D->style = 'BOLD';
#sub test_value { shift->getValue }
#is test_value($X3D->style), $X3D->style->getValue;
#is test_value($X3D->style), 'BOLD';

#sub test_value2 { $_[0]->setValue('BOLDITALIC'); shift }
#is test_value2($X3D->style), $X3D->style;
#is test_value2($X3D->style), '"BOLDITALIC"';

$X3D->style->setValue('BOLD');
is $X3D->style, 'BOLD';

is $styleId, $X3D->style->getId;
is $sizeId,  $X3D->size->getId;

1;
__END__

