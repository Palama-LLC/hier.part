#include <Rmath.h>
#include <ctype.h>
#include <string.h>
#include "R.h"

#define Square(x)       ((x) * (x))

/* general constants, etc. */

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#ifndef RAND_MAX
#define RAND_MAX   32767
#endif

#ifndef M_PI
#define M_PI             3.14159265358979323846
#endif

#ifdef _MAC_
#include <float.h>
#define HUGE DBL_MAX
#endif

#ifndef BOOLEAN
#define BOOLEAN int
#endif

#ifndef STRLEN
#define STRLEN 64
#endif


/* structures */

typedef struct
{
	double	X;
	char	idx[STRLEN];
	int	pt[STRLEN];

} ENTRY;

typedef struct
{
	int	size;
	ENTRY	*m;

} DARRAY;

/* global variables */

#ifdef GLOBAL
DARRAY	*d;
int	**Iarray;
double	Rtheta;
#endif

#ifndef GLOBAL
extern	DARRAY	*d;
extern	int	**Iarray;
extern	double	Rtheta;
#endif



#include "funchierpart.h"

