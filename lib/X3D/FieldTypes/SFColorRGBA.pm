package X3D::FieldTypes::SFColorRGBA;

our $VERSION = '0.009';

use X3D::Package 'SFColorRGBA : X3DField { 0 0 0 0 }';

use base 'X3D::BaseFieldTypes::Vector';

sub r : lvalue { $_[0]->[0] }

sub g : lvalue { $_[0]->[1] }

sub b : lvalue { $_[0]->[2] }

sub a : lvalue { $_[0]->[3] }

1;
__END__
