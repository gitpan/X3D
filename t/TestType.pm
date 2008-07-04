package TestType;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}


use X3D::Package 'TestType {}';

sub new { shift->X3DUniversal::new }

1;
__END__
