\name{all.regs}
\alias{all.regs}
\title{
  Goodness of fit measures for a regression hierarchy
}
\description{
  Calculates goodness of fit measures for regressions of a single
  dependent variable to all combinations of N independent variables
}
\usage{
all.regs(y, xcan, family = "gaussian", gof = "RMSPE", print.vars = FALSE)
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
    'prediction' error,  "logLik", Log-Likelihood or "Rsqu", R-squared
    }

  \item{print.vars}{
    if FALSE, the function returns a vector of goodness-of-fit measures. If
    TRUE, a data frame is returned with first column listing variable
    combinations and the second column listing goodness-of-fit measures.
    }
  }

\details{
This function calculates goodness of fit measures for the entire
hierarchy of models using all combinations of N dependent variables, and
returns them as an ordered list ready for input into the function
\code{partition}. This function requires the gtools package in
the gregmisc bundle      
}

\value{
  \item{gfs}{
    If print.vars is FALSE, a vector of goodness of fit measures for all
    combinations of independent varaiables in the hierarchy or, if
    print.vars is TRUE, a data frame listing all combinations of
    independent variables in the first column in ascending order, and
    the corresponding goodness of fit measure for the model using those
    variables
  }
}
\author{
  Chris Walsh \email{Chris.Walsh@sci.monash.edu.au}.
}

\references{
  Hatt, B. E., Fletcher, T. D., Walsh, C. J. and Taylor, S. L. 2004 The
  influence of urban density and drainage infrastructure on the
  concentrations and loads of pollutants in small
  streams. \emph{Environmental Management} \bold{34}, 112--124.
  
  Walsh, C. J., Papas, P. J., Crowther, D., Sim, P. T., and Yoo, J. 2004
  Stormwater drainage pipes as a threat to a stream-dwelling amphipod of
  conservation significance, \emph{Austrogammarus australis}, in southeastern
  Australia. \emph{Biodiversity and Conservation} \bold{13}, 781--793.
 }

 \seealso{
  \code{\link{hier.part}}, \code{\link{partition}}, \code{\link{rand.hp}}
  }
 \examples{
           #linear regression of log(electrical conductivity) in streams
           #against seven independent variables describing catchment
           #characteristics (from Hatt et al. 2004)
           data(urbanwq)
           env <- urbanwq[,2:8]
           all.regs(urbanwq$lec, env, fam = "gaussian", gof = "Rsqu",
           print.vars = TRUE)

           #logistic regression of an amphipod species occurrence in
           #streams against four independent variables describing
           #catchment characteristics (from Walsh et al. 2004)
           data(amphipod)
           env1 <- amphipod[,2:5]
           all.regs(amphipod$australis, env1, fam = "binomial",
	   gof = "logLik", print.vars = TRUE)
}
\keyword{}

