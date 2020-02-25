#include <R.h>
#include <Rinternals.h>
#include "hierpart.h"

/* === === === === === === === === === === === === === === === === ===
	Factorial(): Calculate N!
=== === === === === === === === === === === === === === === === === */

double
Factorial(int N)

{
	int	i, tally;

	if ((N == 0) || (N == 1))
	    return(1.0);

	for (i = 1, tally = 1; i <= N; i++)
	    tally *= i;

	return((double)tally);

} /* Factorial() */

/* === === === === === === === === === === === === === === === === ===
	Combos(): Calculate NCR
=== === === === === === === === === === === === === === === === === */

int
Combos(int N, int n)

{
	long	total, j, cur;

	if (n > N)
	    return (-99);
	if (n == 0 || N == 0)
	    return (-99);
	total = 1;
	cur = N;
	for (j = 1; j <= n; j++)
	    total *= cur--;

	for (j = 1, cur = 1; j <= n; j++)
	    total /= cur++;

	return((int)total);


} /* Combos */

/* === === === === === === === === === === === === === === === === ===
	Acquire(): Read input goodnesses-of-fit
=== === === === === === === === === === === === === === === === === */

BOOLEAN
Acquire(int N, double *fin)

{

	int	i, j, goodreads, allcombs;


	d = (DARRAY *) malloc ((N + 1) * sizeof(DARRAY));
	if (d == (DARRAY *) NULL)
	    return(FALSE);

	goodreads = 0;
	allcombs = 0;
	for (i = 1; i <= N; i++)
	{
	    allcombs += (d[i].size = Combos(N, i));
	    d[i].m = (ENTRY *) malloc ((d[i].size + 1) * sizeof(ENTRY));
	    if (d[i].m == (ENTRY *) NULL)
		return(FALSE);
	    for (j = 1; j <= d[i].size; j++)
	      {
            d[i].m[j].X = *fin++;
	    /*    Rprintf("i = %d, j = %d, entry = %lf\n", i, j, d[i].m[j].X);*/
	      }
	}
	return(TRUE);

} /* Acquire() */


/* === === === === === === === === === === === === === === === === === ===

	Partition(): the engine room where it all happens - have
		data and index combinations all loaded in `d'.

=== === === === === === === === === === === === === === === === === === */

void
/* Partition(int N, double Rtheta, double IJ[N*2]) */
Partition(int N, double Rtheta, double IJ[])
{
	int	level, var;
	/*	double	I[STRLEN], J[STRLEN], factor, sum;*/
        double	factor, sum;

	for (var = 1; var <= N; var++)
	{
	    sum = 0.0;

	    /* first term in hierarchy, occurs (N-1)! times */
	    level = 1;
	    sum += (Factorial(N - 1) * (d[level].m[var].X - Rtheta));
	    /* last term in hierarchy, also occurs (N-1)! times */
	    level = N;
	    sum += (Factorial(N - 1) * ReturnDiff(level, var));

	    for (level = 2; level < N; level++)
    {
		/* each difference occurs (j - 1)!(N - j)! times */
		factor = 1.0 * Factorial(level - 1) * Factorial(N - level);
		sum += factor * ReturnDiff(level, var);

	    } /* for level ...

	    IJ[0][var-1] = I[var] = sum / Factorial(N);
	    IJ[2][var-1] = J[var] = (d[1].m[var].X - Rtheta - I[var]);
	      */
	    IJ[var - 1] = sum / Factorial(N);
	    IJ[N + var - 1] = (d[1].m[var].X - Rtheta - IJ[var - 1]);
	} /* for var ... */
	/*     Rprintf("\nvar\tI\tJ\tTot\n");
	    	for (var = 1; var <= N; var++)
	  {
	    Rprintf("Var%d \t%4.3lf\t%4.3lf\t%4.3lf\n",
	    var, I[var], J[var], I[var] + J[var]);
	    }*/

} /* Partition() */


double
ReturnDiff(int level, int var)

{
	int	entry, i, j;
	char	vessel[STRLEN];
	double	val = 0.0;

	for (entry = 1; entry <= d[level].size; entry++)
	{
	    /* initialize vessel */
	    for (i = 0; i < STRLEN; i++)
		vessel[i] = '\0';

	    for (i = 0, j = 0; i < level; i++)
		if (var != d[level].m[entry].pt[i + 1])
		    vessel[j++] = d[level].m[entry].idx[i];

	    for (i = 1; i <= d[level - 1].size; i++)
	    {
		if (! strcmp(vessel, d[level - 1].m[i].idx))
		    val += d[level].m[entry].X - d[level - 1].m[i].X;
	    }
	}

	return (val);


} /* ReturnDiff() */






