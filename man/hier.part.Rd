\name{hier.part}
\alias{hier.part}
\title{
  Goodness of fit calculation and hierarchical partitioning
}
\description{
  Partitions variance in a multivariate dataset
}
\usage{
hier.part(y, xcan, family = "gaussian", gof = "RMSPE", barplot = TRUE)
}
\arguments{
  \item{y}{
    a vector containing the dependent variables
  }
  
  \item{xcan}{
    a dataframe containing the n independent variables
  }
  
  \item{family}{
    family argument of \code{glm}
  }

  \item{gof}{
    Goodness-of-fit measure.  Currently "RMSPE", Root-mean-square
    'prediction' error, "logLik", Log-Likelihood or "Rsqu", R-squared
    }

    \item{barplot}{
    If TRUE, a barplot of I and J for each variable is plotted expressed
    as percentage of total explained variance.
    }
  }

\details{
This function calculates goodness of fit measures for the entire
hierarchy of models using all combinations of N independent variables
using the function \code{all.regs}.  It takes the list of goodness
of fit measures and, using the \code{partition} function, applies the
hierarchical partitioning algorithm of Chevan and Sutherland (1991)
to return a simple table listing each variable, its independent
contribution (I) and its conjoint contribution with all other variables
(J).

Note earlier versions of hier.part (<1.0) produced a matrix and barplot
of percentage distribution of effects as a percentage of the sum of all
Is and Js, as portrayed in Hatt et al. (2004) and Walsh et al. (2004).
This version plots the percentage distribution of independent effects
only. The sum of Is equals the goodness of fit measure of the full model
minus the goodness of fit measure of the null model.

The distribution of joint effects shows the relative contribution of
each variable to shared variability in the full model. Negative joint
effects are possible for variables that act as suppressors of other
variables (Chevan and Sutherland 1991).

At this stage, the partition routine will not run for more than 12
independent variables. This function requires the gtools package in
the gregmisc bundle 
}

\value{
  a list containing
  \item{gfs}{
    a data frame or vector listing all combinations of independent
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
}
\author{
  Chris Walsh \email{Chris.Walsh@sci.monash.edu.au} using c and fortran
  code written by Ralph MacNally \email{Ralph.MacNally@sci.monash.edu.au}.
}
\references{
  Chevan, A. and Sutherland, M. 1991 Hierarchical Partitioning. \emph{The
  American Statistician} \bold{45}, 90--96.

  Hatt, B. E., Fletcher, T. D., Walsh, C. J. and Taylor, S. L. 2004 The
  influence of urban density and drainage infrastructure on the
  concentrations and loads of pollutants in small
  streams. \emph{Environmental Management} \bold{34}, 112--124.
  
  Mac Nally, R. 2000 Regression and model building in conservation
  biology, biogeography and ecology: the distinction between and
  reconciliation of 'predictive' and 'explanatory' models. \emph{Biodiversity
  and Conservation} \bold{9}, 655--671.

  Walsh, C. J., Papas, P. J., Crowther, D., Sim, P. T., and Yoo, J. 2004
  Stormwater drainage pipes as a threat to a stream-dwelling amphipod of
  conservation significance, \emph{Austrogammarus australis}, in south-eastern
  Australia. \emph{Biodiversity and Conservation} \bold{13}, 781--793.
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
           hier.part(urbanwq$lec, env, fam = "gaussian", gof = "Rsqu")

           #logistic regression of an amphipod species occurrence in
           #streams against four independent variables describing
           #catchment characteristics (from Walsh et al. 2004)
           data(amphipod)
           env1 <- amphipod[,2:5]
           hier.part(amphipod$australis, env1, fam = "binomial", gof = "logLik")
}
\keyword{}

