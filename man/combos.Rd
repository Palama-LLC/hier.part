\name{combos}
\alias{combos}
\title{
  All combinations of a hierarchy of models of n variables
}
\description{
  Lists a matrix of combinations of 1 to n variables in ascending order
}
\usage{
  combos(n)
}
\arguments{
  \item{n}{
    an integer: the number of variables
  }
  }

\details{
Lists hierarchy of all possible combinations of n variables in ascending
order, starting with 1 variable, then all combinations of 2 variables,
and so on until the one combination with all n variables.  This function
is used by \code{all.regs} to structure the models required for
hierarchical partioning
}

\value{
  a list containing
  \item{ragged}{
    a matrix with zeroes in empty elements and 1 in column 1, 2 in
    column 2 ... n in column n for full elements
  }

  \item{binary}{
    a matrix as for ragged, but with 1 in all full elements
    }
}
\author{
  Chris Walsh \email{Chris.Walsh@sci.monash.edu.au} 
}

\see also{
  \code{all.regs}
  }

\keyword{}

