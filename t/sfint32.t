#!/usr/bin/perl -w
#package nodefield_sfint32_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

my $sfint32 = new SFInt32(0);
ok my $sfint32Id = $sfint32->getId;
is $sfint32Id, $sfint32->getId;

is $sfint32, 0;
is $sfint32 ? 1 : 0, 0;
is $sfint32->setValue(1), undef;
is $sfint32, 1;
is $sfint32 ? 1 : 0, 1;
is $sfint32->setValue(2), undef;
is $sfint32, 2;
is $sfint32 ? 1 : 0, 1;
is $sfint32->setValue(2.3), undef;
is $sfint32, 2;
is int $sfint32, 2;
is $sfint32, 2;
ok !( $sfint32 == 3 );
ok !( $sfint32 != 2 );
ok $sfint32 != 3;
ok $sfint32 == 2;
is $sfint32, 2;
ok $sfint32 eq 2;
ok !( $sfint32 eq 3 );
ok !( $sfint32 ne 2 );
ok $sfint32 ne 3;

is $sfint32->setValue(0xFFFFFFFF), undef;
is $sfint32, -1;
is $sfint32->setValue(0x7FFFFFFF), undef;
is $sfint32, '2147483647';
is $sfint32->setValue(2), undef;
is $sfint32, '2';

ok $sfint32 == 2;
ok $sfint32->getValue == 2;
is $sfint32, 2;

is $sfint32, 2;
is $sfint32 + 1, 3;
is $sfint32 + 1, 3;

is $sfint32, 2;
is $sfint32 -= 8, -6;
is $sfint32 -= 3, -9;

is $sfint32 += 5, -4;
is $sfint32 += 5, 1;
is $sfint32 += 1, 2;

print '#' x 44;
is $sfint32 += 1.7, 3;
is $sfint32->getValue, 3;

isa_ok $sfint32->getValue, 'X3DInt32';

is $sfint32 += 1,   4;
is $sfint32 += 6,   10;
is ++$sfint32, 11;
is ++$sfint32, 12;
is ++$sfint32, 13;
is ++$sfint32, 14;
is ++$sfint32, 15;

isa_ok $sfint32->getValue, 'X3DInt32';

is $sfint32++, 15;
is $sfint32++, 16;
is $sfint32++, 17;
is $sfint32++, 18;
is $sfint32++, 19;

isa_ok $sfint32->getValue, 'X3DInt32';

is $sfint32 -= 18, 2;
is $sfint32**= 4, 16;
is 2**$sfint32, 65536;
is $sfint32 %= 3, 1;
is $sfint32 += 3, 4;
is $sfint32 /= 2, 2;
isa_ok $sfint32, 'SFInt32';
is $sfint32, 2;

is 1 / $sfint32, 1/2;

is $sfint32->setValue(0.3), undef;
is $sfint32, 0;

is $sfint32 <=> 0.3, 0 <=> 0.3;
is $sfint32 <=> 0,   0 <=> 0;
is $sfint32 <=> 1,   0 <=> 1;
is 0.3 <=> $sfint32, 0.3 <=> 0;
is 0 <=> $sfint32,   0 <=> 0;
is 1 <=> $sfint32,   1 <=> 0;

is $sfint32, 0;

ok $sfint32 <= 0.3;
ok $sfint32 <= 9;
ok $sfint32 >= -1;
ok $sfint32 >= 0;
ok $sfint32 < 9;
ok 9 > $sfint32;
ok $sfint32 > -1;
ok -2 < $sfint32;

ok !( $sfint32 cmp 0 );
ok !( 0 cmp $sfint32 );
ok $sfint32 lt 9;
ok $sfint32 gt -1;

is $sfint32 . $sfint32, "00";

is $sfint32->setValue(1.3), undef;
is $sfint32, 1;

is ++$sfint32, 2;
is ++$sfint32, 3;
is $sfint32, 3;
is $sfint32 << 2, 3 << 2;
is $sfint32 <<= 2, 3 << 2;

is $sfint32->setValue(1), undef;
is $sfint32, 1;
is $sfint32 << 2, 1 << 2;
is $sfint32->setValue(1), undef;
is $sfint32, 1;

is $sfint32->setValue(1), undef;
is $sfint32, 1;
is $sfint32 <<= 2, 1 << 2;

is $sfint32->setValue(1), undef;
is $sfint32, 1;
is $sfint32 - 2, 1 - 2;
is $sfint32, 1;
is $sfint32 -= 2, 1 - 2;

is $sfint32->setValue(1), undef;
is $sfint32, 1;
is $sfint32 << 2, 1 << 2;
is $sfint32, 1;
is $sfint32 <<= 2, 1 << 2;

isa_ok $sfint32, "SFInt32";

is $sfint32, 4;
is $sfint32 >>= 1, 2;
is $sfint32, 2;
is $sfint32 x 4, 2222;
is $sfint32 |= 1, 3;
is $sfint32 &= 2, 2;
is $sfint32 ^= 3, 1;
is - $sfint32, -1;

is $sfint32, 1;
is ~$sfint32, -2;
is $sfint32->setValue(~$sfint32), undef;
is $sfint32, -2; #-2
is ~$sfint32, 1;
is ~~$sfint32, ~1;

#is 0xFFFFFFFF, 4294967295;
#is 0xEFFFFFFF, 4026531839;

is $sfint32->setValue(4294967294), undef;
is ++$sfint32, -1;

is cos( $sfint32 ), cos(-1);
is sin( $sfint32 ), sin(-1);
is exp( $sfint32 ), exp(-1);
is abs( $sfint32 ), abs(-1);

is $sfint32->setValue(10), undef;
is $sfint32, 10;
is log( $sfint32 ), log(10);
is sqrt( $sfint32 ), sqrt(10);
is $sfint32->setValue(-1.3), undef;
is $sfint32, -1;
is abs( $sfint32 ), 1;
is !$sfint32, !1;
is $sfint32, -1;
is -$sfint32, 1;

is ref $sfint32, 'SFInt32';

is $sfint32->setValue(0b10110), undef;
is $sfint32 & 0b10011, 0b10010;
is ~$sfint32  & 0b11111, 0b01001;

isa_ok $sfint32->getValue, 'X3DInt32';

#is $sfint32Id, $sfint32->getId;
1;
__END__



