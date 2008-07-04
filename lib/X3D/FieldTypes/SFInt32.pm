package X3D::FieldTypes::SFInt32;

our $VERSION = '0.01';

use X3D::Package 'SFInt32 : X3DField { 0 }';

use base 'X3D::BaseFieldTypes::Scalar';

sub create {
   my ($this) = @_;
   $this->{value} = $this->getInitialValue->getClone;
   return;
}

sub setValue {
   my ( $this, $value ) = @_;
   my $scalar = $this->{value};

   $scalar->setValue(
      defined $value
      ? $value
      : $this->getDefaultValue
   );

   $this->X3DField::setValue($scalar);
}

sub toString {
   return sprintf X3DGenerator->INT32, $_[0]->getValue;
}

1;
__END__
use overload
  '+' => sub { print "..."; $_[0]->getValue + int($_[1]) },
  ;

