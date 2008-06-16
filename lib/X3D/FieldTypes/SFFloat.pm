package X3D::FieldTypes::SFFloat;

our $VERSION = '0.01';

use X3D 'SFFloat : SFDouble { 0 }';

use base 'X3D::BaseFieldTypes::Scalar';

sub toString { sprintf X3DGenerator->FLOAT, $_[0]->getValue }

1;
__END__
Data::Float 
