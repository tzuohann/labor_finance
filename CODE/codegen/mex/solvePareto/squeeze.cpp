/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * squeeze.cpp
 *
 * Code generation for function 'squeeze'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "squeeze.h"
#include "eml_int_forloop_overflow_check.h"
#include "solvePareto_emxutil.h"
#include "solvePareto_data.h"
#include "blas.h"

/* Variable Definitions */
static emlrtRSInfo ab_emlrtRSI = { 28, "squeeze",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\squeeze.m"
};

static emlrtRTEInfo k_emlrtRTEI = { 1, 14, "squeeze",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\squeeze.m"
};

/* Function Definitions */
void squeeze(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *b)
{
  int32_T sqsz_idx_1;
  int32_T i1;
  boolean_T overflow;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  sqsz_idx_1 = a->size[1];
  i1 = b->size[0] * b->size[1];
  b->size[0] = 1;
  b->size[1] = sqsz_idx_1;
  emxEnsureCapacity(sp, (emxArray__common *)b, i1, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  st.site = &ab_emlrtRSI;
  overflow = ((!(1 > a->size[1])) && (a->size[1] > 2147483646));
  if (overflow) {
    b_st.site = &q_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (sqsz_idx_1 = 0; sqsz_idx_1 + 1 <= a->size[1]; sqsz_idx_1++) {
    b->data[sqsz_idx_1] = a->data[sqsz_idx_1];
  }
}

/* End of code generation (squeeze.cpp) */
