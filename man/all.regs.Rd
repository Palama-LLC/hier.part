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
\code{partition}.      
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

\see also{
  \code{hier.part}, \code{partition}, \code{glm}, \code{rand.hp}
  }
 \examples{
           #linear regression with four independent variables
           data(urban)
           env <- urban[,3:6]
           all.regs(urban$chl, env, fam = "gaussian", gof = "Rsqu",
                    print.vars = TRUE)

           #logistic regression with four independent variables
           data(urban1)
           env1 <- urban1[,2:5]
           all.regs(urban1$pa, env1, fam = "binomial", gof = "logLik")
}
\keyword{}

