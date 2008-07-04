package X3D::FieldTypes::SFBool;

our $VERSION = '0.009';

use X3D::Package 'SFBool : X3DField { FALSE }';

use base 'X3D::BaseFieldTypes::Scalar';

sub setValue {
	my ( $this, $value ) = @_;
	$this->X3DField::setValue( defined $value ? ($value ? YES: NO) : $this->getDefaultValue );
}

sub toString { $_[0]->getValue ? X3DGenerator->TRUE: X3DGenerator->FALSE }

1;
__END__
