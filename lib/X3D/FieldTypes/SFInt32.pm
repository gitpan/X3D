package X3D::FieldTypes::SFInt32;

our $VERSION = '0.01';

use X3D 'SFInt32 : X3DField { 0 }';

use Math::BigInt lib => 'GMP';

use base 'X3D::BaseFieldTypes::Scalar';

sub setValue {
	my ( $this, $value ) = @_;
	
	my $int32 = Math::BigInt->new(
		defined $value ? eval { no warnings; int($value) } || 0 : $this->getDefaultValue
	);
	
	$this->X3DField::setValue($int32);
}

sub toString {
	return sprintf X3DGenerator->INT32, $_[0]->getValue;
}

1;
__END__
use overload
  '+' => sub { print "..."; $_[0]->getValue + int($_[1]) },
  ;

