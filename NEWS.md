# hier.part Version 1.0-5

This version:  

- corrects a number of minor coding irregularities as required by CRAN.  

- expands the model families that can be used for hierarchical partitioning. All families accepted by glm are now valid, as well as "beta" (beta regression using betareg from the betareg package) and "ordinal".  This last option is not strictly a family, but is a flag to use polr (from the MASS package) for ordered logistic or probit regression.  

- the hier.part(), all.regs() and rand.hp() functions now accept additional arguments that can be passed to glm(), betareg() or polr().  The link argument can be used to specify the desired link for betareg() and polr().