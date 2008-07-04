package X3D::FieldTypes::SFVec3d;

our $VERSION = '0.009';

use X3D::Package 'SFVec3d : X3DField { 0 0 0 }';

use base 'X3D::BaseFieldTypes::Vector';

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

sub z : lvalue { $_[0]->[2] }

1;
__END__
