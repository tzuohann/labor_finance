/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.cpp
 *
 * Code generation for function 'repmat'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "repmat.h"
#include "solvePareto_emxutil.h"

/* Function Definitions */
void repmat(const double a_data[], const int a_size[1], double varargin_2,
            emxArray_real_T *b)
{
  int nrows;
  boolean_T p;
  int jtilecol;
  int ibtile;
  int k;
  nrows = b->size[0] * b->size[1];
  b->size[0] = a_size[0];
  b->size[1] = (int)varargin_2;
  emxEnsureCapacity((emxArray__common *)b, nrows, (int)sizeof(double));
  if (!(a_size[0] == 0)) {
    if (a_size[0] == 0) {
      p = true;
    } else if ((int)varargin_2 == 0) {
      p = true;
    } else {
      p = false;
    }

    if (!p) {
      nrows = a_size[0];
      for (jtilecol = 1; jtilecol <= (int)varargin_2; jtilecol++) {
        ibtile = (jtilecol - 1) * nrows;
        for (k = 0; k + 1 <= nrows; k++) {
          b->data[ibtile + k] = a_data[k];
        }
      }
    }
  }
}

/* End of code generation (repmat.cpp) */
