package X3D::Parse::Float;
use X3D::Perl;

our $VERSION = '0.001';

use X3D::RegularExpressions qw.$_float $_nan $_inf.;

use Exporter 'import';

our @EXPORT_OK = qw.parseFloat float.;

sub parseFloat { &float( \$_[0] ) }

sub float {
	return 0 + $1 if ${ $_[0] } =~ m.$_float.gc;
	return 0      if ${ $_[0] } =~ m.$_nan.gc;
	#return ...  if $$string =~ m.$_inf.gc;
	#X3DError::Debug "VRML2::Parser::float undef\n";
	return;
}

1;
__END__
