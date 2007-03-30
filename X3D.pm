package X3D;
use strict;
use warnings;

use rlib 'X3D';

use X3DBrowser;

use base qw(Exporter);

our @EXPORT = qw(createBrowser getBrowser Browser);

sub createBrowser { X3DBrowser->createBrowser }
sub getBrowser    { X3DBrowser->getBrowser }
sub Browser       { X3D::getBrowser }

1;
__END__

=head1 NAME

X3D - X3D Developer Toolkits

=head1 SYNOPSIS

	use X3D;
	
	my $scene = Browser->createX3DFromString("Group{}");

	printf $scene;

=head1 DESCRIPTION


=head1 SEE ALSO

http://www.web3d.org/

=head1 AUTHOR

Holger Seelig <holger.seelig@yahoo.de>

=cut
