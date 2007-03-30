package SFBool;
use strict;
use warnings;

use rlib "../";

BEGIN {
	our $VERSION = '0.00';

	use DynaLoader;
	our @ISA = qw(DynaLoader);
	sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }

	# now load the XS code.
	__PACKAGE__->bootstrap($VERSION);
}

# Preloaded methods go here.

use X3DGenerator;
use Attribute::Overload;

use overload
  "<=>" => sub { $_[2] ? $_[1] <=> $_[0]->getValue : $_[0]->getValue <=> $_[1] },

  "+" => sub { $_[0]->getValue + $_[1] },
  "-" => sub { $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] },
  "*" => sub { $_[0]->getValue * $_[1] },
  "/" => sub { $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] },

  "0+" => sub { $_[0]->getValue },

  "=" => \&copy,
  ;

sub toString : Overload("") {
	return $_[0]->getValue ? $X3DGenerator::TRUE : $X3DGenerator::FALSE;
}

1;
__END__
use SFColor;
use Benchmark qw(timethis);

my $f = new SFBool(10);
my $n = new SFBool(10);
timethis (2000000, sub { $f = new SFBool });
timethis (2000000, sub { $f = new SFColor });

#timethis (2000000, sub { $f = $f + 0.1 });
#timethis (2000000, sub { $f += 0.1 });
#timethis (2000000, sub { $f = $f->add($n) });
#timethis (2000000, sub { $f += $n });
#timethis (2000000, sub { $n = new SFColor; });

printf "%s\n", $f;
printf "%s\n", TRUE;
