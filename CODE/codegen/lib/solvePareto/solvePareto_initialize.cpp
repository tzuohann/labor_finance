/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * solvePareto_initialize.cpp
 *
 * Code generation for function 'solvePareto_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "solvePareto.h"
#include "solvePareto_initialize.h"
#include "eml_rand_mt19937ar_stateful.h"

/* Function Definitions */
void solvePareto_initialize()
{
  rt_InitInfAndNaN(8U);
  c_eml_rand_mt19937ar_stateful_i();
}

/* End of code generation (solvePareto_initialize.cpp) */
