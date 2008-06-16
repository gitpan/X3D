package X3D::Values::Int32;
use X3D::Perl;

our $VERSION = '0.001';

use Package::Alias X3DInt32 => __PACKAGE__;

use overload

  #  '+=' => 'badd',

  '""' => 'toString',
  ;

sub value {
}

sub getClone {
   my $class = ref( $_[0] ) || $_[0];
   return $class->new( $_[0]->getValue );
}

sub toString {
   return sprintf "%d", $_[0]->getValue;
}

__END__
use constant INLINE_DIRECTORY => "/tmp/_Inline";
system sprintf "mkdir -p '%s'", INLINE_DIRECTORY;

use Inline Config => (
   DIRECTORY => INLINE_DIRECTORY,

   ENABLE  => "FORCE_BUILD",
   DISABLE => "CLEAN_AFTER_BUILD",
);

use Inline (
   C    => "DATA",
   NAME => "X3D::Values::Int32",
);

#END { system sprintf "rm -r '%s'", INLINE_DIRECTORY; }

1;
__DATA__
__C__

typedef struct {
	long  value;
} Int32;

Int32* SvInt32(SV* obj) {
	return (Int32*)SvIV(SvRV(obj));
}

SV* new(char* class, ...) {
	Int32* this = malloc(sizeof(Int32));
	SV*  	 obj_ref = newSViv(0);
	SV*  	 obj = newSVrv(obj_ref, class);

	Inline_Stack_Vars;

	if (items > 1) {
		this->value = (long)SvIV(ST(1));
	} else {
		this->value = 0;
	}
	
	sv_setiv(obj, (IV)this);
	SvREADONLY_on(obj);
	return obj_ref;
}

long getValue(SV* obj) {
	return SvInt32(obj)->value;
}

void setValue(SV* obj, long value) {
	SvInt32(obj)->value = value;
}

void DESTROY(SV* obj) {
	Int32* this = SvInt32(obj);
	free(this);
}
