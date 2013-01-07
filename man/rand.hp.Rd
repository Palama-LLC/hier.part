\name{rand.hp}
\alias{rand.hp}
\title{
  Randomization Test for Hierarchical Partitioning
}
\description{
  Randomizes elements in each column in xcan and recalculates
  \code{hier.part} num.reps times
}
\usage{
 rand.hp(y, xcan, family = "gaussian", gof = "RMSPE",
                    num.reps = 100)
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
    'Prediction' error, "NLL", Negative log Likelihood or "Rsqu",
    R-squared
  }

  \item{num.reps}{
    Number of repeated randomizations
    }
  }

\details{
This function is a randomization routine for the \code{hier.part}
function which returns a matrix of I values (the independent
contribution towards explained variance in a multivariate dataset) for
all values from num.reps randomizations. For each randomization, the
values in each variable (i.e each column of xcan) are randomized
independently, and hier.part is run on the randomized xcan.  As well as
the randomized I matrix, the function returns a summary table listing
the observed I values, the 95th and 99th percentile values of I for
the randomized dataset.   
}

\value{
  a list containing
  \item{Irands}{
    matrix of num.reps + 1  rows of I values for each dependent
    variable.  The first row contains the observed I values and the
    remaining num.reps rows contains the I values returned for each
    randomization.  
  }
  \item{Iprobs}{
    data.frame of observed I values for each variable, Z-scores for the
    generated distribution of randomized Is and an indication of
    statistical significance.  Z-scores are cacluated as
    (observed - mean(randomizations))/sd(randomizations),
    and statistical significance (*) is based on upper 0.95 confidence
    limit (\eqn{Z >= 1.65}).
    }
}
\author{
  Chris Walsh \email{cwalsh@unimelb.edu.au}.
}
\references{
  Hatt, B. E., Fletcher, T. D., Walsh, C. J. and Taylor, S. L. 2004 The
  influence of urban density and drainage infrastructure on the
  concentrations and loads of pollutants in small
  streams. \emph{Environmental Management} \bold{34}, 112--124.
  
  Mac Nally, R. 2000 Regression and model building in conservation
  biology, biogeography and ecology: the distinction between and
  reconciliation of 'predictive' and 'explanatory' models. \emph{Biodiversity
  and Conservation} \bold{9}, 655--671.

  Mac Nally, R. 2002 Multiple regression and inference in conservation
  biology and ecology: further comments on identifying important
  predictor variables. \emph{Biodiversity and Conservation} \bold{11},
  1397--1401.

  Walsh, C. J., Papas, P. J., Crowther, D., Sim, P. T., and Yoo, J. 2004
  Stormwater drainage pipes as a threat to a stream-dwelling amphipod of
  conservation significance, \emph{Austrogammarus australis}, in southeastern
  Australia. \emph{Biodiversity and Conservation} \bold{13}, 781--793.
}

\seealso{
  \code{\link{hier.part}}, \code{\link{partition}}
  }

\examples{
    #linear regression of log(electrical conductivity) in streams
    #against four independent variables describing catchment
    #characteristics (from Hatt et al. 2004).

    data(urbanwq)
    env <- urbanwq[,2:5]
    rand.hp(urbanwq$lec, env, fam = "gaussian", gof = "Rsqu")$Iprobs

    #logistic regression of an amphipod species occurrence in
    #streams against four independent variables describing
    #catchment characteristics (from Walsh et al. 2004).

    data(amphipod)
    env1 <- amphipod[,2:5]
    rand.hp(amphipod$australis, env1, fam = "binomial",
    gof = "logLik")$Iprobs
}

