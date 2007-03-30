#ifndef bool
#include <iostream.h>
#endif
extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
}
#ifdef bool
#undef bool
#include <iostream.h>
#endif


class SFTime {
	private:
		double value;

	public:
		SFTime (const double v=0) { setValue(v); }

		inline const SFTime* copy () { return new SFTime(value); }

		inline void setValue (const double v) { value = v; }
		inline const double getValue () { return value; }
};


MODULE = SFTime     	PACKAGE = main::SFTime

PROTOTYPES: DISABLE

SFTime *
SFTime::new(...)
    PREINIT:
	double	v;
    CODE:
switch(items-1) {
case 1:
	v = (double)SvNV(ST(1));
	RETVAL = new SFTime(v);
	break; /* case 1 */
default:
	RETVAL = new SFTime();
} /* switch(items) */ 
    OUTPUT:
RETVAL

SFTime *
SFTime::copy()
    CODE:
	RETVAL = const_cast<SFTime *>(THIS->copy());
    OUTPUT:
RETVAL

void
SFTime::setValue(v)
	double	v
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->setValue(v);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

double
SFTime::getValue()
    CODE:
	RETVAL = THIS->getValue();
    OUTPUT:
RETVAL

void
SFTime::DESTROY()

MODULE = SFTime     	PACKAGE = main	

PROTOTYPES: DISABLE
