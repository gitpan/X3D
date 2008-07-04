package X3D::FieldTypes::SFDouble;

our $VERSION = '0.01';

use X3D::Package 'SFDouble : X3DField { 0 }';

use base 'X3D::BaseFieldTypes::Scalar';

sub setValue {
   my ( $this, $value ) = @_;

   $this->X3DField::setValue(
      defined $value
      ? eval { no warnings; $value + 0 } || 0
      : $this->getDefaultValue
   );
}

sub toString { sprintf X3DGenerator->DOUBLE, $_[0]->getValue }

1;
__END__
