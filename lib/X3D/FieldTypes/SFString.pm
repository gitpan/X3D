package X3D::FieldTypes::SFString;

our $VERSION = '0.01';

use X3D 'SFString : X3DField { "" }';

use base 'X3D::BaseFieldTypes::Scalar';

use Unicode::String;
#Text::Unidecode;
use overload
  #  '0+' => 'length',
  '~' => sub { ~$_[0]->getValue },
  ;

#sub getInitialValue { $_[0]->getDefinition->getValue }

sub setValue {
	my ( $this, $value ) = @_;
	$value = $value->getValue if UNIVERSAL::isa($value, 'SFString');
	$this->X3DField::setValue( defined $value ? "$value" : $this->getDefaultValue );
}

sub toString { sprintf X3DGenerator->STRING, $_[0]->getValue }

1;
__END__

