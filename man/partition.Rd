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
data as its input

At this stage, the partition routine will not run for more than 12
independent variables.
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
  Chevan, and Sutherland (1991) The American Statistician 45: 90
}
\see also{
  \code{all.regs}, \code{partition}, \code{glm}, \code{rand.hp}
  }
 \examples{
           #linear regression with four independent variables
           data(urban)
           env <- urban[,3:6]
           gofs <- all.regs(urban$chl, env,
                            fam = "gaussian", gof = "Rsqu")
           partition(gofs, pcan = 4, var.names = names(urban[,3:6]))

           #hierarchical partitioning of logistic and linear regression
           #goodness of fit measures from Chevan and Sutherland (1991) 
           data(chevan)
           partition(chevan$chisq, pcan = 4)
           partition(chevan$rsqu, pcan = 4)
}
\keyword{}

