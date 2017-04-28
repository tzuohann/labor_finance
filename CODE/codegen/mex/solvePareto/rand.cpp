/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rand.cpp
 *
 * Code generation for function 'rand'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "rand.h"
#include "blas.h"

/* Function Definitions */
real_T b_rand()
{
  real_T r;
  emlrtRandu(&r, 1);
  return r;
}

/* End of code generation (rand.cpp) */
