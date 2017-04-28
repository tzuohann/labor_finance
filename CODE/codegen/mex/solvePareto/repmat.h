/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.h
 *
 * Code generation for function 'repmat'
 *
 */

#ifndef REPMAT_H
#define REPMAT_H

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
extern void b_repmat(const emlrtStack *sp, const real_T a_data[], const int32_T
                     a_size[2], real_T varargin_1, emxArray_real_T *b);
extern void repmat(const emlrtStack *sp, const real_T a_data[], const int32_T
                   a_size[1], real_T varargin_2, emxArray_real_T *b);

#endif

/* End of code generation (repmat.h) */
