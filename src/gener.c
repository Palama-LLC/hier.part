#include "hierpart.h"

static int	combos;


/* === === === === === === === === === === === === === === === === === 
	Distributor - need to produce all > 1 combinations
=== === === === === === === === === === === === === === === === === */

void
Distributor(int N)

{
	int	i, j, bead, allset, subset, *locstore, err;
	char	phrase[STRLEN];

	allset = N;

	/* some work space for allnr_ to use */
	if ((locstore = (int *) malloc (N * sizeof(int)))
	    == (int *) NULL)
	{
	    fprintf(stderr, "bestreg:Distributor: allocation failed (%d)\n", N);
	    exit(1);
	}

	for (subset = 1; subset <= N; subset++)
	{
	    F77_CALL(allnr)(&allset, &subset, locstore, &err);
	    for (i = 0; i < combos; i++)
	    {
		/* clear string index */
		for (bead = 0; bead < STRLEN; bead++)
		    phrase[bead] = '\0';

		for (j = 1; j <= subset; j++)
		{
		    d[subset].m[i + 1].pt[j] = Iarray[i][j];
		  sprintf(phrase, "%s%d", phrase, Iarray[i][j]);
		}
	      sprintf(d[subset].m[i + 1].idx, "%s", phrase);
	    }
	    delete_list_array(&allset, &subset);
	}


	/* deallocate regression storage */

	free(locstore);

} /* Distributor() */

void
F77_SUB(mla)(int *n, int *r)

{
	int	count;


	combos = N_C_R( *n, *r);

	if ((Iarray = (int **) malloc (combos * sizeof(int *)))
		== (int **) NULL)
	{
	    fprintf(stderr, "hierpart:make_array_list: allocation failed\n");
	    exit(1);
	}
	for (count = 0; count < combos; count++)
	    if ((Iarray[count] = (int *) malloc ((*r + 1) * sizeof(int)))
		    == (int *) NULL)
	    {
		fprintf(stderr, "bestreg:make_array_list: allocation failed\n");
		exit(1);
	    }
	
} 


void
F77_SUB(llist)(int *n, int *r, int *j, int *kount)

{
	int	count;

	for (count = 1; count <= *r; count++)
	    Iarray[*kount - 1][count] = j[count - 1];

} 



void
delete_list_array(int *n, int *r)

{
	int	count;


	combos = N_C_R( *n, *r);

	for (count = 0; count < combos; count++)
	    free(Iarray[count]);

	free(Iarray);
	
} /* delete_list_array() */

int
N_C_R(int allset, int sample)

{
	int	j, k;
	double	sum, denom, num;

	num = 1.0;
	denom = 1.0;

	for (j = allset - sample + 1; j <= allset; j++)
	    num *= (double)j;
	for (k = 1; k <= sample; k++)
	    denom *= (double)k;
	sum = num / denom;

	return ((int)sum);

} 














