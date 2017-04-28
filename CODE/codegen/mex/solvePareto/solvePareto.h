/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * solvePareto.h
 *
 * Code generation for function 'solvePareto'
 *
 */

#ifndef SOLVEPARETO_H
#define SOLVEPARETO_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "solvePareto_types.h"

/* Function Declarations */
extern void solvePareto(const emlrtStack *sp, real_T CV_tol, real_T Niter,
  real_T nPhi, real_T nG, const boolean_T sep_pol_data[], const int32_T
  sep_pol_size[1], real_T sigma, const emxArray_real_T *pi_Phi, const real_T
  Phi_grid_data[], const int32_T Phi_grid_size[1], real_T BETA, const real_T
  gamma_vect_data[], const int32_T gamma_vect_size[2], const emxArray_real_T
  *w_star_pre, real_T U, real_T pi_z, real_T r, real_T K, real_T D, real_T tau,
  const emxArray_real_T *w_star_pre_cons, emxArray_real_T *TP, emxArray_real_T
  *gp_star, emxArray_real_T *w_star_v, real_T *EU_vect);

#endif

/* End of code generation (solvePareto.h) */
