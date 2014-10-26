package X3D::FieldTypes::SFVec4d;

our $VERSION = '0.009';

use X3D 'SFVec4d : X3DField { 0 0 0 0 }';

use base 'X3D::BaseFieldTypes::Vector';

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

sub z : lvalue { $_[0]->[2] }

sub w : lvalue { $_[0]->[3] }

1;
__END__
