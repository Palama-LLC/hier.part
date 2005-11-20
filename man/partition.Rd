\name{partition}
\alias{partition}
\title{
  Hierarchical partitioning from a list of goodness of fit measures 
}
\description{
  Partitions variance in a multivariate dataset from a list of goodness
  of fit measures
}
\usage{
partition(gfs, pcan, var.names = NULL)
}
\arguments{
  \item{gfs}{
    an array as outputted by the function \code{all.regs} or a vector of
    goodness of fit measures from a hierarchy of regressions based on pcan
    variables in ascending order (as produced by function \code{combos},
    but also including the null model as the first element)
  }
  
  \item{pcan}{
    the number of variables from which the hierarchy was constructed
    (maximum = 12)
  }
  
  \item{var.names}{
    an array of pcan variable names, if required
  }
  }

\details{
This function applies the hierarchical partitioning algorithm of Chevan
and Sutherland (1991) to return a simple table listing of each variable,
its independent contribution (I) and its conjoint contribution with all
other variables (J).  The output is identical to the function
\code{hier.part}, which takes the dependent and independent variable
data as its input.

Note earlier versions of partition (hier.part<1.0) produced a matrix and
barplot of percentage distribution of effects as a percentage of the sum
of all Is and Js, as portrayed in Hatt et al. (2004) and Walsh et al.
(2004). This version plots the percentage distribution of independent
effects only. The sum of Is equals the goodness of fit measure of the
full model minus the goodness of fit measure of the null model.

The distribution of joint effects shows the relative contribution of
each variable to shared variability in the full model. Negative joint
effects are possible for variables that act as suppressors of other
variables (Chevan and Sutherland 1991).

At this stage, the partition routine will not run for more than 12
independent variables. This function requires the gtools package in the
gregmisc bundle
}

\value{
  a list containing
  \item{gfs}{
    a data frame listing all combinations of independent
    variables in the first column in ascending order, and the
    corresponding goodness of fit measure for the model using those
    variables
  }

  \item{IJ}{
    a data frame of I, the independent and J the joint
    contribution for each independent variable
  }

  \item{I.perc}{
    a data frame of I as a percentage of total explained variance
  }
  
  \item{J.perc}{
    a data frame of J as a percentage of sum of all Js
  }
}
\author{
  Chris Walsh \email{Chris.Walsh@sci.monash.edu.au} using c and fortran
  code written by Ralph Mac Nally \email{Ralph.MacNally@sci.monash.edu.au}.
}
\references{
  Chevan, A. and Sutherland, M. 1991 Hierarchical Partitioning. \emph{The
  American Statistician} \bold{45}, 90--96.

  Hatt, B. E., Fletcher, T. D., Walsh, C. J. and Taylor, S. L. 2004 The
  influence of urban density and drainage infrastructure on the
  concentrations and loads of pollutants in small
  streams. \emph{Environmental Management} \bold{34}, 112--124.
}
\note{
  The function produces a minor rounding error for hierarchies
  constructed from more than 9 variables. To check if this error affects
  the inference from an analysis, run the analysis several times with
  the variables entered in a different order.  There are no known
  problems for hierarchies with 9 or fewer variables.
  }
\seealso{
  \code{\link{all.regs}}, \code{\link{partition}}, \code{\link{rand.hp}}
  }
 \examples{
           #linear regression of log(electrical conductivity) in streams
           #against seven independent variables describing catchment
           #characteristics (from Hatt et al. 2004)
           data(urbanwq)
           env <- urbanwq[,2:8]
           gofs <- all.regs(urbanwq$lec, env, fam = "gaussian",
           gof = "Rsqu", print.vars = TRUE)
           partition(gofs, pcan = 7, var.names = names(urbanwq[,2,8]))

           #hierarchical partitioning of logistic and linear regression
           #goodness of fit measures from Chevan and Sutherland (1991) 
           data(chevan)
           partition(chevan$chisq, pcan = 4)
           partition(chevan$rsqu, pcan = 4)
}
\keyword{}

