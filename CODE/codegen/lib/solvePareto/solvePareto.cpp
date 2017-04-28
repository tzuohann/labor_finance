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
#include "solvePareto_emxutil.h"
#include "rand.h"
#include "squeeze.h"
#include "repmat.h"

/* Function Definitions */
void solvePareto(double CV_tol, double Niter, double nPhi, double nG, const
                 boolean_T sep_pol_data[], const int sep_pol_size[1], double
                 sigma, const emxArray_real_T *pi_Phi, const double
                 Phi_grid_data[], const int Phi_grid_size[1], double BETA, const
                 double gamma_vect_data[], const int gamma_vect_size[2], const
                 emxArray_real_T *w_star_pre, double U, double pi_z, double r,
                 double K, double D, double tau, const emxArray_real_T
                 *w_star_pre_cons, emxArray_real_T *TP, emxArray_real_T *gp_star,
                 emxArray_real_T *w_star_v, double *EU_vect)
{
  int i0;
  int cr;
  double U2_data[200];
  int k;
  double mtmp;
  int EsigU_size[1];
  unsigned char pi_Phi_idx_0;
  int m;
  double EsigU_data[200];
  emxArray_real_T *P;
  int ar;
  emxArray_real_T *a;
  int ia;
  double b_EsigU_data;
  int br;
  int n;
  emxArray_real_T *r0;
  boolean_T p;
  emxArray_real_T *Obj_Pre;
  double tol;
  double Iter;
  emxArray_real_T *EP;
  emxArray_real_T *EP_Phi0;
  emxArray_real_T *max_EP_Phi0;
  emxArray_real_T *b_EP;
  int ig;
  int iphi;
  double P2_data[200];
  int EP0_size_idx_0;
  double EP0_data[200];
  double b_EP0_data;
  boolean_T exitg1;
  boolean_T exitg2;
  boolean_T exitg3;
  i0 = gp_star->size[0] * gp_star->size[1];
  gp_star->size[0] = (int)nPhi;
  gp_star->size[1] = (int)nG;
  emxEnsureCapacity((emxArray__common *)gp_star, i0, (int)sizeof(double));
  cr = (int)nPhi * (int)nG;
  for (i0 = 0; i0 < cr; i0++) {
    gp_star->data[i0] = rtNaN;
  }

  i0 = w_star_v->size[0] * w_star_v->size[1];
  w_star_v->size[0] = (int)nPhi;
  w_star_v->size[1] = (int)nG;
  emxEnsureCapacity((emxArray__common *)w_star_v, i0, (int)sizeof(double));
  cr = (int)nPhi * (int)nG;
  for (i0 = 0; i0 < cr; i0++) {
    w_star_v->data[i0] = rtNaN;
  }

  i0 = TP->size[0] * TP->size[1];
  TP->size[0] = (int)nPhi;
  TP->size[1] = (int)nG;
  emxEnsureCapacity((emxArray__common *)TP, i0, (int)sizeof(double));
  cr = (int)nPhi * (int)nG;
  for (i0 = 0; i0 < cr; i0++) {
    TP->data[i0] = 0.0;
  }

  *EU_vect = pi_z * U;
  for (k = 0; k + 1 <= (unsigned char)sep_pol_size[0]; k++) {
    if (((double)sep_pol_data[k] > sigma) || rtIsNaN(sigma)) {
      mtmp = sep_pol_data[k];
    } else {
      mtmp = sigma;
    }

    U2_data[k] = mtmp;
  }

  cr = (unsigned char)sep_pol_size[0];
  for (i0 = 0; i0 < cr; i0++) {
    U2_data[i0] *= U;
  }

  /* EsigU  = pi_z*U2(:);  % mistake here.. */
  if ((pi_Phi->size[1] == 1) || ((unsigned char)sep_pol_size[0] == 1)) {
    EsigU_size[0] = pi_Phi->size[0];
    cr = pi_Phi->size[0];
    for (i0 = 0; i0 < cr; i0++) {
      EsigU_data[i0] = 0.0;
      ar = pi_Phi->size[1];
      for (ia = 0; ia < ar; ia++) {
        b_EsigU_data = EsigU_data[i0] + pi_Phi->data[i0 + pi_Phi->size[0] * ia] *
          U2_data[ia];
        EsigU_data[i0] = b_EsigU_data;
      }
    }
  } else {
    k = pi_Phi->size[1];
    pi_Phi_idx_0 = (unsigned char)pi_Phi->size[0];
    m = pi_Phi->size[0];
    cr = pi_Phi_idx_0;
    EsigU_size[0] = pi_Phi_idx_0;
    for (i0 = 0; i0 < cr; i0++) {
      EsigU_data[i0] = 0.0;
    }

    if (pi_Phi->size[0] == 0) {
    } else {
      cr = 0;
      while ((m > 0) && (cr <= 0)) {
        for (n = 1; n <= m; n++) {
          EsigU_data[n - 1] = 0.0;
        }

        cr = m;
      }

      br = 0;
      cr = 0;
      while ((m > 0) && (cr <= 0)) {
        ar = 0;
        i0 = br + k;
        for (cr = br; cr + 1 <= i0; cr++) {
          if (U2_data[cr] != 0.0) {
            ia = ar;
            for (n = 0; n + 1 <= m; n++) {
              ia++;
              EsigU_data[n] += U2_data[cr] * pi_Phi->data[ia - 1];
            }
          }

          ar += m;
        }

        br += k;
        cr = m;
      }
    }
  }

  emxInit_real_T(&P, 2);
  emxInit_real_T(&a, 2);

  /* %%%%%should be W0, not U0%%%%%%%%%%% */
  repmat(EsigU_data, EsigU_size, nG, a);
  i0 = P->size[0] * P->size[1];
  P->size[0] = a->size[0];
  P->size[1] = a->size[1];
  emxEnsureCapacity((emxArray__common *)P, i0, (int)sizeof(double));
  cr = a->size[0] * a->size[1];
  for (i0 = 0; i0 < cr; i0++) {
    P->data[i0] = a->data[i0];
  }

  emxInit_real_T(&r0, 2);
  i0 = r0->size[0] * r0->size[1];
  r0->size[0] = (int)nPhi;
  r0->size[1] = gamma_vect_size[1];
  emxEnsureCapacity((emxArray__common *)r0, i0, (int)sizeof(double));
  if (!(gamma_vect_size[1] == 0)) {
    if ((int)nPhi == 0) {
      p = true;
    } else if (gamma_vect_size[1] == 0) {
      p = true;
    } else {
      p = false;
    }

    if (!p) {
      for (cr = 0; cr + 1 <= gamma_vect_size[1]; cr++) {
        ia = cr * (int)nPhi;
        for (ar = 1; ar <= (int)nPhi; ar++) {
          r0->data[(ia + ar) - 1] = gamma_vect_data[cr];
        }
      }
    }
  }

  repmat(Phi_grid_data, Phi_grid_size, nG, a);
  i0 = a->size[0] * a->size[1];
  emxEnsureCapacity((emxArray__common *)a, i0, (int)sizeof(double));
  cr = a->size[0];
  ia = a->size[1];
  mtmp = D * r;
  cr *= ia;
  for (i0 = 0; i0 < cr; i0++) {
    a->data[i0] -= mtmp;
  }

  emxInit_real_T(&Obj_Pre, 2);
  i0 = Obj_Pre->size[0] * Obj_Pre->size[1];
  Obj_Pre->size[0] = a->size[0];
  Obj_Pre->size[1] = a->size[1];
  emxEnsureCapacity((emxArray__common *)Obj_Pre, i0, (int)sizeof(double));
  mtmp = r * K;
  cr = a->size[0] * a->size[1];
  for (i0 = 0; i0 < cr; i0++) {
    Obj_Pre->data[i0] = ((mtmp + a->data[i0] * (1.0 - tau)) + r0->data[i0] *
                         (w_star_pre_cons->data[i0] + BETA * P->data[i0])) -
      w_star_pre->data[i0] * (1.0 - tau);
  }

  emxFree_real_T(&a);
  emxFree_real_T(&r0);
  tol = 1.0;
  Iter = 0.0;
  emxInit_real_T(&EP, 2);
  emxInit_real_T(&EP_Phi0, 2);
  emxInit_real_T(&max_EP_Phi0, 2);
  emxInit_real_T(&b_EP, 2);
  while ((tol > CV_tol) && (Iter < Niter)) {
    Iter++;
    i0 = P->size[0] * P->size[1];
    P->size[0] = TP->size[0];
    P->size[1] = TP->size[1];
    emxEnsureCapacity((emxArray__common *)P, i0, (int)sizeof(double));
    cr = TP->size[0] * TP->size[1];
    for (i0 = 0; i0 < cr; i0++) {
      P->data[i0] = TP->data[i0];
    }

    /*  computing expectations */
    i0 = EP->size[0] * EP->size[1];
    EP->size[0] = (int)nPhi;
    EP->size[1] = (int)nG;
    emxEnsureCapacity((emxArray__common *)EP, i0, (int)sizeof(double));
    cr = (int)nPhi * (int)nG;
    for (i0 = 0; i0 < cr; i0++) {
      EP->data[i0] = 0.0;
    }

    for (ig = 0; ig < (int)nG; ig++) {
      for (k = 0; k + 1 <= (unsigned char)sep_pol_size[0]; k++) {
        if (((double)sep_pol_data[k] > sigma) || rtIsNaN(sigma)) {
          mtmp = sep_pol_data[k];
        } else {
          mtmp = sigma;
        }

        U2_data[k] = mtmp;
      }

      cr = (unsigned char)sep_pol_size[0];
      for (i0 = 0; i0 < cr; i0++) {
        P2_data[i0] = (1.0 - U2_data[i0]) * TP->data[i0 + TP->size[0] * ig];
      }

      /*   + max(sep_pol,sigma)*(K-D); %% testing with K-D */
      if ((pi_Phi->size[1] == 1) || ((unsigned char)sep_pol_size[0] == 1)) {
        EP0_size_idx_0 = pi_Phi->size[0];
        cr = pi_Phi->size[0];
        for (i0 = 0; i0 < cr; i0++) {
          EP0_data[i0] = 0.0;
          ar = pi_Phi->size[1];
          for (ia = 0; ia < ar; ia++) {
            b_EP0_data = EP0_data[i0] + pi_Phi->data[i0 + pi_Phi->size[0] * ia] *
              P2_data[ia];
            EP0_data[i0] = b_EP0_data;
          }
        }
      } else {
        k = pi_Phi->size[1];
        pi_Phi_idx_0 = (unsigned char)pi_Phi->size[0];
        m = pi_Phi->size[0];
        ar = pi_Phi_idx_0;
        EP0_size_idx_0 = pi_Phi_idx_0;
        for (i0 = 0; i0 < ar; i0++) {
          EP0_data[i0] = 0.0;
        }

        if (pi_Phi->size[0] == 0) {
        } else {
          cr = 0;
          while ((m > 0) && (cr <= 0)) {
            for (n = 1; n <= m; n++) {
              EP0_data[n - 1] = 0.0;
            }

            cr = m;
          }

          br = 0;
          cr = 0;
          while ((m > 0) && (cr <= 0)) {
            ar = 0;
            i0 = br + k;
            for (cr = br; cr + 1 <= i0; cr++) {
              if (P2_data[cr] != 0.0) {
                ia = ar;
                for (n = 0; n + 1 <= m; n++) {
                  ia++;
                  EP0_data[n] += P2_data[cr] * pi_Phi->data[ia - 1];
                }
              }

              ar += m;
            }

            br += k;
            cr = m;
          }
        }
      }

      /*  this one includes separation */
      for (i0 = 0; i0 < EP0_size_idx_0; i0++) {
        EP->data[i0 + EP->size[0] * ig] = EP0_data[i0];
      }
    }

    for (iphi = 0; iphi < (int)nPhi; iphi++) {
      cr = EP->size[1];
      i0 = b_EP->size[0] * b_EP->size[1];
      b_EP->size[0] = 1;
      b_EP->size[1] = cr;
      emxEnsureCapacity((emxArray__common *)b_EP, i0, (int)sizeof(double));
      for (i0 = 0; i0 < cr; i0++) {
        b_EP->data[b_EP->size[0] * i0] = EP->data[iphi + EP->size[0] * i0];
      }

      squeeze(b_EP, EP_Phi0);
      cr = EP_Phi0->size[1];
      i0 = max_EP_Phi0->size[0] * max_EP_Phi0->size[1];
      max_EP_Phi0->size[0] = 1;
      max_EP_Phi0->size[1] = EP_Phi0->size[1];
      emxEnsureCapacity((emxArray__common *)max_EP_Phi0, i0, (int)sizeof(double));
      for (k = 0; k + 1 <= cr; k++) {
        if (EP_Phi0->data[k] >= 0.0) {
          mtmp = EP_Phi0->data[k];
        } else {
          mtmp = 0.0;
        }

        max_EP_Phi0->data[k] = mtmp;
      }

      if ((int)sep_pol_data[iphi] < 1) {
        /*  as long as there is no separation */
        /* This is the slow part. Make this faster. */
        for (ig = 0; ig < (int)nG; ig++) {
          /* Maximize more frequently as we get closer to the solution */
          b_rand();

          /* max(CV_tol/tol,0.5) */
          if (1.0 + (double)ig > nG) {
            i0 = 1;
            ia = 0;
          } else {
            i0 = ig + 1;
            ia = (int)nG;
          }

          cr = EP_Phi0->size[0] * EP_Phi0->size[1];
          EP_Phi0->size[0] = 1;
          EP_Phi0->size[1] = (ia - i0) + 1;
          emxEnsureCapacity((emxArray__common *)EP_Phi0, cr, (int)sizeof(double));
          cr = (ia - i0) + 1;
          for (ia = 0; ia < cr; ia++) {
            EP_Phi0->data[EP_Phi0->size[0] * ia] = BETA * max_EP_Phi0->data[(i0
              + ia) - 1];
          }

          ia = 1;
          n = EP_Phi0->size[1];
          mtmp = EP_Phi0->data[0];
          ar = 1;
          if (EP_Phi0->size[1] > 1) {
            if (rtIsNaN(EP_Phi0->data[0])) {
              br = 2;
              exitg3 = false;
              while ((!exitg3) && (br <= n)) {
                ia = br;
                if (!rtIsNaN(EP_Phi0->data[br - 1])) {
                  mtmp = EP_Phi0->data[br - 1];
                  ar = br;
                  exitg3 = true;
                } else {
                  br++;
                }
              }
            }

            if (ia < EP_Phi0->size[1]) {
              while (ia + 1 <= n) {
                if (EP_Phi0->data[ia] < mtmp) {
                  mtmp = EP_Phi0->data[ia];
                  ar = ia + 1;
                }

                ia++;
              }
            }
          }

          gp_star->data[iphi + gp_star->size[0] * ig] = gamma_vect_data[(int)
            (((double)ar + (1.0 + (double)ig)) - 1.0) - 1];
          w_star_v->data[iphi + w_star_v->size[0] * ig] = w_star_pre->data[iphi
            + w_star_pre->size[0] * ig];

          /*  independent of ig */
          TP->data[iphi + TP->size[0] * ig] = mtmp + Obj_Pre->data[iphi +
            Obj_Pre->size[0] * ig];
        }
      }
    }

    i0 = P->size[0] * P->size[1];
    P->size[0] = TP->size[0];
    P->size[1] = TP->size[1];
    emxEnsureCapacity((emxArray__common *)P, i0, (int)sizeof(double));
    cr = TP->size[0] * TP->size[1];
    for (i0 = 0; i0 < cr; i0++) {
      P->data[i0] = (TP->data[i0] - P->data[i0]) * (TP->data[i0] - P->data[i0]);
    }

    i0 = EP_Phi0->size[0] * EP_Phi0->size[1];
    EP_Phi0->size[0] = 1;
    EP_Phi0->size[1] = P->size[1];
    emxEnsureCapacity((emxArray__common *)EP_Phi0, i0, (int)sizeof(double));
    n = P->size[0];
    for (cr = 0; cr + 1 <= P->size[1]; cr++) {
      br = cr * n;
      ar = cr * n + 1;
      ia = br + n;
      mtmp = P->data[br];
      if (n > 1) {
        if (rtIsNaN(P->data[br])) {
          br = ar;
          exitg2 = false;
          while ((!exitg2) && (br + 1 <= ia)) {
            ar = br + 1;
            if (!rtIsNaN(P->data[br])) {
              mtmp = P->data[br];
              exitg2 = true;
            } else {
              br++;
            }
          }
        }

        if (ar < ia) {
          while (ar + 1 <= ia) {
            if (P->data[ar] > mtmp) {
              mtmp = P->data[ar];
            }

            ar++;
          }
        }
      }

      EP_Phi0->data[cr] = mtmp;
    }

    ia = 1;
    n = EP_Phi0->size[1];
    mtmp = EP_Phi0->data[0];
    if (EP_Phi0->size[1] > 1) {
      if (rtIsNaN(EP_Phi0->data[0])) {
        br = 2;
        exitg1 = false;
        while ((!exitg1) && (br <= n)) {
          ia = br;
          if (!rtIsNaN(EP_Phi0->data[br - 1])) {
            mtmp = EP_Phi0->data[br - 1];
            exitg1 = true;
          } else {
            br++;
          }
        }
      }

      if (ia < EP_Phi0->size[1]) {
        while (ia + 1 <= n) {
          if (EP_Phi0->data[ia] > mtmp) {
            mtmp = EP_Phi0->data[ia];
          }

          ia++;
        }
      }
    }

    tol = mtmp;
  }

  emxFree_real_T(&b_EP);
  emxFree_real_T(&max_EP_Phi0);
  emxFree_real_T(&EP_Phi0);
  emxFree_real_T(&EP);
  emxFree_real_T(&P);
  emxFree_real_T(&Obj_Pre);
}

/* End of code generation (solvePareto.cpp) */
