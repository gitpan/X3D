#!/usr/bin/perl -w
#package values_vec4_01
use Test::More no_plan;
use strict;

BEGIN {
   $| = 1;
   chdir 't' if -d 't';
   unshift @INC, '../lib';
	use_ok('X3D::Values');
}

{
   my $int32 = new X3D::Values::Int32("0");
   is $int32, "0";
   is $int32->setValue(10), undef;
   is $int32->getValue, 10;
   is $int32->toString(), "10";
	

   is new X3D::Values::Int32(2), 2;
   is new X3D::Values::Int32(), 0;
}

{
   my $int32 = new X3D::Values::Int32();
   isa_ok $int32, "X3DInt32";
   isa_ok $int32, "X3D::Values::Int32";
   is $int32->getValue(), 0;
   isa_ok $int32->getClone, "X3DInt32";
   isa_ok $int32->getClone, "X3D::Values::Int32";
   is $int32, "0";
   is $int32->getValue(), 0;
   is $int32->getClone->getValue, 0;
   is $int32->setValue(10), undef;
   is $int32->getValue(), 10;
   is $int32->getClone, 10;
   is $int32->toString(), "10";
}

{
   my $int32 = new X3DInt32();
   isa_ok $int32, "X3DInt32";
   isa_ok $int32, "X3D::Values::Int32";
   isa_ok $int32->getClone, "X3DInt32";
   isa_ok $int32->getClone, "X3D::Values::Int32";
   is $int32, "0";
   is $int32->getValue(), 0;
   is $int32->setValue(10), undef;
   is $int32->getValue(), 10;
   is $int32->toString(), "10";
}

{
   my $int32 = new X3DInt32();
   is $int32 += 2, 2;
   is $int32, 2;
   is my $i = $int32 + 2, 4;
   is $int32, 2;
   is $i, 4;
   isa_ok $i, "X3D::Values::Int32";
   isa_ok $i->getValue, "Math::BigInt";
}

__END__
