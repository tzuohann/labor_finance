/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * error.cpp
 *
 * Code generation for function 'error'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "error.h"
#include "solvePareto_mexutil.h"
#include "blas.h"

/* Variable Definitions */
static emlrtMCInfo b_emlrtMCI = { 27, 5, "error",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\lang\\error.m"
};

static emlrtRSInfo ib_emlrtRSI = { 27, "error",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\lang\\error.m"
};

/* Function Definitions */
void error(const emlrtStack *sp)
{
  int32_T i0;
  const mxArray *y;
  char_T u[28];
  static const char_T varargin_1[28] = { 'M', 'a', 'x', 'i', 'm', 'u', 'm', ' ',
    'I', 't', 'e', 'r', 'a', 't', 'i', 'o', 'n', ' ', 'T', 'P', ' ', 'r', 'e',
    'a', 'c', 'h', 'e', 'd' };

  const mxArray *m1;
  static const int32_T iv4[2] = { 1, 28 };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  for (i0 = 0; i0 < 28; i0++) {
    u[i0] = varargin_1[i0];
  }

  y = NULL;
  m1 = emlrtCreateCharArray(2, iv4);
  emlrtInitCharArrayR2013a(sp, 28, m1, &u[0]);
  emlrtAssign(&y, m1);
  st.site = &ib_emlrtRSI;
  b_error(&st, y, (emlrtMCInfo *)&b_emlrtMCI);
}

/* End of code generation (error.cpp) */
