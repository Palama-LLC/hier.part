/* === === === === === === === === === === === === === === === === === === === 


STARTDOC
SECTION		1I
NAME		hierpart - variance partition of multivariate data set
SYNOPSIS	
DESCRIPTION	`Hierpart' is an implementation of the hierarchical
		partitioning algorithm published by Chevan and
		Sutherland (1991: The American Statistician 45: 90).
		The approach uses the entire hierarchy of models based
		on N variables to apportion amounts of individual
		and joint explanation between the variables. Input
		data are the measures of goodness of fit for models
		in ascending order (i.e., model (1), (2), ..., (N),
		(1,2), ..., (1,N), ..., (1,2,3,...,N)). In general
		linear modelling (especially regression), the 0-order
		model is associated with 0.0 (i.e., no correlation
		or explained sums of squares). However, in log-linear
		modelling, the chi-square statistic is the appropriate
		measure, and it is the largest of all model goodness
		of fit values. Thus, `hierpart' allows command line
		input to specify the 0-order value if necessary
		(otherwise 0).~
		~
		The output is a simple table consisting of the variable
		number, its independent contribution (I) and its
		conjoint contribution with all other variables (J).
OPTIONS		
ARGUMENTS_	
COMMANDS_
FILES_
EXAMPLES_
DIAGNOSTICS
SEE_ALSO_
F77_SYNOPSIS
PARAMETERS
NOTES		This implementation of hierpart has been re-written 
                by Chris Walsh, August 2002 to permit use by the program
                R, in the package hier.part
FEATURES
WARNINGS
TABLES_
VERSION_
CAVEATS
BUGS
IDENTIFICATION	Ralph C. Mac Nally, January 1994
ORIGIN		School of Biological Sciences
		Monash University 3800,
	        Australia.

		\\(co Monash University
ENDDOC

=== === === === === === === === === === === === === === === === === === === */
#define GLOBAL
#include "hierpart.h"
#undef GLOBAL

char	*errmsg4 = "hierpart: cannot 'malloc' enough space";

void
hierpart(int *x, int *len, double *theta, double *fin, void *IJ)
{
  int X, max;
  double Rtheta;
  X = *x;
  Rtheta = *theta;
  max = *len;
  Acquire(X, fin);	   
  Distributor(X);
  Partition(X, Rtheta, IJ);

} /* main() */






