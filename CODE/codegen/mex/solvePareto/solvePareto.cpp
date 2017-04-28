/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * solvePareto.cpp
 *
 * Code generation for function 'solvePareto'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "rand.h"
#include "solvePareto_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "scalexpAlloc.h"
#include "squeeze.h"
#include "error.h"
#include "repmat.h"
#include "solvePareto_data.h"
#include "blas.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 13, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo b_emlrtRSI = { 15, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo c_emlrtRSI = { 20, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo d_emlrtRSI = { 27, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo e_emlrtRSI = { 35, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo f_emlrtRSI = { 36, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo g_emlrtRSI = { 43, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo h_emlrtRSI = { 45, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo i_emlrtRSI = { 53, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo j_emlrtRSI = { 54, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo k_emlrtRSI = { 71, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRSInfo l_emlrtRSI = { 13, "max",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\datafun\\max.m"
};

static emlrtRSInfo m_emlrtRSI = { 19, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo n_emlrtRSI = { 81, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo o_emlrtRSI = { 243, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo p_emlrtRSI = { 269, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo r_emlrtRSI = { 68, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRSInfo s_emlrtRSI = { 21, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRSInfo t_emlrtRSI = { 85, "xgemm",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\+blas\\xgemm.m"
};

static emlrtRSInfo bb_emlrtRSI = { 15, "min",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\datafun\\min.m"
};

static emlrtRSInfo cb_emlrtRSI = { 16, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo db_emlrtRSI = { 140, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo eb_emlrtRSI = { 375, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo fb_emlrtRSI = { 347, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo gb_emlrtRSI = { 210, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRSInfo hb_emlrtRSI = { 214, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRTEInfo emlrtRTEI = { 1, 42, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo b_emlrtRTEI = { 16, 9, "scalexpAlloc",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"
};

static emlrtRTEInfo c_emlrtRTEI = { 19, 24, "scalexpAllocNoCheck",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAllocNoCheck.m"
};

static emlrtRTEInfo d_emlrtRTEI = { 4, 3, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo e_emlrtRTEI = { 20, 3, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo f_emlrtRTEI = { 29, 5, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo g_emlrtRTEI = { 32, 5, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo h_emlrtRTEI = { 43, 7, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo i_emlrtRTEI = { 45, 7, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtDCInfo emlrtDCI = { 4, 32, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 4 };

static emlrtDCInfo b_emlrtDCI = { 4, 32, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 1 };

static emlrtDCInfo c_emlrtDCI = { 4, 37, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 4 };

static emlrtDCInfo d_emlrtDCI = { 4, 37, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 1 };

static emlrtECInfo emlrtECI = { 2, 20, 87, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtECInfo b_emlrtECI = { 2, 20, 59, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtECInfo c_emlrtECI = { 2, 20, 13, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo m_emlrtRTEI = { 33, 5, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtBCInfo emlrtBCI = { -1, -1, 34, 21, "P", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtECInfo d_emlrtECI = { -1, 35, 17, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo n_emlrtRTEI = { 40, 5, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 42, 13, "Phi_grid", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 37, 12, "EP", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtECInfo e_emlrtECI = { -1, 37, 7, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 43, 28, "EP", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 44, 24, "EsigU", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtRTEInfo o_emlrtRTEI = { 50, 9, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 54, 42, "max_EP_Phi0", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtECInfo f_emlrtECI = { 2, 71, 20, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtECInfo g_emlrtECI = { 2, 71, 30, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtECInfo h_emlrtECI = { 2, 71, 19, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m" };

static emlrtRTEInfo p_emlrtRTEI = { 17, 19, "scalexpAlloc",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"
};

static emlrtRTEInfo q_emlrtRTEI = { 103, 23, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRTEInfo r_emlrtRTEI = { 98, 23, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRTEInfo s_emlrtRTEI = { 39, 27, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtRTEInfo t_emlrtRTEI = { 121, 27, "minOrMax",
  "C:\\Program Files\\MATLAB\\R2016a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"
};

static emlrtBCInfo g_emlrtBCI = { -1, -1, 47, 10, "sep_pol", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 57, 42, "igp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 57, 47, "igp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 58, 38, "max_EP_Phi0", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtDCInfo e_emlrtDCI = { 58, 38, "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 1 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 60, 20, "igp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 60, 25, "igp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 61, 33, "gamma_vect", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 61, 19, "gp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 61, 24, "gp_star", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 62, 44, "w_star_pre", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 62, 49, "w_star_pre", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 62, 20, "w_star_v", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 62, 25, "w_star_v", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 63, 45, "Obj_Pre", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo u_emlrtBCI = { -1, -1, 63, 50, "Obj_Pre", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 63, 14, "TP", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

static emlrtBCInfo w_emlrtBCI = { -1, -1, 63, 19, "TP", "solvePareto",
  "G:\\labor_finance\\CODE\\solvePareto.m", 0 };

/* Function Definitions */
void solvePareto(const emlrtStack *sp, real_T CV_tol, real_T Niter, real_T nPhi,
                 real_T nG, const boolean_T sep_pol_data[], const int32_T
                 sep_pol_size[1], real_T sigma, const emxArray_real_T *pi_Phi,
                 const real_T Phi_grid_data[], const int32_T Phi_grid_size[1],
                 real_T BETA, const real_T gamma_vect_data[], const int32_T
                 gamma_vect_size[2], const emxArray_real_T *w_star_pre, real_T U,
                 real_T pi_z, real_T r, real_T K, real_T D, real_T tau, const
                 emxArray_real_T *w_star_pre_cons, emxArray_real_T *TP,
                 emxArray_real_T *gp_star, emxArray_real_T *w_star_v, real_T
                 *EU_vect)
{
  emxArray_real_T *igp_star;
  int32_T n;
  int32_T ixstop;
  real_T U2_data[200];
  int32_T U2_size[1];
  real_T mtmp;
  real_T z_data[200];
  uint8_T pi_Phi_idx_0;
  int32_T EsigU_size[1];
  real_T EsigU_data[200];
  emxArray_real_T *P;
  int32_T ixstart;
  emxArray_real_T *r0;
  int32_T ix;
  real_T b_EsigU_data;
  real_T beta1;
  char_T TRANSB;
  char_T TRANSA;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  int32_T b_w_star_pre_cons[2];
  int32_T b_P[2];
  emxArray_real_T *r1;
  int32_T iv0[2];
  int32_T c_P[2];
  emxArray_real_T *a;
  emxArray_real_T *Obj_Pre;
  int32_T b_a[2];
  int32_T b_Obj_Pre[2];
  int32_T c_a[2];
  int32_T iv1[2];
  real_T tol;
  real_T Iter;
  emxArray_real_T *EP;
  emxArray_real_T *EP_Phi0;
  emxArray_real_T *max_EP_Phi0;
  emxArray_int32_T *r2;
  emxArray_real_T *z;
  emxArray_real_T *b_EP;
  int32_T ig;
  int32_T iphi;
  int32_T b_TP[2];
  int32_T d_P[2];
  int32_T z_size[1];
  int32_T c_TP[2];
  int32_T e_P[2];
  int32_T d_TP[2];
  int32_T e_TP[2];
  boolean_T overflow;
  int32_T EP0_size[1];
  real_T EP0_data[200];
  real_T b_EP0_data;
  int32_T iv2[1];
  int32_T b_ix;
  real_T B;
  boolean_T exitg2;
  real_T A;
  boolean_T exitg1;
  boolean_T exitg3;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &igp_star, 2, &d_emlrtRTEI, true);
  if (!(nPhi >= 0.0)) {
    emlrtNonNegativeCheckR2012b(nPhi, (emlrtDCInfo *)&emlrtDCI, sp);
  }

  if (nPhi != (int32_T)muDoubleScalarFloor(nPhi)) {
    emlrtIntegerCheckR2012b(nPhi, (emlrtDCInfo *)&b_emlrtDCI, sp);
  }

  if (!(nG >= 0.0)) {
    emlrtNonNegativeCheckR2012b(nG, (emlrtDCInfo *)&c_emlrtDCI, sp);
  }

  if (nG != (int32_T)muDoubleScalarFloor(nG)) {
    emlrtIntegerCheckR2012b(nG, (emlrtDCInfo *)&d_emlrtDCI, sp);
  }

  n = igp_star->size[0] * igp_star->size[1];
  igp_star->size[0] = (int32_T)nPhi;
  igp_star->size[1] = (int32_T)nG;
  emxEnsureCapacity(sp, (emxArray__common *)igp_star, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = (int32_T)nPhi * (int32_T)nG;
  for (n = 0; n < ixstop; n++) {
    igp_star->data[n] = rtNaN;
  }

  n = gp_star->size[0] * gp_star->size[1];
  gp_star->size[0] = (int32_T)nPhi;
  gp_star->size[1] = (int32_T)nG;
  emxEnsureCapacity(sp, (emxArray__common *)gp_star, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = (int32_T)nPhi * (int32_T)nG;
  for (n = 0; n < ixstop; n++) {
    gp_star->data[n] = rtNaN;
  }

  n = w_star_v->size[0] * w_star_v->size[1];
  w_star_v->size[0] = (int32_T)nPhi;
  w_star_v->size[1] = (int32_T)nG;
  emxEnsureCapacity(sp, (emxArray__common *)w_star_v, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = (int32_T)nPhi * (int32_T)nG;
  for (n = 0; n < ixstop; n++) {
    w_star_v->data[n] = rtNaN;
  }

  n = TP->size[0] * TP->size[1];
  TP->size[0] = (int32_T)nPhi;
  TP->size[1] = (int32_T)nG;
  emxEnsureCapacity(sp, (emxArray__common *)TP, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = (int32_T)nPhi * (int32_T)nG;
  for (n = 0; n < ixstop; n++) {
    TP->data[n] = 0.0;
  }

  *EU_vect = pi_z * U;
  st.site = &emlrtRSI;
  b_st.site = &l_emlrtRSI;
  c_st.site = &m_emlrtRSI;
  d_st.site = &n_emlrtRSI;
  e_st.site = &o_emlrtRSI;
  U2_size[0] = (uint8_T)sep_pol_size[0];
  if (dimagree(U2_size, sep_pol_size)) {
  } else {
    emlrtErrorWithMessageIdR2012b(&e_st, &p_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  e_st.site = &p_emlrtRSI;
  for (ixstop = 0; ixstop + 1 <= (uint8_T)sep_pol_size[0]; ixstop++) {
    if (((real_T)sep_pol_data[ixstop] > sigma) || muDoubleScalarIsNaN(sigma)) {
      mtmp = sep_pol_data[ixstop];
    } else {
      mtmp = sigma;
    }

    U2_data[ixstop] = mtmp;
  }

  ixstop = (uint8_T)sep_pol_size[0];
  for (n = 0; n < ixstop; n++) {
    U2_data[n] *= U;
  }

  /* EsigU  = pi_z*U2(:);  % mistake here.. */
  st.site = &b_emlrtRSI;
  ixstop = (uint8_T)sep_pol_size[0];
  for (n = 0; n < ixstop; n++) {
    z_data[n] = U2_data[n];
  }

  b_st.site = &s_emlrtRSI;
  if (!(pi_Phi->size[1] == (uint8_T)sep_pol_size[0])) {
    if (((pi_Phi->size[0] == 1) && (pi_Phi->size[1] == 1)) || ((uint8_T)
         sep_pol_size[0] == 1)) {
      emlrtErrorWithMessageIdR2012b(&b_st, &r_emlrtRTEI,
        "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
    } else {
      emlrtErrorWithMessageIdR2012b(&b_st, &q_emlrtRTEI, "Coder:MATLAB:innerdim",
        0);
    }
  }

  if ((pi_Phi->size[1] == 1) || ((uint8_T)sep_pol_size[0] == 1)) {
    EsigU_size[0] = pi_Phi->size[0];
    ixstop = pi_Phi->size[0];
    for (n = 0; n < ixstop; n++) {
      EsigU_data[n] = 0.0;
      ixstart = pi_Phi->size[1];
      for (ix = 0; ix < ixstart; ix++) {
        b_EsigU_data = EsigU_data[n] + pi_Phi->data[n + pi_Phi->size[0] * ix] *
          U2_data[ix];
        EsigU_data[n] = b_EsigU_data;
      }
    }
  } else {
    pi_Phi_idx_0 = (uint8_T)pi_Phi->size[0];
    ixstop = pi_Phi_idx_0;
    EsigU_size[0] = pi_Phi_idx_0;
    for (n = 0; n < ixstop; n++) {
      EsigU_data[n] = 0.0;
    }

    b_st.site = &r_emlrtRSI;
    if ((pi_Phi->size[0] < 1) || (pi_Phi->size[1] < 1)) {
    } else {
      c_st.site = &t_emlrtRSI;
      mtmp = 1.0;
      beta1 = 0.0;
      TRANSB = 'N';
      TRANSA = 'N';
      m_t = (ptrdiff_t)pi_Phi->size[0];
      n_t = (ptrdiff_t)1;
      k_t = (ptrdiff_t)pi_Phi->size[1];
      lda_t = (ptrdiff_t)pi_Phi->size[0];
      ldb_t = (ptrdiff_t)pi_Phi->size[1];
      ldc_t = (ptrdiff_t)pi_Phi->size[0];
      dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &mtmp, &pi_Phi->data[0], &lda_t,
            &z_data[0], &ldb_t, &beta1, &EsigU_data[0], &ldc_t);
    }
  }

  emxInit_real_T(&st, &P, 2, &f_emlrtRTEI, true);
  emxInit_real_T(&st, &r0, 2, &emlrtRTEI, true);

  /* %%%%%should be W0, not U0%%%%%%%%%%% */
  st.site = &c_emlrtRSI;
  repmat(&st, EsigU_data, EsigU_size, nG, r0);
  n = P->size[0] * P->size[1];
  P->size[0] = r0->size[0];
  P->size[1] = r0->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)P, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = r0->size[0] * r0->size[1];
  for (n = 0; n < ixstop; n++) {
    P->data[n] = r0->data[n];
  }

  n = P->size[0] * P->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)P, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = P->size[0];
  ixstart = P->size[1];
  ixstop *= ixstart;
  for (n = 0; n < ixstop; n++) {
    P->data[n] *= BETA;
  }

  for (n = 0; n < 2; n++) {
    b_w_star_pre_cons[n] = w_star_pre_cons->size[n];
  }

  for (n = 0; n < 2; n++) {
    b_P[n] = P->size[n];
  }

  emxInit_real_T(sp, &r1, 2, &emlrtRTEI, true);
  if ((b_w_star_pre_cons[0] != b_P[0]) || (b_w_star_pre_cons[1] != b_P[1])) {
    emlrtSizeEqCheckNDR2012b(&b_w_star_pre_cons[0], &b_P[0], (emlrtECInfo *)
      &emlrtECI, sp);
  }

  st.site = &c_emlrtRSI;
  b_repmat(&st, gamma_vect_data, gamma_vect_size, nPhi, r1);
  for (n = 0; n < 2; n++) {
    iv0[n] = r1->size[n];
  }

  for (n = 0; n < 2; n++) {
    c_P[n] = P->size[n];
  }

  emxInit_real_T(sp, &a, 2, &emlrtRTEI, true);
  if ((iv0[0] != c_P[0]) || (iv0[1] != c_P[1])) {
    emlrtSizeEqCheckNDR2012b(&iv0[0], &c_P[0], (emlrtECInfo *)&b_emlrtECI, sp);
  }

  st.site = &c_emlrtRSI;
  repmat(&st, Phi_grid_data, Phi_grid_size, nG, a);
  n = a->size[0] * a->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)a, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = a->size[0];
  ixstart = a->size[1];
  mtmp = D * r;
  ixstop *= ixstart;
  for (n = 0; n < ixstop; n++) {
    a->data[n] -= mtmp;
  }

  n = a->size[0] * a->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)a, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = a->size[0];
  ixstart = a->size[1];
  ixstop *= ixstart;
  for (n = 0; n < ixstop; n++) {
    a->data[n] *= 1.0 - tau;
  }

  emxInit_real_T(sp, &Obj_Pre, 2, &e_emlrtRTEI, true);
  n = Obj_Pre->size[0] * Obj_Pre->size[1];
  Obj_Pre->size[0] = r1->size[0];
  Obj_Pre->size[1] = r1->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)Obj_Pre, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = r1->size[0] * r1->size[1];
  for (n = 0; n < ixstop; n++) {
    Obj_Pre->data[n] = r1->data[n] * (w_star_pre_cons->data[n] + P->data[n]);
  }

  emxFree_real_T(&r1);
  for (n = 0; n < 2; n++) {
    b_a[n] = a->size[n];
  }

  for (n = 0; n < 2; n++) {
    b_Obj_Pre[n] = Obj_Pre->size[n];
  }

  if ((b_a[0] != b_Obj_Pre[0]) || (b_a[1] != b_Obj_Pre[1])) {
    emlrtSizeEqCheckNDR2012b(&b_a[0], &b_Obj_Pre[0], (emlrtECInfo *)&c_emlrtECI,
      sp);
  }

  n = r0->size[0] * r0->size[1];
  r0->size[0] = w_star_pre->size[0];
  r0->size[1] = w_star_pre->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r0, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  ixstop = w_star_pre->size[0] * w_star_pre->size[1];
  for (n = 0; n < ixstop; n++) {
    r0->data[n] = w_star_pre->data[n] * (1.0 - tau);
  }

  for (n = 0; n < 2; n++) {
    c_a[n] = a->size[n];
  }

  for (n = 0; n < 2; n++) {
    iv1[n] = r0->size[n];
  }

  if ((c_a[0] != iv1[0]) || (c_a[1] != iv1[1])) {
    emlrtSizeEqCheckNDR2012b(&c_a[0], &iv1[0], (emlrtECInfo *)&c_emlrtECI, sp);
  }

  n = Obj_Pre->size[0] * Obj_Pre->size[1];
  Obj_Pre->size[0] = a->size[0];
  Obj_Pre->size[1] = a->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)Obj_Pre, n, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  mtmp = r * K;
  ixstop = a->size[0] * a->size[1];
  for (n = 0; n < ixstop; n++) {
    Obj_Pre->data[n] = ((mtmp + a->data[n]) + Obj_Pre->data[n]) - r0->data[n];
  }

  emxFree_real_T(&r0);
  emxFree_real_T(&a);
  tol = 1.0;
  Iter = 0.0;
  emxInit_real_T(sp, &EP, 2, &g_emlrtRTEI, true);
  emxInit_real_T(sp, &EP_Phi0, 2, &h_emlrtRTEI, true);
  emxInit_real_T(sp, &max_EP_Phi0, 2, &i_emlrtRTEI, true);
  emxInit_int32_T(sp, &r2, 1, &emlrtRTEI, true);
  emxInit_real_T(sp, &z, 2, &emlrtRTEI, true);
  emxInit_real_T(sp, &b_EP, 2, &emlrtRTEI, true);
  while ((tol > CV_tol) && (Iter < Niter)) {
    Iter++;
    if (Iter == Niter) {
      st.site = &d_emlrtRSI;
      error(&st);
    }

    n = P->size[0] * P->size[1];
    P->size[0] = TP->size[0];
    P->size[1] = TP->size[1];
    emxEnsureCapacity(sp, (emxArray__common *)P, n, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    ixstop = TP->size[0] * TP->size[1];
    for (n = 0; n < ixstop; n++) {
      P->data[n] = TP->data[n];
    }

    /*  computing expectations */
    n = EP->size[0] * EP->size[1];
    EP->size[0] = (int32_T)nPhi;
    EP->size[1] = (int32_T)nG;
    emxEnsureCapacity(sp, (emxArray__common *)EP, n, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    ixstop = (int32_T)nPhi * (int32_T)nG;
    for (n = 0; n < ixstop; n++) {
      EP->data[n] = 0.0;
    }

    emlrtForLoopVectorCheckR2012b(1.0, 1.0, nG, mxDOUBLE_CLASS, (int32_T)nG,
      (emlrtRTEInfo *)&m_emlrtRTEI, sp);
    ig = 0;
    while (ig <= (int32_T)nG - 1) {
      n = TP->size[1];
      ix = ig + 1;
      if (!((ix >= 1) && (ix <= n))) {
        emlrtDynamicBoundsCheckR2012b(ix, 1, n, (emlrtBCInfo *)&emlrtBCI, sp);
      }

      st.site = &e_emlrtRSI;
      b_st.site = &l_emlrtRSI;
      c_st.site = &m_emlrtRSI;
      d_st.site = &n_emlrtRSI;
      e_st.site = &o_emlrtRSI;
      z_size[0] = (uint8_T)sep_pol_size[0];
      if (dimagree(z_size, sep_pol_size)) {
      } else {
        emlrtErrorWithMessageIdR2012b(&e_st, &p_emlrtRTEI, "MATLAB:dimagree", 0);
      }

      e_st.site = &p_emlrtRSI;
      for (ixstop = 0; ixstop + 1 <= (uint8_T)sep_pol_size[0]; ixstop++) {
        if (((real_T)sep_pol_data[ixstop] > sigma) || muDoubleScalarIsNaN(sigma))
        {
          mtmp = sep_pol_data[ixstop];
        } else {
          mtmp = sigma;
        }

        z_data[ixstop] = mtmp;
      }

      n = TP->size[0];
      ix = (uint8_T)sep_pol_size[0];
      if (ix != n) {
        emlrtSizeEqCheck1DR2012b(ix, n, (emlrtECInfo *)&d_emlrtECI, sp);
      }

      ixstop = (uint8_T)sep_pol_size[0];
      for (n = 0; n < ixstop; n++) {
        U2_data[n] = (1.0 - z_data[n]) * TP->data[n + TP->size[0] * ig];
      }

      /*   + max(sep_pol,sigma)*(K-D); %% testing with K-D */
      st.site = &f_emlrtRSI;
      ixstop = (uint8_T)sep_pol_size[0];
      for (n = 0; n < ixstop; n++) {
        z_data[n] = U2_data[n];
      }

      b_st.site = &s_emlrtRSI;
      if (!(pi_Phi->size[1] == (uint8_T)sep_pol_size[0])) {
        if (((pi_Phi->size[0] == 1) && (pi_Phi->size[1] == 1)) || ((uint8_T)
             sep_pol_size[0] == 1)) {
          emlrtErrorWithMessageIdR2012b(&b_st, &r_emlrtRTEI,
            "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
        } else {
          emlrtErrorWithMessageIdR2012b(&b_st, &q_emlrtRTEI,
            "Coder:MATLAB:innerdim", 0);
        }
      }

      if ((pi_Phi->size[1] == 1) || ((uint8_T)sep_pol_size[0] == 1)) {
        EP0_size[0] = pi_Phi->size[0];
        ixstop = pi_Phi->size[0];
        for (n = 0; n < ixstop; n++) {
          EP0_data[n] = 0.0;
          ixstart = pi_Phi->size[1];
          for (ix = 0; ix < ixstart; ix++) {
            b_EP0_data = EP0_data[n] + pi_Phi->data[n + pi_Phi->size[0] * ix] *
              U2_data[ix];
            EP0_data[n] = b_EP0_data;
          }
        }
      } else {
        pi_Phi_idx_0 = (uint8_T)pi_Phi->size[0];
        ixstop = pi_Phi_idx_0;
        EP0_size[0] = pi_Phi_idx_0;
        for (n = 0; n < ixstop; n++) {
          EP0_data[n] = 0.0;
        }

        b_st.site = &r_emlrtRSI;
        if ((pi_Phi->size[0] < 1) || (pi_Phi->size[1] < 1)) {
        } else {
          c_st.site = &t_emlrtRSI;
          mtmp = 1.0;
          beta1 = 0.0;
          TRANSB = 'N';
          TRANSA = 'N';
          m_t = (ptrdiff_t)pi_Phi->size[0];
          n_t = (ptrdiff_t)1;
          k_t = (ptrdiff_t)pi_Phi->size[1];
          lda_t = (ptrdiff_t)pi_Phi->size[0];
          ldb_t = (ptrdiff_t)pi_Phi->size[1];
          ldc_t = (ptrdiff_t)pi_Phi->size[0];
          dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &mtmp, &pi_Phi->data[0],
                &lda_t, &z_data[0], &ldb_t, &beta1, &EP0_data[0], &ldc_t);
        }
      }

      /*  this one includes separation */
      ixstop = EP->size[0];
      n = r2->size[0];
      r2->size[0] = ixstop;
      emxEnsureCapacity(sp, (emxArray__common *)r2, n, (int32_T)sizeof(int32_T),
                        &emlrtRTEI);
      for (n = 0; n < ixstop; n++) {
        r2->data[n] = n;
      }

      n = EP->size[1];
      ix = ig + 1;
      if (!((ix >= 1) && (ix <= n))) {
        emlrtDynamicBoundsCheckR2012b(ix, 1, n, (emlrtBCInfo *)&c_emlrtBCI, sp);
      }

      iv2[0] = r2->size[0];
      emlrtSubAssignSizeCheckR2012b(iv2, 1, EP0_size, 1, (emlrtECInfo *)
        &e_emlrtECI, sp);
      ixstop = EP0_size[0];
      for (n = 0; n < ixstop; n++) {
        EP->data[r2->data[n] + EP->size[0] * ig] = EP0_data[n];
      }

      ig++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    emlrtForLoopVectorCheckR2012b(1.0, 1.0, nPhi, mxDOUBLE_CLASS, (int32_T)nPhi,
      (emlrtRTEInfo *)&n_emlrtRTEI, sp);
    iphi = 1;
    while (iphi - 1 <= (int32_T)nPhi - 1) {
      n = (iphi - 1) + 1;
      if (!((n >= 1) && (n <= Phi_grid_size[0]))) {
        emlrtDynamicBoundsCheckR2012b(n, 1, Phi_grid_size[0], (emlrtBCInfo *)
          &b_emlrtBCI, sp);
      }

      ixstop = EP->size[1];
      n = EP->size[0];
      if (!((iphi >= 1) && (iphi <= n))) {
        emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&d_emlrtBCI, sp);
      }

      n = b_EP->size[0] * b_EP->size[1];
      b_EP->size[0] = 1;
      b_EP->size[1] = ixstop;
      emxEnsureCapacity(sp, (emxArray__common *)b_EP, n, (int32_T)sizeof(real_T),
                        &emlrtRTEI);
      for (n = 0; n < ixstop; n++) {
        b_EP->data[b_EP->size[0] * n] = EP->data[(iphi + EP->size[0] * n) - 1];
      }

      st.site = &g_emlrtRSI;
      squeeze(&st, b_EP, EP_Phi0);
      n = (iphi - 1) + 1;
      if (!((n >= 1) && (n <= EsigU_size[0]))) {
        emlrtDynamicBoundsCheckR2012b(n, 1, EsigU_size[0], (emlrtBCInfo *)
          &e_emlrtBCI, sp);
      }

      st.site = &h_emlrtRSI;
      b_st.site = &l_emlrtRSI;
      c_st.site = &m_emlrtRSI;
      d_st.site = &n_emlrtRSI;
      e_st.site = &o_emlrtRSI;
      n = z->size[0] * z->size[1];
      z->size[0] = 1;
      z->size[1] = EP_Phi0->size[1];
      emxEnsureCapacity(&e_st, (emxArray__common *)z, n, (int32_T)sizeof(real_T),
                        &c_emlrtRTEI);
      ixstart = EP_Phi0->size[1];
      n = max_EP_Phi0->size[0] * max_EP_Phi0->size[1];
      max_EP_Phi0->size[0] = 1;
      max_EP_Phi0->size[1] = EP_Phi0->size[1];
      emxEnsureCapacity(&e_st, (emxArray__common *)max_EP_Phi0, n, (int32_T)
                        sizeof(real_T), &b_emlrtRTEI);
      if (b_dimagree(max_EP_Phi0, EP_Phi0)) {
      } else {
        emlrtErrorWithMessageIdR2012b(&e_st, &p_emlrtRTEI, "MATLAB:dimagree", 0);
      }

      e_st.site = &p_emlrtRSI;
      overflow = ((!(1 > z->size[1])) && (z->size[1] > 2147483646));
      if (overflow) {
        f_st.site = &q_emlrtRSI;
        check_forloop_overflow_error(&f_st);
      }

      for (ixstop = 0; ixstop + 1 <= ixstart; ixstop++) {
        max_EP_Phi0->data[ixstop] = muDoubleScalarMax(EP_Phi0->data[ixstop], 0.0);
      }

      if (!((iphi >= 1) && (iphi <= sep_pol_size[0]))) {
        emlrtDynamicBoundsCheckR2012b(iphi, 1, sep_pol_size[0], (emlrtBCInfo *)
          &g_emlrtBCI, sp);
      }

      if ((int32_T)sep_pol_data[iphi - 1] < 1) {
        /*  as long as there is no separation */
        /* This is the slow part. Make this faster. */
        emlrtForLoopVectorCheckR2012b(1.0, 1.0, nG, mxDOUBLE_CLASS, (int32_T)nG,
          (emlrtRTEInfo *)&o_emlrtRTEI, sp);
        ig = 1;
        while (ig - 1 <= (int32_T)nG - 1) {
          /* Maximize more frequently as we get closer to the solution */
          st.site = &i_emlrtRSI;
          if (b_rand() < 2.0) {
            /* max(CV_tol/tol,0.5) */
            if (1.0 + (real_T)(ig - 1) > nG) {
              n = 0;
              ixstart = 0;
            } else {
              n = max_EP_Phi0->size[1];
              if (!((ig >= 1) && (ig <= n))) {
                emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)
                  &f_emlrtBCI, sp);
              }

              n = ig - 1;
              ix = max_EP_Phi0->size[1];
              ixstart = (int32_T)nG;
              if (!((ixstart >= 1) && (ixstart <= ix))) {
                emlrtDynamicBoundsCheckR2012b(ixstart, 1, ix, (emlrtBCInfo *)
                  &f_emlrtBCI, sp);
              }
            }

            ix = EP_Phi0->size[0] * EP_Phi0->size[1];
            EP_Phi0->size[0] = 1;
            EP_Phi0->size[1] = ixstart - n;
            emxEnsureCapacity(sp, (emxArray__common *)EP_Phi0, ix, (int32_T)
                              sizeof(real_T), &emlrtRTEI);
            ixstop = ixstart - n;
            for (ix = 0; ix < ixstop; ix++) {
              EP_Phi0->data[EP_Phi0->size[0] * ix] = BETA * max_EP_Phi0->data[n
                + ix];
            }

            st.site = &j_emlrtRSI;
            b_st.site = &bb_emlrtRSI;
            c_st.site = &cb_emlrtRSI;
            if ((EP_Phi0->size[1] == 1) || (EP_Phi0->size[1] != 1)) {
              overflow = true;
            } else {
              overflow = false;
            }

            if (overflow) {
            } else {
              emlrtErrorWithMessageIdR2012b(&c_st, &s_emlrtRTEI,
                "Coder:toolbox:autoDimIncompatibility", 0);
            }

            if (EP_Phi0->size[1] > 0) {
            } else {
              emlrtErrorWithMessageIdR2012b(&c_st, &t_emlrtRTEI,
                "Coder:toolbox:eml_min_or_max_varDimZero", 0);
            }

            d_st.site = &db_emlrtRSI;
            ixstart = 1;
            n = EP_Phi0->size[1];
            mtmp = EP_Phi0->data[0];
            ixstop = 1;
            if (EP_Phi0->size[1] > 1) {
              if (muDoubleScalarIsNaN(EP_Phi0->data[0])) {
                e_st.site = &fb_emlrtRSI;
                overflow = (EP_Phi0->size[1] > 2147483646);
                if (overflow) {
                  f_st.site = &q_emlrtRSI;
                  check_forloop_overflow_error(&f_st);
                }

                b_ix = 2;
                exitg3 = false;
                while ((!exitg3) && (b_ix <= n)) {
                  ixstart = b_ix;
                  if (!muDoubleScalarIsNaN(EP_Phi0->data[b_ix - 1])) {
                    mtmp = EP_Phi0->data[b_ix - 1];
                    ixstop = b_ix;
                    exitg3 = true;
                  } else {
                    b_ix++;
                  }
                }
              }

              if (ixstart < EP_Phi0->size[1]) {
                e_st.site = &eb_emlrtRSI;
                overflow = ((!(ixstart + 1 > EP_Phi0->size[1])) &&
                            (EP_Phi0->size[1] > 2147483646));
                if (overflow) {
                  f_st.site = &q_emlrtRSI;
                  check_forloop_overflow_error(&f_st);
                }

                while (ixstart + 1 <= n) {
                  if (EP_Phi0->data[ixstart] < mtmp) {
                    mtmp = EP_Phi0->data[ixstart];
                    ixstop = ixstart + 1;
                  }

                  ixstart++;
                }
              }
            }

            A = mtmp;
            B = ((real_T)ixstop + (1.0 + (real_T)(ig - 1))) - 1.0;
          } else {
            n = igp_star->size[0];
            if (!((iphi >= 1) && (iphi <= n))) {
              emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)
                &h_emlrtBCI, sp);
            }

            n = igp_star->size[1];
            if (!((ig >= 1) && (ig <= n))) {
              emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&i_emlrtBCI,
                sp);
            }

            B = igp_star->data[(iphi + igp_star->size[0] * (ig - 1)) - 1];
            n = max_EP_Phi0->size[1];
            mtmp = igp_star->data[(iphi + igp_star->size[0] * (ig - 1)) - 1];
            if (mtmp != (int32_T)muDoubleScalarFloor(mtmp)) {
              emlrtIntegerCheckR2012b(mtmp, (emlrtDCInfo *)&e_emlrtDCI, sp);
            }

            ix = (int32_T)mtmp;
            if (!((ix >= 1) && (ix <= n))) {
              emlrtDynamicBoundsCheckR2012b(ix, 1, n, (emlrtBCInfo *)&j_emlrtBCI,
                sp);
            }

            A = BETA * max_EP_Phi0->data[ix - 1];
          }

          n = igp_star->size[0];
          if (!((iphi >= 1) && (iphi <= n))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&k_emlrtBCI,
              sp);
          }

          n = igp_star->size[1];
          if (!((ig >= 1) && (ig <= n))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&l_emlrtBCI,
              sp);
          }

          igp_star->data[(iphi + igp_star->size[0] * (ig - 1)) - 1] = B;
          n = (int32_T)B;
          if (!((n >= 1) && (n <= gamma_vect_size[1]))) {
            emlrtDynamicBoundsCheckR2012b(n, 1, gamma_vect_size[1], (emlrtBCInfo
              *)&m_emlrtBCI, sp);
          }

          ix = gp_star->size[0];
          if (!((iphi >= 1) && (iphi <= ix))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, ix, (emlrtBCInfo *)
              &n_emlrtBCI, sp);
          }

          ix = gp_star->size[1];
          if (!((ig >= 1) && (ig <= ix))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, ix, (emlrtBCInfo *)&o_emlrtBCI,
              sp);
          }

          gp_star->data[(iphi + gp_star->size[0] * (ig - 1)) - 1] =
            gamma_vect_data[n - 1];
          n = w_star_pre->size[0];
          if (!((iphi >= 1) && (iphi <= n))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&p_emlrtBCI,
              sp);
          }

          n = w_star_pre->size[1];
          if (!((ig >= 1) && (ig <= n))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&q_emlrtBCI,
              sp);
          }

          n = w_star_v->size[0];
          if (!((iphi >= 1) && (iphi <= n))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&r_emlrtBCI,
              sp);
          }

          n = w_star_v->size[1];
          if (!((ig >= 1) && (ig <= n))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&s_emlrtBCI,
              sp);
          }

          w_star_v->data[(iphi + w_star_v->size[0] * (ig - 1)) - 1] =
            w_star_pre->data[(iphi + w_star_pre->size[0] * (ig - 1)) - 1];

          /*  independent of ig */
          n = Obj_Pre->size[0];
          if (!((iphi >= 1) && (iphi <= n))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&t_emlrtBCI,
              sp);
          }

          n = Obj_Pre->size[1];
          if (!((ig >= 1) && (ig <= n))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&u_emlrtBCI,
              sp);
          }

          n = TP->size[0];
          if (!((iphi >= 1) && (iphi <= n))) {
            emlrtDynamicBoundsCheckR2012b(iphi, 1, n, (emlrtBCInfo *)&v_emlrtBCI,
              sp);
          }

          n = TP->size[1];
          if (!((ig >= 1) && (ig <= n))) {
            emlrtDynamicBoundsCheckR2012b(ig, 1, n, (emlrtBCInfo *)&w_emlrtBCI,
              sp);
          }

          TP->data[(iphi + TP->size[0] * (ig - 1)) - 1] = A + Obj_Pre->data
            [(iphi + Obj_Pre->size[0] * (ig - 1)) - 1];
          ig++;
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(sp);
          }
        }
      }

      iphi++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    for (n = 0; n < 2; n++) {
      b_TP[n] = TP->size[n];
    }

    for (n = 0; n < 2; n++) {
      d_P[n] = P->size[n];
    }

    if ((b_TP[0] != d_P[0]) || (b_TP[1] != d_P[1])) {
      emlrtSizeEqCheckNDR2012b(&b_TP[0], &d_P[0], (emlrtECInfo *)&f_emlrtECI, sp);
    }

    for (n = 0; n < 2; n++) {
      c_TP[n] = TP->size[n];
    }

    for (n = 0; n < 2; n++) {
      e_P[n] = P->size[n];
    }

    if ((c_TP[0] != e_P[0]) || (c_TP[1] != e_P[1])) {
      emlrtSizeEqCheckNDR2012b(&c_TP[0], &e_P[0], (emlrtECInfo *)&g_emlrtECI, sp);
    }

    for (n = 0; n < 2; n++) {
      d_TP[n] = TP->size[n];
    }

    for (n = 0; n < 2; n++) {
      e_TP[n] = TP->size[n];
    }

    if ((d_TP[0] != e_TP[0]) || (d_TP[1] != e_TP[1])) {
      emlrtSizeEqCheckNDR2012b(&d_TP[0], &e_TP[0], (emlrtECInfo *)&h_emlrtECI,
        sp);
    }

    st.site = &k_emlrtRSI;
    n = P->size[0] * P->size[1];
    P->size[0] = TP->size[0];
    P->size[1] = TP->size[1];
    emxEnsureCapacity(&st, (emxArray__common *)P, n, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    ixstop = TP->size[0] * TP->size[1];
    for (n = 0; n < ixstop; n++) {
      P->data[n] = (TP->data[n] - P->data[n]) * (TP->data[n] - P->data[n]);
    }

    b_st.site = &l_emlrtRSI;
    c_st.site = &m_emlrtRSI;
    if (((P->size[0] == 1) && (P->size[1] == 1)) || (P->size[0] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (overflow) {
    } else {
      emlrtErrorWithMessageIdR2012b(&c_st, &s_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    if (P->size[0] > 0) {
    } else {
      emlrtErrorWithMessageIdR2012b(&c_st, &t_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    n = EP_Phi0->size[0] * EP_Phi0->size[1];
    EP_Phi0->size[0] = 1;
    EP_Phi0->size[1] = P->size[1];
    emxEnsureCapacity(&c_st, (emxArray__common *)EP_Phi0, n, (int32_T)sizeof
                      (real_T), &emlrtRTEI);
    n = P->size[0];
    d_st.site = &gb_emlrtRSI;
    overflow = ((!(1 > P->size[1])) && (P->size[1] > 2147483646));
    if (overflow) {
      e_st.site = &q_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (ixstart = 0; ixstart + 1 <= P->size[1]; ixstart++) {
      b_ix = ixstart * n;
      d_st.site = &hb_emlrtRSI;
      ix = ixstart * n + 1;
      ixstop = b_ix + n;
      mtmp = P->data[b_ix];
      if (n > 1) {
        if (muDoubleScalarIsNaN(P->data[b_ix])) {
          e_st.site = &fb_emlrtRSI;
          if ((!(ix + 1 > ixstop)) && (ixstop > 2147483646)) {
            f_st.site = &q_emlrtRSI;
            check_forloop_overflow_error(&f_st);
          }

          b_ix = ix;
          exitg2 = false;
          while ((!exitg2) && (b_ix + 1 <= ixstop)) {
            ix = b_ix + 1;
            if (!muDoubleScalarIsNaN(P->data[b_ix])) {
              mtmp = P->data[b_ix];
              exitg2 = true;
            } else {
              b_ix++;
            }
          }
        }

        if (ix < ixstop) {
          e_st.site = &eb_emlrtRSI;
          if ((!(ix + 1 > ixstop)) && (ixstop > 2147483646)) {
            f_st.site = &q_emlrtRSI;
            check_forloop_overflow_error(&f_st);
          }

          while (ix + 1 <= ixstop) {
            if (P->data[ix] > mtmp) {
              mtmp = P->data[ix];
            }

            ix++;
          }
        }
      }

      EP_Phi0->data[ixstart] = mtmp;
    }

    st.site = &k_emlrtRSI;
    b_st.site = &l_emlrtRSI;
    c_st.site = &m_emlrtRSI;
    if ((EP_Phi0->size[1] == 1) || (EP_Phi0->size[1] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (overflow) {
    } else {
      emlrtErrorWithMessageIdR2012b(&c_st, &s_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    if (EP_Phi0->size[1] > 0) {
    } else {
      emlrtErrorWithMessageIdR2012b(&c_st, &t_emlrtRTEI,
        "Coder:toolbox:eml_min_or_max_varDimZero", 0);
    }

    d_st.site = &db_emlrtRSI;
    ixstart = 1;
    n = EP_Phi0->size[1];
    mtmp = EP_Phi0->data[0];
    if (EP_Phi0->size[1] > 1) {
      if (muDoubleScalarIsNaN(EP_Phi0->data[0])) {
        e_st.site = &fb_emlrtRSI;
        overflow = (EP_Phi0->size[1] > 2147483646);
        if (overflow) {
          f_st.site = &q_emlrtRSI;
          check_forloop_overflow_error(&f_st);
        }

        b_ix = 2;
        exitg1 = false;
        while ((!exitg1) && (b_ix <= n)) {
          ixstart = b_ix;
          if (!muDoubleScalarIsNaN(EP_Phi0->data[b_ix - 1])) {
            mtmp = EP_Phi0->data[b_ix - 1];
            exitg1 = true;
          } else {
            b_ix++;
          }
        }
      }

      if (ixstart < EP_Phi0->size[1]) {
        e_st.site = &eb_emlrtRSI;
        overflow = ((!(ixstart + 1 > EP_Phi0->size[1])) && (EP_Phi0->size[1] >
          2147483646));
        if (overflow) {
          f_st.site = &q_emlrtRSI;
          check_forloop_overflow_error(&f_st);
        }

        while (ixstart + 1 <= n) {
          if (EP_Phi0->data[ixstart] > mtmp) {
            mtmp = EP_Phi0->data[ixstart];
          }

          ixstart++;
        }
      }
    }

    tol = mtmp;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&b_EP);
  emxFree_real_T(&z);
  emxFree_int32_T(&r2);
  emxFree_real_T(&max_EP_Phi0);
  emxFree_real_T(&EP_Phi0);
  emxFree_real_T(&EP);
  emxFree_real_T(&P);
  emxFree_real_T(&Obj_Pre);
  emxFree_real_T(&igp_star);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (solvePareto.cpp) */
