#include "hierpart.h"
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>

static const R_CMethodDef cMethods[]  = {
  {"hierpart", (DL_FUNC) &hierpart, -1}
  };

void attribute_visible R_init_hierpart(DllInfo *dll)
  {
    R_registerRoutines(dll, cMethods, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_forceSymbols(dll, TRUE);
  }
