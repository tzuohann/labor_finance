/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.cpp
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "main.h"
#include "solvePareto_terminate.h"
#include "solvePareto_emxAPI.h"
#include "solvePareto_initialize.h"

/* Function Declarations */
static void argInit_1xd5000_real_T(double result_data[], int result_size[2]);
static boolean_T argInit_boolean_T();
static void argInit_d200x1_boolean_T(boolean_T result_data[], int result_size[1]);
static void argInit_d200x1_real_T(double result_data[], int result_size[1]);
static emxArray_real_T *argInit_d200xd200_real_T();
static emxArray_real_T *argInit_d200xd5000_real_T();
static double argInit_real_T();
static void main_solvePareto();

/* Function Definitions */
static void argInit_1xd5000_real_T(double result_data[], int result_size[2])
{
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result_size[0] = 1;
  result_size[1] = 2;

  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 2; idx1++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result_data[idx1] = argInit_real_T();
  }
}

static boolean_T argInit_boolean_T()
{
  return false;
}

static void argInit_d200x1_boolean_T(boolean_T result_data[], int result_size[1])
{
  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result_size[0] = 2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result_data[idx0] = argInit_boolean_T();
  }
}

static void argInit_d200x1_real_T(double result_data[], int result_size[1])
{
  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result_size[0] = 2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result_data[idx0] = argInit_real_T();
  }
}

static emxArray_real_T *argInit_d200xd200_real_T()
{
  emxArray_real_T *result;
  static int iv0[2] = { 2, 2 };

  int idx0;
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_real_T(2, *(int (*)[2])&iv0[0]);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    for (idx1 = 0; idx1 < result->size[1U]; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result->data[idx0 + result->size[0] * idx1] = argInit_real_T();
    }
  }

  return result;
}

static emxArray_real_T *argInit_d200xd5000_real_T()
{
  emxArray_real_T *result;
  static int iv1[2] = { 2, 2 };

  int idx0;
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_real_T(2, *(int (*)[2])&iv1[0]);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    for (idx1 = 0; idx1 < result->size[1U]; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result->data[idx0 + result->size[0] * idx1] = argInit_real_T();
    }
  }

  return result;
}

static double argInit_real_T()
{
  return 0.0;
}

static void main_solvePareto()
{
  emxArray_real_T *TP;
  emxArray_real_T *gp_star;
  emxArray_real_T *w_star_v;
  double CV_tol;
  double Niter;
  double nPhi;
  double nG;
  boolean_T sep_pol_data[200];
  int sep_pol_size[1];
  double sigma;
  emxArray_real_T *pi_Phi;
  double Phi_grid_data[200];
  int Phi_grid_size[1];
  double BETA;
  double gamma_vect_data[5000];
  int gamma_vect_size[2];
  emxArray_real_T *w_star_pre;
  double U;
  double pi_z;
  double r;
  double K;
  double D;
  double tau;
  emxArray_real_T *w_star_pre_cons;
  double EU_vect;
  emxInitArray_real_T(&TP, 2);
  emxInitArray_real_T(&gp_star, 2);
  emxInitArray_real_T(&w_star_v, 2);

  /* Initialize function 'solvePareto' input arguments. */
  CV_tol = argInit_real_T();
  Niter = argInit_real_T();
  nPhi = argInit_real_T();
  nG = argInit_real_T();

  /* Initialize function input argument 'sep_pol'. */
  argInit_d200x1_boolean_T(sep_pol_data, sep_pol_size);
  sigma = argInit_real_T();

  /* Initialize function input argument 'pi_Phi'. */
  pi_Phi = argInit_d200xd200_real_T();

  /* Initialize function input argument 'Phi_grid'. */
  argInit_d200x1_real_T(Phi_grid_data, Phi_grid_size);
  BETA = argInit_real_T();

  /* Initialize function input argument 'gamma_vect'. */
  argInit_1xd5000_real_T(gamma_vect_data, gamma_vect_size);

  /* Initialize function input argument 'w_star_pre'. */
  w_star_pre = argInit_d200xd5000_real_T();
  U = argInit_real_T();
  pi_z = argInit_real_T();
  r = argInit_real_T();
  K = argInit_real_T();
  D = argInit_real_T();
  tau = argInit_real_T();

  /* Initialize function input argument 'w_star_pre_cons'. */
  w_star_pre_cons = argInit_d200xd5000_real_T();

  /* Call the entry-point 'solvePareto'. */
  solvePareto(CV_tol, Niter, nPhi, nG, sep_pol_data, sep_pol_size, sigma, pi_Phi,
              Phi_grid_data, Phi_grid_size, BETA, gamma_vect_data,
              gamma_vect_size, w_star_pre, U, pi_z, r, K, D, tau,
              w_star_pre_cons, TP, gp_star, w_star_v, &EU_vect);
  emxDestroyArray_real_T(w_star_v);
  emxDestroyArray_real_T(gp_star);
  emxDestroyArray_real_T(TP);
  emxDestroyArray_real_T(w_star_pre_cons);
  emxDestroyArray_real_T(w_star_pre);
  emxDestroyArray_real_T(pi_Phi);
}

int main(int, const char * const [])
{
  /* Initialize the application.
     You do not need to do this more than one time. */
  solvePareto_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_solvePareto();

  /* Terminate the application.
     You do not need to do this more than one time. */
  solvePareto_terminate();
  return 0;
}

/* End of code generation (main.cpp) */
