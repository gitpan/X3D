package X3D::Values::Vec4;
use X3D::Perl;

our $VERSION = '0.009';

use Package::Alias X3DVec4 => __PACKAGE__;

use X3D::Values::Vector;
use base 'X3DVector';

use overload "x" => 'cross';

use constant getDefaultValue => [ 0, 0, 0, 0 ];

sub setX { $_[0]->[0] = $_[1]; return }

sub setY { $_[0]->[1] = $_[1]; return }

sub setZ { $_[0]->[2] = $_[1]; return }

sub setW { $_[0]->[3] = $_[1]; return }

sub getReal { new X3DVec3( [ @{ $_[0] }[ 0, 1, 2 ] ] ) }

sub getX { $_[0]->[0] }

sub getY { $_[0]->[1] }

sub getZ { $_[0]->[2] }

sub getW { $_[0]->[3] }

sub x : lvalue { $_[0]->[0] }

sub y : lvalue { $_[0]->[1] }

sub z : lvalue { $_[0]->[2] }

sub w : lvalue { $_[0]->[3] }

sub negate {
	my ($a) = @_;
	return $a->new( [
			-$a->[0],
			-$a->[1],
			-$a->[2],
			-$a->[3],
	] );
}

sub add {
	my ( $a, $b ) = @_;
	return
	  $a->new( [ ref $b ? (
				$a->[0] + $b->[0],
				$a->[1] + $b->[1],
				$a->[2] + $b->[2],
				$a->[3] + $b->[3],
			  ) : (
				$a->[0] + $b,
				$a->[1] + $b,
				$a->[2] + $b,
				$a->[3] + $b,
			  ) ] );
}

use overload '+=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] += $b->[0];
		$a->[1] += $b->[1];
		$a->[2] += $b->[2];
		$a->[3] += $b->[3];
	} else {
		$a->[0] += $b;
		$a->[1] += $b;
		$a->[2] += $b;
		$a->[3] += $b;
	}
	return $a;
};

sub subtract {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] - $a->[0],
				$b->[1] - $a->[1],
				$b->[2] - $a->[2],
				$b->[3] - $a->[3],
			  ) : (
				$a->[0] - $b->[0],
				$a->[1] - $b->[1],
				$a->[2] - $b->[2],
				$a->[3] - $b->[3],
			  ) ] )
	  : $a->new( [
			$a->[0] - $b,
			$a->[1] - $b,
			$a->[2] - $b,
			$a->[3] - $b,
	  ] );
}

use overload '-=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] -= $b->[0];
		$a->[1] -= $b->[1];
		$a->[2] -= $b->[2];
		$a->[3] -= $b->[3];
	} else {
		$a->[0] -= $b;
		$a->[1] -= $b;
		$a->[2] -= $b;
		$a->[3] -= $b;
	}
	return $a;
};

sub multiply {
	my ( $a, $b ) = @_;
	return
	  $a->new( [ ref $b ? (
				$a->[0] * $b->[0],
				$a->[1] * $b->[1],
				$a->[2] * $b->[2],
				$a->[3] * $b->[3],
			  ) : (
				$a->[0] * $b,
				$a->[1] * $b,
				$a->[2] * $b,
				$a->[3] * $b,
			  ) ] );
}

use overload '*=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] *= $b->[0];
		$a->[1] *= $b->[1];
		$a->[2] *= $b->[2];
		$a->[3] *= $b->[3];
	} else {
		$a->[0] *= $b;
		$a->[1] *= $b;
		$a->[2] *= $b;
		$a->[3] *= $b;
	}
	return $a;
};

sub divide {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				$b->[0] / $a->[0],
				$b->[1] / $a->[1],
				$b->[2] / $a->[2],
				$b->[3] / $a->[3],
			  ) : (
				$a->[0] / $b->[0],
				$a->[1] / $b->[1],
				$a->[2] / $b->[2],
				$a->[3] / $b->[3],
			  ) ] )
	  : $a->new( [
			$a->[0] / $b,
			$a->[1] / $b,
			$a->[2] / $b,
			$a->[3] / $b,
	  ] );
}

use overload '/=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] /= $b->[0];
		$a->[1] /= $b->[1];
		$a->[2] /= $b->[2];
		$a->[3] /= $b->[3];
	} else {
		$a->[0] /= $b;
		$a->[1] /= $b;
		$a->[2] /= $b;
		$a->[3] /= $b;
	}
	return $a;
};

sub mod {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->new( [
			$r ? (
				X3DMath::fmod( $b->[0], $a->[0] ),
				X3DMath::fmod( $b->[1], $a->[1] ),
				X3DMath::fmod( $b->[2], $a->[2] ),
				X3DMath::fmod( $b->[3], $a->[3] ),
			  ) : (
				X3DMath::fmod( $a->[0], $b->[0] ),
				X3DMath::fmod( $a->[1], $b->[1] ),
				X3DMath::fmod( $a->[2], $b->[2] ),
				X3DMath::fmod( $a->[3], $b->[3] ),
			  ) ] )
	  : $a->new( [
			X3DMath::fmod( $a->[0], $b ),
			X3DMath::fmod( $a->[1], $b ),
			X3DMath::fmod( $a->[2], $b ),
			X3DMath::fmod( $a->[3], $b ),
	  ] );
}

use overload '%=' => sub {
	my ( $a, $b ) = @_;
	if ( ref $b ) {
		$a->[0] = X3DMath::fmod( $a->[0], $b->[0] );
		$a->[1] = X3DMath::fmod( $a->[1], $b->[1] );
		$a->[2] = X3DMath::fmod( $a->[2], $b->[2] );
		$a->[3] = X3DMath::fmod( $a->[3], $b->[3] );
	} else {
		$a->[0] = X3DMath::fmod( $a->[0], $b );
		$a->[1] = X3DMath::fmod( $a->[1], $b );
		$a->[2] = X3DMath::fmod( $a->[2], $b );
		$a->[3] = X3DMath::fmod( $a->[3], $b );
	}
	return $a;
};

sub pow {
	my ( $a, $b, $r ) = @_;
	return $a->new( [
			$r ? (
				$b**$a->[0],
				$b**$a->[1],
				$b**$a->[2],
				$b**$a->[3],
			  ) : (
				$a->[0]**$b,
				$a->[1]**$b,
				$a->[2]**$b,
				$a->[3]**$b,
			  )
	] );
}

use overload '**=' => sub {
	my ( $a, $b ) = @_;
	$a->[0]**= $b;
	$a->[1]**= $b;
	$a->[2]**= $b;
	$a->[3]**= $b;
	return $a;
};

sub dot {
	my ( $a, $b, $r ) = @_;
	return ref $b ?
	  $a->[0] * $b->[0] +
	  $a->[1] * $b->[1] +
	  $a->[2] * $b->[2] +
	  $a->[3] * $b->[3]
	  : ( $r ? $b . "$a" : "$a" . $b )
	  ;
}

sub cross {
	my ( $a, $b, $r ) = @_;
	( $a, $b ) = ( $b, $a ) if $r;

	my ( $a0, $a1, $a2, $a3 ) = @$a;
	my ( $b0, $b1, $b2, $b3 ) = @$b;

	return $a->new( [
			( $a0 * $b1 - $a1 * $b0 ) + ( $a0 * $b2 - $a2 * $b0 ) + ( $a1 * $b2 - $a2 * $b1 ),
			( $a2 * $b1 - $a1 * $b2 ) + ( $a1 * $b3 - $a3 * $b1 ) + ( $a2 * $b3 - $a3 * $b2 ),
			( $a0 * $b2 - $a2 * $b0 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a2 * $b3 - $a3 * $b2 ),
			( $a1 * $b0 - $a0 * $b1 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a3 * $b1 - $a1 * $b3 ),
	] );
}

use overload "x=" => sub {
	my ( $a, $b ) = @_;

	my ( $a0, $a1, $a2, $a3 ) = @$a;
	my ( $b0, $b1, $b2, $b3 ) = @$b;

	$a->[0] = ( $a0 * $b1 - $a1 * $b0 ) + ( $a0 * $b2 - $a2 * $b0 ) + ( $a1 * $b2 - $a2 * $b1 );
	$a->[1] = ( $a2 * $b1 - $a1 * $b2 ) + ( $a1 * $b3 - $a3 * $b1 ) + ( $a2 * $b3 - $a3 * $b2 );
	$a->[2] = ( $a0 * $b2 - $a2 * $b0 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a2 * $b3 - $a3 * $b2 );
	$a->[3] = ( $a1 * $b0 - $a0 * $b1 ) + ( $a3 * $b0 - $a0 * $b3 ) + ( $a3 * $b1 - $a1 * $b3 );

	return $a;
};

sub length {
	my ($a) = @_;
	return sqrt(
		$a->[0] * $a->[0] +
		  $a->[1] * $a->[1] +
		  $a->[2] * $a->[2] +
		  $a->[3] * $a->[3]
	);
}

use constant elementCount => 4;

1;
__END__
