package X3D::Parse::String;
use X3D::Perl;

our $VERSION = '0.009';

use X3D::RegularExpressions '$_string';

use Exporter 'import';

our @EXPORT_OK = qw.parseString string.;

sub parseString { &string( $_[0] ) }

sub string {
	return $1 if ${$_[0]} =~ m.$_string.gc;
	return;
}

1;
__END__
