combos <- function(n) {
    if (n < 2) {
        cat("\nn must be greater than 1.\n\n")
    } else if (n > 11) {
        cat("\n CAUTION! Output size increases exponentially with n. \n")
        cat(" Result for n = ", n, "will be a ", 2^n - 1, "*", n, " matrix.\n")
        cat(" Do you really want to proceed?\n")
        choice <- utils::menu(c("Proceed", "Quit"))
        if (choice == 1)
            combos1(n) else {
        }
    } else combos1(n)
}

combos1 <- function(n) {
    x <- cbind(gtools::combinations(n, 1, 1:n), array(0, dim = c(n, n - 1)))
    for (i in 2:n) {
        nc <- dim(gtools::combinations(n, i, 1:n))[1]
        x <- rbind(x, cbind(gtools::combinations(n, i, 1:n),
                            array(0, dim = c(nc, n - i))))
    }
    len <- dim(x)[1]
    x.index <- cbind(as.vector(1:len), as.vector(x))
    x.index <- cbind(x.index[, 1][x.index[, 2] > 0],
                     x.index[, 2][x.index[, 2] > 0])
    x.bin <- array(0, dim = c(len, n))
    x.bin[x.index] <- 1
    list(ragged = x, binary = x.bin)
}

current.model <- function(y, current.comb, xcan,
                          family = c("gaussian", "binomial", "Gamma",
                                     "inverse.gaussian", "poisson","quasi",
                                     "quasibinomial","quasipoisson","beta","ordinal"),
                          link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
                          gof = c("Rsqu", "RMSPE", "logLik"),
                           ...) {
  if (length(family) > 1) family <- family[1]
  if (length(link) > 1) link <- link[1]
  if (length(gof) > 1) gof <- gof[1]
  if (sum(is.na(xcan)) > 0) {
    missing <- is.na(apply(xcan,1,FUN = sum))
    xcan <- xcan[!missing,]
    y <- y[!missing]
  }
  if (sum(is.na(y)) > 0) {
    missing <- is.na(y)
    xcan <- xcan[!missing,]
    y <- y[!missing]
  }
  if (family != "gaussian" & gof == "Rsqu") {
        stop("R-squared is only appropriate if family = 'gaussian'", call. = FALSE)
    }
    comb.data <- data.frame(xcan[, current.comb])
    colnames(comb.data) <- colnames(xcan)[current.comb]
    data <- data.frame(y, comb.data)
    depv <- names(data)[1]
    n.comb <- dim(comb.data)[2]
    xs <- vector("character", n.comb)
    for (i in 1:(n.comb - 1)) xs[i] <- paste(names(comb.data)[i], "+",
                                             sep = "")
    xs[n.comb] <- names(comb.data)[n.comb]
    xss <- paste(xs, collapse = " ", sep = "")
    formu <- stats::formula(paste(depv, "~", xss, sep = ""))
    if (gof == "RMSPE") {
      if (family == "beta") {
          gf <- sqrt(sum((betareg::betareg(formu, family = family,
                                     link = link, ...)$fitted.values - y)^2))
        }
      if (family == "ordinal") {
          gf <- sqrt(sum((MASS::polr(formu, family = family,
                          method = ifelse(is.null(link),"logistic",
                                          gsub("logit","logistic", link)),
                          ...)$fitted.values - y)^2))
         }
       if (!family %in% c("beta","ordinal")) {
          gf <- sqrt(sum((stats::glm(formu, data = data,
                            family = family, ...)$fitted.values - y)^2))
       }
      }
    if (gof == "logLik") {
       if (family == "beta") {
         gf <- as.vector(stats::logLik(betareg::betareg(formu, data = data,
                                        family = family, link = link, ...)))
            }
       if (family == "ordinal") {
         gf <- as.vector(stats::logLik(MASS::polr(formu, data = data,
                                                  family = family,
                                     method = ifelse(is.null(link),"logistic",
                                                     gsub("logit","logistic", link)),
                                     ...)))
            }
       if (!family %in% c("beta","ordinal")) {
         gf <- as.vector(stats::logLik(stats::glm(formu, data = data,
                                                  family = family, ...)))
       }
      }
    if (gof == "Rsqu")
        gf <- summary(stats::lm(formu, data = data))$r.squared
    gf
}

all.regs <- function(y, xcan,
                     family = c("gaussian", "binomial", "Gamma",
                                "inverse.gaussian", "poisson","quasi",
                                "quasibinomial","quasipoisson","beta","ordinal"),
                     link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
                     gof = c("Rsqu", "RMSPE", "logLik"),
                     print.vars = FALSE, ...) {
  if (length(family) > 1) family <- family[1]
  if (length(link) > 1) link <- link[1]
  if (length(gof) > 1) gof <- gof[1]
  if (sum(is.na(xcan)) > 0) {
    missing <- is.na(apply(xcan,1,FUN = sum))
    xcan <- xcan[!missing,]
    y <- y[!missing]
    warning(paste(sum(missing), "observations deleted due to missingness in xcan\n"), call. = FALSE)
  }
  if (sum(is.na(y)) > 0) {
    missing <- is.na(y)
    xcan <- xcan[!missing,]
    y <- y[!missing]
    warning(paste(sum(missing), "observations deleted due to missingness in y\n"), call. = FALSE)
  }
  if (!family %in% c("gaussian", "binomial", "Gamma", "inverse.gaussian",
                      "poisson", "quasi", "quasibinomial","quasipoisson",
                      "beta","ordinal")) {
        stop("The 'family' argument must equal one of 'gaussian', 'binomial',
              'Gamma', 'inverse.gaussian','poisson', 'quasi', 'quasibinomial',
              'quasipoisson', 'beta', or 'ordinal'", call. = FALSE)
        }
  if (family != "gaussian" & gof == "Rsqu") {
        stop("The 'gof' argument can only equal R-squared
             if family = 'gaussian'", call. = FALSE)
    }
    if (!is.vector(y) && dim(y)[2] != 1) {
        cat("\ny must be a vector or a single column data frame")
    }
    pcan <- dim(xcan)[2]
    n <- (2^pcan) - 1
    combs <- combos1(pcan)$ragged
    if (gof != "RMSPE" && gof != "logLik" && gof != "Rsqu") {
        stop(paste("\n gof (goodness of fit measure) must equal",
                   "\n \"RMSPE\" (Root-mean-square \"prediction\" error",
                   "\n \"logLik\" (Log-Likelihood) or",
                   "\n \"Rsqu\" (R-squared)\n\n"), call. = FALSE)
    } else {
      if (gof == "RMSPE") {
        if (family == "beta") {
            gfs <- sqrt(sum((betareg::betareg(y ~ 1, family = family,
                                     link = link, ...)$fitted.values - y)^2))
            }
        if (family == "ordinal") {
            gfs <- sqrt(sum((MASS::polr(y ~ 1, family = family,
                                  method = ifelse(is.null(link),"logistic",
                                                  gsub("logit","logistic", link)),
                                  ...)$fitted.values - y)^2))
        }
        if (!family %in% c("beta","ordinal")) {
            gfs <- sqrt(sum((stats::glm(y ~ 1, family = family, ...)$fitted.values - y)^2))
        }
          }
       if (gof == "logLik") {
        if (family == "beta") {
            gfs <- as.vector(stats::logLik(betareg::betareg(y ~ 1, family = family,
                                         link = link, ...)))
            }
        if (family == "ordinal") {
            gfs <- as.vector(stats::logLik(MASS::polr(y ~ 1, family = family,
                                  method = ifelse(is.null(link),"logistic",
                                                  gsub("logit","logistic", link)),
                                  ...)))
        }
        if (!family %in% c("beta","ordinal")) {
            gfs <- as.vector(stats::logLik(stats::glm(y ~ 1, family = family, ...)))
        }
         }
        if (gof == "Rsqu")
            gfs <- 0
    }
    for (i in 1:n) {
        if (i %% 500 == 0)
            cat(i, "regressions calculated:", n - i, "to go...\n")
        current.comb <- as.vector(combs[i, ][combs[i, ] > 0])
        combn <- paste(names(data.frame(xcan)[current.comb]), "",
                       collapse = "")
        if (gof == "RMSPE")
            new.line <- current.model(y, current.comb, xcan, family = family,
                                      gof = "RMSPE")
        if (gof == "logLik")
            new.line <- current.model(y, current.comb, xcan, family = family,
                                      gof = "logLik")
        if (gof == "Rsqu")
            new.line <- current.model(y, current.comb, xcan, gof = "Rsqu")
        gfs <- c(gfs, new.line)
    }
    if (print.vars) {
        cat("regressions done: formatting results\n")
        var.names <- "Theta"
        for (i in 1:n) {
            current.comb <- as.vector(combs[i, ][combs[i, ] > 0])
            combn <- paste(names(data.frame(xcan)[current.comb]), "",
                           collapse = "")
            new.line <- combn
            var.names <- c(var.names, new.line)
        }
        gfs <- data.frame(`variable combination` = var.names, gof = gfs)
    }
    gfs
}

partition <- function(gfs, pcan, var.names = NULL) {
    if (pcan > 12) {
        stop("Number of variables must be < 13 for current implementation",
             call. = FALSE)
    }
    if (pcan > 9) {
        warning("hier.part produces a rounding error if number of variables >9.
                See documentation.",
            call. = FALSE)
    }
    n <- 2^pcan
    if ((is.vector(gfs) && length(gfs) != n) ||
        (!is.vector(gfs) && dim(gfs)[1] != n)) {
        cat("\nIncorrect number of goodness of fit measures.\n")
        cat("First element must be null model, last full model\n")
        cat("Total number of gof measures should = 2^pcan\n\n")
    } else if (is.vector(gfs)) {
        theta <- gfs[1]
        fin <- gfs[2:n]
    } else {
        wgfs <- dim(gfs)[2]
        # gfs should be a vector or an array with goodness of fit measures
        #  in last col.  wgfs selects last column
        theta <- gfs[1, wgfs]
        fin <- gfs[2:n, wgfs]
    }
    len <- length(fin)
    ij <- vector("numeric", pcan * 2)
    storage.mode(pcan) <- "integer"
    storage.mode(len) <- "integer"
    storage.mode(theta) <- "double"
    storage.mode(fin) <- "double"
    storage.mode(ij) <- "double"
    ij <- .C("hierpart", pcan, len, theta, fin, IJ = ij,
             PACKAGE = "hier.part")$IJ
    ij <- array(ij, dim = c(pcan, 2))
    ij <- data.frame(t(data.frame(t(ij), row.names = c("I", "J"))),
                     row.names = var.names)
    ind.exp.var <- data.frame(ind.exp.var = ij[, 1], row.names = var.names)
    I.perc <- ind.exp.var * 100 / sum(ind.exp.var)
    ij <- cbind(ij, Total = ij$I + ij$J)
    list(gfs = gfs, IJ = ij, I.perc = I.perc)
}

hier.part <- function(y, xcan,
                      family = c("gaussian", "binomial", "Gamma", "inverse.gaussian",
                                 "poisson", "quasi", "quasibinomial", "quasipoisson",
                                 "beta", "ordinal"),
                      link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
                      gof = c("Rsqu", "RMSPE", "logLik"),
                      barplot = TRUE,
                      ...) {
  if (length(family) > 1) family <- family[1]
  if (length(link) > 1) link <- link[1]
  if (length(gof) > 1) gof <- gof[1]
  pcan <- dim(xcan)[2]
    if (pcan > 12)
        stop("Number of variables must be < 13 for current implementation",
             call. = FALSE) else {
        gfs <- all.regs(y, xcan, family = family, gof = gof, link = link, ...)
        hp <- partition(gfs, pcan, var.names = names(data.frame(xcan)))
        if (barplot) {
            ymin <- min(c(0, floor(min(hp$I.perc) * 0.1) * 10))
            ymax <- ceiling(max(hp$I.perc) * 0.1) * 10
            barplot(t(hp$I.perc), col = c(1), ylim = c(ymin, ymax),
                    ylab = "% Independent effects (%I)")
        }
        params <- list(full.model = paste("y ~", paste(names(xcan), collapse = " + ")),
                       family = family,
                       link = ifelse(family %in% c("beta","ordinal"), link, "default"),
                       gof = gof)
        list(gfs = gfs, IJ = hp$IJ, I.perc = hp$I.perc, params = params)
    }
}

rand.hp <- function(y, xcan,
                    family = c("gaussian", "binomial", "Gamma", "inverse.gaussian",
                               "poisson", "quasi", "quasibinomial", "quasipoisson",
                               "beta", "ordinal"),
                    link = c("logit", "probit", "cloglog", "cauchit", "loglog"),
                    gof = c("Rsqu", "RMSPE", "logLik"),
                    num.reps = 100, ...) {
  if (length(family) > 1) family <- family[1]
  if (length(link) > 1) link <- link[1]
  if (length(gof) > 1) gof <- gof[1]
  cat("\nPlease wait: running", num.reps, "randomizations \n")
    ij <- hier.part(y, xcan, family = family, gof = gof, barplot = FALSE)$IJ
    var.names <- row.names(ij)
    i.rands <- data.frame(Obs = ij[, 1], row.names = var.names)
    i.rands <- t(i.rands)
    nvars <- dim(xcan)[2]
    npoints <- dim(xcan)[1]
    nreps <- num.reps + 1
    for (i in 1:num.reps) {
        for (j in 1:nvars) {
            o <- order(stats::runif(npoints))
            xcan[, j] <- xcan[, j][o]
        }
        i.temp <- hier.part(y, xcan, family = family, gof = gof,
                           barplot = FALSE, ...)$IJ[, 1]
        i.rands <- rbind(i.rands, t(i.temp))
    }
    # RMSPE is smaller for better fits: logLik and Rsqu the opposite
    if (gof == "RMSPE")
        i.rands <- i.rands * -1
    z <- (i.rands[1, 1] - mean(i.rands[2:nreps, 1])) / stats::sd(i.rands[2:nreps, 1])
    for (i in 2:nvars) {
        z <- c(z, (i.rands[1, i] -
                       mean(i.rands[2:nreps, i])) / stats::sd(i.rands[2:nreps, i]))
        }
    sig <- vector("character", nvars)
    sig[z >= rep(1.65, nvars)] <- "*"
    i.probs <- data.frame(Obs = round(i.rands[1, ], 2), Z.score = round(z, 2),
                         sig95 = sig, row.names = var.names)
    if (gof == "RMSPE")
        i.rands <- i.rands * -1
    list(Irands = i.rands, Iprobs = i.probs)
}
