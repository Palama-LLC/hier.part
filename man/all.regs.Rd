\name{all.regs}
\alias{all.regs}
\title{
  Goodness of Fit Measures for a Regression Hierarchy
}
\description{
  Calculates goodness of fit measures for regressions of a single
  response variable to all combinations of N predictor variables
}
\usage{
all.regs(y, xcan,
         family = c("gaussian", "binomial", "Gamma", "inverse.gaussian",
                    "poisson","quasi", "quasibinomial","quasipoisson",
                    "beta","ordinal"),
         link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
         gof = c("Rsqu", "RMSPE", "logLik"),
         print.vars = FALSE, ...)
}
\arguments{
  \item{y}{
    a vector containing the response variable
  }

  \item{xcan}{
    a data.frame containing the n predictors
  }

  \item{family}{
    a character string naming a family function used by \code{stats::glm}
    (See \code{stats::family} for details of family functions). Valid values
    are "gaussian", "binomial", "Gamma", "inverse.gaussian", "poisson",
    "quasi", "quasibinomial","quasipoisson". Alternatively a value of "beta"
    will use the \code{betareg::betareg} beta regression model, or "ordinal"
    will use the \code{MASS::polr} ordered logistic or probit regression.
    For these last two options, a value for the link argument is required.
  }

  \item{link}{
    character specification of the link function, only used if family =
    "beta" or "ordinal".  For "beta", this argument equals the "link" argument
    in \code{betareg::betareg}. For "ordinal", it equals the "method"
    argument in \code{MASS::polr}, where "logit" = "logistic".
  }

  \item{gof}{
    Goodness-of-fit measure.  Currently "RMSPE", Root-mean-square
    'prediction' error,  "logLik", Log-Likelihood or "Rsqu", R-squared.
    R-squared is only applicable if family = "Gaussian".
    }

  \item{print.vars}{
    if FALSE, the function returns a vector of goodness-of-fit measures. If
    TRUE, a data frame is returned with first column listing predictor variable
    combinations and the second column listing goodness-of-fit measures.
    }

  \item{...}{
  additional arguments to passed to \code{glm}, \code{betareg::betareg}, or \code{MASS::polr}
  }
}

\details{
This function calculates goodness of fit measures for the entire
hierarchy of models using all combinations of N predictors, and
returns them as an ordered list ready for input into the function
\code{partition}.
}

\value{
  \item{gfs}{
    If print.vars is FALSE, a vector of goodness of fit measures for all
    combinations of predictors in the hierarchy or, if
    print.vars is TRUE, a data frame listing all combinations of
    predictor variables in the first column in ascending order, and
    the corresponding goodness of fit measure for the model using those
    variables
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
    #characteristics (from Hatt et al. 2004).

    data(urbanwq)
    env <- urbanwq[,2:8]
    all.regs(urbanwq$lec, env, fam = "gaussian", gof = "Rsqu",
             print.vars = TRUE)

    #logistic regression of an amphipod species occurrence in
    #streams against four independent variables describing
    #catchment characteristics (from Walsh et al. 2004).

    data(amphipod)
    env1 <- amphipod[,2:5]
    all.regs(amphipod$australis, env1, fam = "binomial",
             gof = "logLik", print.vars = TRUE)
}
\keyword{regression}
