package X3D::Tie::Field;
use X3D::Perl;

our $VERSION = '0.01';

use Tie::Scalar;
use base 'Tie::StdScalar';

sub TIESCALAR { bless \$_[1], $_[0] }

# bug # the copies of the value are not destroyed
sub FETCH { ${ $_[0] }->getClone->getValue }

sub STORE { ${ $_[0] }->setValue( $_[1] ) }

1;
__END__
