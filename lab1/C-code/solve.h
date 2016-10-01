#ifndef _SOLVE_H_
#define _SOLVE_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "typeutil.h"

double  solve(
  double (*f)(), /* pointer to function to be solved */
  double a,      /* minimum value of solution */
  double b,      /* maximum value of solution */
  double err,    /* accuarcy of solution */
  int *code      /* error code */
  );

#endif /* _SOLVE_H_ */
