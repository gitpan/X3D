package MFNode;
use strict;
use warnings;

use rlib "./";

use MFScalar;
use base qw(MFScalar);

use SFNode;
our $SField = new SFNode;

sub toString {
	my $this = shift;

	return "[${X3DGenerator::TSPACE}]" unless @$this;

	my $string = '';
	if ($#$this) {
		$string .= "[${X3DGenerator::TBREAK}";
		X3DGenerator::INC_INDENT;
		$string .= $X3DGenerator::INDENT;
		$string .= join ",${X3DGenerator::TBREAK}${X3DGenerator::INDENT}", @$this;
		X3DGenerator::DEC_INDENT;
		$string .= "${X3DGenerator::TBREAK}${X3DGenerator::INDENT}]";
	} else {
		$string .= $this->[0];
	}

	return $string;
}

1;
__END__
