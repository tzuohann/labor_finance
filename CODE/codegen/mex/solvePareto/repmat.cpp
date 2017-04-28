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
#include "error.h"
#include "eml_int_forloop_overflow_check.h"
#include "solvePareto_emxutil.h"
#include "solvePareto_mexutil.h"
#include "solvePareto_data.h"
#include "blas.h"

/* Variable Definitions */
static emlrtRSInfo u_emlrtRSI = { 18, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo v_emlrtRSI = { 112, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo w_emlrtRSI = { 119, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo x_emlrtRSI = { 114, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo y_emlrtRSI = { 117, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtMCInfo emlrtMCI = { 37, 5, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRTEInfo j_emlrtRTEI = { 1, 14, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRTEInfo v_emlrtRTEI = { 53, 23, "assertValidSizeArg",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"
};

static emlrtRTEInfo w_emlrtRTEI = { 59, 15, "assertValidSizeArg",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"
};

static emlrtRSInfo jb_emlrtRSI = { 37, "repmat",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

/* Function Definitions */
void b_repmat(const emlrtStack *sp, const real_T a_data[], const int32_T a_size
              [2], real_T varargin_1, emxArray_real_T *b)
{
  boolean_T p;
  real_T b_varargin_1;
  int32_T jcol;
  int32_T ibmat;
  int32_T itilerow;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &u_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if ((varargin_1 != varargin_1) || muDoubleScalarIsInf(varargin_1)) {
    p = false;
  } else {
    p = true;
  }

  if (p && (!(2.147483647E+9 < varargin_1))) {
    p = true;
  } else {
    p = false;
  }

  if (p) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &v_emlrtRTEI,
      "Coder:MATLAB:NonIntegerInput", 4, 12, MIN_int32_T, 12, MAX_int32_T);
  }

  if (varargin_1 <= 0.0) {
    b_varargin_1 = 0.0;
  } else {
    b_varargin_1 = varargin_1;
  }

  if (2.147483647E+9 >= b_varargin_1) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &w_emlrtRTEI, "Coder:MATLAB:pmaxsize", 0);
  }

  jcol = b->size[0] * b->size[1];
  b->size[0] = (int32_T)varargin_1;
  b->size[1] = a_size[1];
  emxEnsureCapacity(sp, (emxArray__common *)b, jcol, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  if (!(a_size[1] == 0)) {
    if ((int32_T)varargin_1 == 0) {
      p = true;
    } else if (a_size[1] == 0) {
      p = true;
    } else {
      p = false;
    }

    if (!p) {
      st.site = &x_emlrtRSI;
      for (jcol = 0; jcol + 1 <= a_size[1]; jcol++) {
        ibmat = jcol * (int32_T)varargin_1;
        st.site = &y_emlrtRSI;
        if ((!(1 > (int32_T)varargin_1)) && ((int32_T)varargin_1 > 2147483646))
        {
          b_st.site = &q_emlrtRSI;
          check_forloop_overflow_error(&b_st);
        }

        for (itilerow = 1; itilerow <= (int32_T)varargin_1; itilerow++) {
          b->data[(ibmat + itilerow) - 1] = a_data[jcol];
        }
      }
    }
  }
}

void repmat(const emlrtStack *sp, const real_T a_data[], const int32_T a_size[1],
            real_T varargin_2, emxArray_real_T *b)
{
  boolean_T p;
  real_T b_varargin_2;
  int32_T nrows;
  const mxArray *y;
  char_T u[15];
  static const char_T cv0[15] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'p', 'm',
    'a', 'x', 's', 'i', 'z', 'e' };

  const mxArray *m0;
  static const int32_T iv3[2] = { 1, 15 };

  int32_T jtilecol;
  int32_T ibtile;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &u_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  if ((varargin_2 != varargin_2) || muDoubleScalarIsInf(varargin_2)) {
    p = false;
  } else {
    p = true;
  }

  if (p && (!(2.147483647E+9 < varargin_2))) {
    p = true;
  } else {
    p = false;
  }

  if (p) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &v_emlrtRTEI,
      "Coder:MATLAB:NonIntegerInput", 4, 12, MIN_int32_T, 12, MAX_int32_T);
  }

  if (varargin_2 <= 0.0) {
    b_varargin_2 = 0.0;
  } else {
    b_varargin_2 = varargin_2;
  }

  if (2.147483647E+9 >= b_varargin_2) {
  } else {
    emlrtErrorWithMessageIdR2012b(&st, &w_emlrtRTEI, "Coder:MATLAB:pmaxsize", 0);
  }

  if ((uint8_T)a_size[0] == a_size[0]) {
  } else {
    for (nrows = 0; nrows < 15; nrows++) {
      u[nrows] = cv0[nrows];
    }

    y = NULL;
    m0 = emlrtCreateCharArray(2, iv3);
    emlrtInitCharArrayR2013a(sp, 15, m0, &u[0]);
    emlrtAssign(&y, m0);
    st.site = &jb_emlrtRSI;
    b_error(&st, y, (emlrtMCInfo *)&emlrtMCI);
  }

  nrows = b->size[0] * b->size[1];
  b->size[0] = a_size[0];
  b->size[1] = (int32_T)varargin_2;
  emxEnsureCapacity(sp, (emxArray__common *)b, nrows, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  if (!(a_size[0] == 0)) {
    if (a_size[0] == 0) {
      p = true;
    } else if ((int32_T)varargin_2 == 0) {
      p = true;
    } else {
      p = false;
    }

    if (!p) {
      nrows = a_size[0];
      st.site = &v_emlrtRSI;
      if ((!(1 > (int32_T)varargin_2)) && ((int32_T)varargin_2 > 2147483646)) {
        b_st.site = &q_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }

      for (jtilecol = 1; jtilecol <= (int32_T)varargin_2; jtilecol++) {
        ibtile = (jtilecol - 1) * nrows;
        st.site = &w_emlrtRSI;
        for (k = 1; k <= nrows; k++) {
          b->data[(ibtile + k) - 1] = a_data[k - 1];
        }
      }
    }
  }
}

/* End of code generation (repmat.cpp) */
