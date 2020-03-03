
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hier.part

The hier.part package for R is an implementation of the hierarchical
partitioning algorithm published by Chevan and Sutherland (1991: The
American Statistician 45: 90). The function hier.part() partitions the
independent and joint contributions of each predictor in a multivariate
data set to a linear model by hierarchical decomposition of
goodness-of-fit measures of regressions. It uses goodness-of-fit
measures for the full hierarchy of models based on N predictors (i.e.,
model (1), (2), …, (N), (1,2), …, (1,N), …, (1,2,3,…,N)). The function
rand.hp() performs a randomization test that allows an Z-score
assessment of the ‘importance’ of each predictor in explaining variation
in the response variable.

The current version on CRAN is 1.0-5 (commit 8f8865da6a).
A beta version of 1.0-6 (minor corrections) on github

## Installation

Through [CRAN](https://cran.r-project.org/package=hier.part)
or:

``` r
devtools::install_github("cjbwalsh/hier.part")
```

## Usage

``` r
    #logistic regression of an amphipod species occurrence in streams against
    #four independent variables describing catchment characteristics
    #(from Walsh et al (2004) Biodiversity and Conservation 13:781)

    data(amphipod)
    env <- amphipod[,2:5]
    hier.part(amphipod$australis, env, fam = "binomial", gof = "logLik")
    
    # shows that fconn (drainage connection) is the strongest independent 
    # predictor explaining amphipod occurrence (having elsewhere tested 
    # that the model predicts occurrence well).
    
    rand.hp(amphipod$australis, env, fam = "binomial", 
            gof = "logLik", num.reps = 999)$Iprobs

    #Z-scores suggest that fconn and fimp (imperviousness) are both
    #important' independent predictors of amphipod abundance. 
    #(999 randomizations takes a few minutes).  
```
