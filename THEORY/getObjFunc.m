function objective = getObjFunc(wStar,params,aalpha,phi_e,output,U_given,phi_db)
  
  phi_cutoff    = getPhiCutoff(params,aalpha,phi_e,wStar,output,phi_db);
  limitIntegral = getContinuationProb(phi_cutoff,params.phi_vec);
  E2_discrete   = calcExpectedUtil(params,output,phi_cutoff,wStar);
  E3_discrete   = getE3(params,wStar,output,aalpha,phi_db);
  f_discrete    = getFdiscrete(limitIntegral,params.phi_vec,params.BETA,...
      E2_discrete,params.b,E3_discrete,U_given,params.utilFunc);
  g_discrete    = getGdiscrete(limitIntegral,wStar,output,params.BETA,...
      params.whichE3,params.Lifetime_Achievement_Award);

  objective     = -((1 - f_discrete.^params.gamma_matching).^(1/params.gamma_matching).*...
      g_discrete);
end