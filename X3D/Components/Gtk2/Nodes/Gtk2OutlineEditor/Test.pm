package Test;
use strict;
use warnings;

use Object::Array;

use base qw(Object::Array);

sub test {
	my ($this) = @_;
	
	push @$this, 123;
	#printf "%s\n", $this->{c} = 1;
	printf "%s\n", $this->[0];

}

sub PUSH {
	my ($this) = @_;
	printf "push\n";
}

Test->new->test;

1;
