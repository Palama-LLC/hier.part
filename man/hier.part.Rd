\name{hier.part}
\alias{hier.part}
\title{
  Goodness of Fit Calculation and Hierarchical Partitioning
}
\description{
  Partitions variance in a multivariate dataset
}
\usage{
hier.part(y, xcan,
          family = c("gaussian", "binomial", "Gamma", "inverse.gaussian",
                    "poisson", "quasi", "quasibinomial", "quasipoisson",
                    "beta", "ordinal"),
          link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
          gof = c("Rsqu", "RMSPE", "logLik"),
          barplot = TRUE, ...)
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

    \item{barplot}{
    If TRUE, a barplot of I and J for each variable is plotted expressed
    as percentage of total explained variance.
    }

    \item{...}{
    additional arguments to passed to \code{glm}, \code{betareg::betareg},
    or \code{MASS::polr}
     }
  }

\details{
    This function calculates goodness-of-fit measures for the full
    hierarchy of models using all combinations of N predictor variables
    using the function \code{all.regs}.  The function takes the list of
    goodness-of-fit measures and, using the \code{partition} function, applies
    the hierarchical partitioning algorithm of Chevan and Sutherland (1991)
    to return a table listing each predictor, its independent
    contribution (I) and its conjoint contribution with all other variables
    (J), which cannot be ascribed separately to any one predictor.

    Earlier versions of the hier.part package (<1.0) produced a matrix and
    barplot of percentage distribution of effects as a percentage of the sum of
    all Is and Js, as shown in Hatt et al. (2004) and Walsh et al. (2004). The
    current version plots the percentage distribution of independent effects
    only. The sum of Is equals the goodness-of-fit measure for the full model
    less the goodness-of-fit value of the null model.

    The distribution of joint effects shows the relative contribution of
    each variable to shared variability in the full model. Negative joint
    effects are possible for variables that act as 'suppressors' of other
    variables (Chevan and Sutherland 1991).

    The partition routine will not run for more than 12 predictors, but data
    sets with more than this number of predictors are unlikely to identify
    'important' predictors.
}

\value{
  a list containing
  \item{gfs}{
    a data frame or vector listing all combinations of predictors in the first
    column in ascending order, and the corresponding goodness of fit measure
    for the model using those predictors.
  }

  \item{IJ}{
    a data frame of I, the independent and J the joint
    contribution for each predictor.
  }

  \item{I.perc}{
    a data frame of I as a percentage of total explained variance
  }
}
\note{
  The function produces a minor rounding error for analyses with more
  than than 9 predictors. To check if this error affects the
  inference from an analysis, run the analysis several times with the
  predictors entered in a different order.  There are no known problems
  for analyses with 9 or fewer predictors.
  }
\author{
  Chris Walsh \email{cwalsh@unimelb.edu.au} using c and fortran
  code written by Ralph Mac Nally \email{Ralph.MacNally@gmail.com}.
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
    #linear regression of log(electrical conductivity) in
    #streams against seven predictor variables
    #describing catchment characteristics (from
    #Hatt et al. 2004)

    data(urbanwq)
    env <- urbanwq[,2:8]
    hier.part(urbanwq$lec, env, fam = "gaussian", gof = "Rsqu")

    #logistic regression of an amphipod species occurrence in
    #streams against four independent variables describing
    #catchment characteristics (from Walsh et al. 2004).

    data(amphipod)
    env1 <- amphipod[,2:5]
    hier.part(amphipod$australis, env1, fam = "binomial",
              gof = "logLik")
}
 \keyword{regression}