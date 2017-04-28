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
#include "solvePareto_emxutil.h"

/* Function Definitions */
void squeeze(const emxArray_real_T *a, emxArray_real_T *b)
{
  int sqsz_idx_1;
  int i1;
  sqsz_idx_1 = a->size[1];
  i1 = b->size[0] * b->size[1];
  b->size[0] = 1;
  b->size[1] = sqsz_idx_1;
  emxEnsureCapacity((emxArray__common *)b, i1, (int)sizeof(double));
  for (sqsz_idx_1 = 0; sqsz_idx_1 + 1 <= a->size[1]; sqsz_idx_1++) {
    b->data[sqsz_idx_1] = a->data[sqsz_idx_1];
  }
}

/* End of code generation (squeeze.cpp) */
