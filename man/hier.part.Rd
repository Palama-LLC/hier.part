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
to return a simple table listing of each variable, its independent
contribution (I) and its conjoint contribution with all other variables
(J).

At this stage, the partition routine will not run for more than 12
independent variables.  
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

  \item{IJ.perc}{
    a data frame of I and J expressed as percentage of
    total explained variance
  }
}
\author{
  Chris Walsh \email{Chris.Walsh@sci.monash.edu.au} using c and fortran
  code written by Ralph MacNally \email{Ralph.MacNally@sci.monash.edu.au}.
}
\references{
  Chevan, A. and Sutherland, M. (1991) Hierarchical Partitioning. The
  American Statistician 45: 90-96.
  Mac Nally, R. (2000) Regression and model building in conservation
  biology, biogeography and ecology: the distinction between and
  reconciliation of 'predictive' and 'explanatory' models. Biodiversity
  and Conservation 9: 655-671.
}
\see also{
  \code{all.regs}, \code{partition}, \code{glm}, \code{rand.hp}
  }
 \examples{
           #linear regression with four independent variables
           data(urban)
           env <- urban[,3:6]
           hier.part(urban$chl, env, fam = "gaussian", gof = "Rsqu")

           #logistic regression with four independent variables
           data(urban1)
           env1 <- urban1[,2:5]
           hier.part(urban1$pa, env1, fam = "binomial", gof = "logLik")
}
\keyword{}

