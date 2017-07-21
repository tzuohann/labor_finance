function UMax = getUMax(aalpha,phi_e,phi_db,phi_d_fun)
  globalDeclaration
  wStarMax  = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  period    = 2;
  phi_lim   = getPhiLim_Discrete(phi_d_fun,phi_db,wStarMax,phi_e,aalpha);
  E2Max     = calcExpectedUtil(period,wStarMax,phi_db,phi_e,phi_d_fun,...
    aalpha,phi_lim);
  period    = 3;
  E3Max     = calcExpectedUtil(period,wStarMax,phi_db,phi_e,phi_d_fun,...
              aalpha,phi_lim);
  
  UMax = utilFunc(b,ssigma,1) + BETA*E2Max + BETA^2*E3Max;
end