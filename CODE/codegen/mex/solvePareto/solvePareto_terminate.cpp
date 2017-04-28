/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * solvePareto_terminate.cpp
 *
 * Code generation for function 'solvePareto_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "solvePareto_terminate.h"
#include "_coder_solvePareto_mex.h"
#include "solvePareto_data.h"
#include "blas.h"

/* Function Definitions */
void solvePareto_atexit()
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void solvePareto_terminate()
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (solvePareto_terminate.cpp) */
