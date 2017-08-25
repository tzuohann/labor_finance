function f_discrete = getf(params,wStar,phi_e,aalpha,U_given,output,phi_db)
  
  phi_cutoff    = getPhiCutoff(params,aalpha,phi_e,wStar,output,phi_db);
  limitIntegral = getContinuationProb(phi_cutoff,params.phi_vec);
  E2_discrete   = calcExpectedUtil(params,output,phi_cutoff,wStar);
  E3_discrete   = getE3(params,wStar,output,aalpha,phi_db);
  f_discrete    = getFdiscrete(limitIntegral,params.phi_vec,params.BETA,...
      E2_discrete,params.b,E3_discrete,U_given,params.utilFunc);
  
  %Only difference between LC and PC is the limit of the integral which is
  %the point at which the worker leaves the firm for unemployment.
end

