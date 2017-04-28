/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_solvePareto_api.h
 *
 * Code generation for function '_coder_solvePareto_api'
 *
 */

#ifndef _CODER_SOLVEPARETO_API_H
#define _CODER_SOLVEPARETO_API_H

/* Include files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_solvePareto_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void solvePareto(real_T CV_tol, real_T Niter, real_T nPhi, real_T nG,
  boolean_T sep_pol_data[], int32_T sep_pol_size[1], real_T sigma,
  emxArray_real_T *pi_Phi, real_T Phi_grid_data[], int32_T Phi_grid_size[1],
  real_T BETA, real_T gamma_vect_data[], int32_T gamma_vect_size[2],
  emxArray_real_T *w_star_pre, real_T U, real_T pi_z, real_T r, real_T K, real_T
  D, real_T tau, emxArray_real_T *w_star_pre_cons, emxArray_real_T *TP,
  emxArray_real_T *gp_star, emxArray_real_T *w_star_v, real_T *EU_vect);
extern void solvePareto_api(const mxArray *prhs[18], const mxArray *plhs[4]);
extern void solvePareto_atexit(void);
extern void solvePareto_initialize(void);
extern void solvePareto_terminate(void);
extern void solvePareto_xil_terminate(void);

#endif

/* End of code generation (_coder_solvePareto_api.h) */
