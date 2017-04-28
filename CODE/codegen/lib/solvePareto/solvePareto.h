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
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "solvePareto_types.h"

/* Function Declarations */
extern void solvePareto(double CV_tol, double Niter, double nPhi, double nG,
  const boolean_T sep_pol_data[], const int sep_pol_size[1], double sigma, const
  emxArray_real_T *pi_Phi, const double Phi_grid_data[], const int
  Phi_grid_size[1], double BETA, const double gamma_vect_data[], const int
  gamma_vect_size[2], const emxArray_real_T *w_star_pre, double U, double pi_z,
  double r, double K, double D, double tau, const emxArray_real_T
  *w_star_pre_cons, emxArray_real_T *TP, emxArray_real_T *gp_star,
  emxArray_real_T *w_star_v, double *EU_vect);

#endif

/* End of code generation (solvePareto.h) */
