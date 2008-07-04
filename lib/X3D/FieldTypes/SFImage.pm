package X3D::FieldTypes::SFImage;

our $VERSION = '0.009';

use X3D::Package 'SFImage : X3DField { 0 0 0 }';

sub setValue {
	my ( $this, @value ) = @_;

	return $this->X3DField::setValue( $value[0]->getValue->getClone )
		  if UNIVERSAL::isa( $value[0], 'SFImage' );

	$this->X3DField::setValue( new X3DImage(@value) );
}

sub create {
   my ($this) = @_;
   $this->{value} = $this->getInitialValue;
   return;
}

sub toString {
	return $_[0]->getValue->toString;
}

1;
__END__
