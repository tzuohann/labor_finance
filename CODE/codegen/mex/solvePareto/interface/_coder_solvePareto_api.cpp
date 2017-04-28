/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_solvePareto_api.cpp
 *
 * Code generation for function '_coder_solvePareto_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "_coder_solvePareto_api.h"
#include "solvePareto_emxutil.h"
#include "solvePareto_data.h"
#include "blas.h"

/* Variable Definitions */
static emlrtRTEInfo l_emlrtRTEI = { 1, 1, "_coder_solvePareto_api", "" };

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static const mxArray *b_emlrt_marshallOut(const real_T u);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *sep_pol,
  const char_T *identifier, boolean_T **y_data, int32_T y_size[1]);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, boolean_T **y_data, int32_T y_size[1]);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *pi_Phi,
  const char_T *identifier, emxArray_real_T *y);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *CV_tol,
  const char_T *identifier);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *Phi_grid,
  const char_T *identifier, real_T **y_data, int32_T y_size[1]);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[1]);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *gamma_vect,
  const char_T *identifier, real_T **y_data, int32_T y_size[2]);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[2]);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *w_star_pre,
  const char_T *identifier, emxArray_real_T *y);
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, boolean_T **ret_data, int32_T ret_size[1]);
static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[1]);
static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[2]);
static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);

/* Function Definitions */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = m_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *b_emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m3;
  y = NULL;
  m3 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m3);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *sep_pol,
  const char_T *identifier, boolean_T **y_data, int32_T y_size[1])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(sep_pol), &thisId, y_data, y_size);
  emlrtDestroyArray(&sep_pol);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, boolean_T **y_data, int32_T y_size[1])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *pi_Phi,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(pi_Phi), &thisId, y);
  emlrtDestroyArray(&pi_Phi);
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *CV_tol,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(CV_tol), &thisId);
  emlrtDestroyArray(&CV_tol);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m2;
  static const int32_T iv5[2] = { 0, 0 };

  y = NULL;
  m2 = emlrtCreateNumericArray(2, iv5, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m2, (void *)u->data);
  emlrtSetDimensions((mxArray *)m2, u->size, 2);
  emlrtAssign(&y, m2);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  o_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *Phi_grid,
  const char_T *identifier, real_T **y_data, int32_T y_size[1])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  h_emlrt_marshallIn(sp, emlrtAlias(Phi_grid), &thisId, y_data, y_size);
  emlrtDestroyArray(&Phi_grid);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[1])
{
  p_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *gamma_vect,
  const char_T *identifier, real_T **y_data, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  j_emlrt_marshallIn(sp, emlrtAlias(gamma_vect), &thisId, y_data, y_size);
  emlrtDestroyArray(&gamma_vect);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[2])
{
  q_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *w_star_pre,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  l_emlrt_marshallIn(sp, emlrtAlias(w_star_pre), &thisId, y);
  emlrtDestroyArray(&w_star_pre);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  r_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, boolean_T **ret_data, int32_T ret_size[1])
{
  static const int32_T dims[1] = { 200 };

  boolean_T bv0[1] = { true };

  int32_T iv6[1];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "logical", false, 1U, dims, &bv0[0],
    iv6);
  ret_size[0] = iv6[0];
  *ret_data = (boolean_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 200, 200 };

  boolean_T bv1[2] = { true, true };

  int32_T iv7[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv1[0],
    iv7);
  ret->size[0] = iv7[0];
  ret->size[1] = iv7[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[1])
{
  static const int32_T dims[1] = { 200 };

  boolean_T bv2[1] = { true };

  int32_T iv8[1];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv2[0],
    iv8);
  ret_size[0] = iv8[0];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[2])
{
  static const int32_T dims[2] = { 1, 5000 };

  boolean_T bv3[2] = { false, true };

  int32_T iv9[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv3[0],
    iv9);
  ret_size[0] = iv9[0];
  ret_size[1] = iv9[1];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 200, 5000 };

  boolean_T bv4[2] = { true, true };

  int32_T iv10[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv4[0],
    iv10);
  ret->size[0] = iv10[0];
  ret->size[1] = iv10[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void solvePareto_api(const mxArray * const prhs[18], const mxArray *plhs[4])
{
  emxArray_real_T *pi_Phi;
  emxArray_real_T *w_star_pre;
  emxArray_real_T *w_star_pre_cons;
  emxArray_real_T *TP;
  emxArray_real_T *gp_star;
  emxArray_real_T *w_star_v;
  real_T CV_tol;
  real_T Niter;
  real_T nPhi;
  real_T nG;
  boolean_T (*sep_pol_data)[200];
  int32_T sep_pol_size[1];
  real_T sigma;
  real_T (*Phi_grid_data)[200];
  int32_T Phi_grid_size[1];
  real_T BETA;
  real_T (*gamma_vect_data)[5000];
  int32_T gamma_vect_size[2];
  real_T U;
  real_T pi_z;
  real_T r;
  real_T K;
  real_T D;
  real_T tau;
  real_T EU_vect;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &pi_Phi, 2, &l_emlrtRTEI, true);
  emxInit_real_T(&st, &w_star_pre, 2, &l_emlrtRTEI, true);
  emxInit_real_T(&st, &w_star_pre_cons, 2, &l_emlrtRTEI, true);
  emxInit_real_T(&st, &TP, 2, &l_emlrtRTEI, true);
  emxInit_real_T(&st, &gp_star, 2, &l_emlrtRTEI, true);
  emxInit_real_T(&st, &w_star_v, 2, &l_emlrtRTEI, true);

  /* Marshall function inputs */
  CV_tol = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[0]), "CV_tol");
  Niter = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[1]), "Niter");
  nPhi = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[2]), "nPhi");
  nG = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[3]), "nG");
  c_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[4]), "sep_pol",
                     (boolean_T **)&sep_pol_data, sep_pol_size);
  sigma = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[5]), "sigma");
  e_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[6]), "pi_Phi", pi_Phi);
  g_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[7]), "Phi_grid",
                     (real_T **)&Phi_grid_data, Phi_grid_size);
  BETA = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[8]), "BETA");
  i_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[9]), "gamma_vect",
                     (real_T **)&gamma_vect_data, gamma_vect_size);
  k_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[10]), "w_star_pre",
                     w_star_pre);
  U = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[11]), "U");
  pi_z = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[12]), "pi_z");
  r = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[13]), "r");
  K = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[14]), "K");
  D = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[15]), "D");
  tau = emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[16]), "tau");
  k_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[17]),
                     "w_star_pre_cons", w_star_pre_cons);

  /* Invoke the target function */
  solvePareto(&st, CV_tol, Niter, nPhi, nG, *sep_pol_data, sep_pol_size, sigma,
              pi_Phi, *Phi_grid_data, Phi_grid_size, BETA, *gamma_vect_data,
              gamma_vect_size, w_star_pre, U, pi_z, r, K, D, tau,
              w_star_pre_cons, TP, gp_star, w_star_v, &EU_vect);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(TP);
  plhs[1] = emlrt_marshallOut(gp_star);
  plhs[2] = emlrt_marshallOut(w_star_v);
  plhs[3] = b_emlrt_marshallOut(EU_vect);
  w_star_v->canFreeData = false;
  emxFree_real_T(&w_star_v);
  gp_star->canFreeData = false;
  emxFree_real_T(&gp_star);
  TP->canFreeData = false;
  emxFree_real_T(&TP);
  w_star_pre_cons->canFreeData = false;
  emxFree_real_T(&w_star_pre_cons);
  w_star_pre->canFreeData = false;
  emxFree_real_T(&w_star_pre);
  pi_Phi->canFreeData = false;
  emxFree_real_T(&pi_Phi);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_solvePareto_api.cpp) */
