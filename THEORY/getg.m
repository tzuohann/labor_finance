function g_discrete = getg(params,wStar,aalpha,output,phi_e,phi_db)
  Eprof = calcExpectedProf(wStar,output);
  phi_cutoff    = getPhiCutoff(params,aalpha,phi_e,wStar,output,phi_db);
  limitIntegral = getContinuationProb(phi_cutoff,params.phi_vec);
  switch params.whichCommitment
    case{'perfect'}
      limitIntegral = phi_e;
    case{'limited'}
      limitIntegral = phi_cutoff;
  end
  g_discrete    = getGdiscrete(limitIntegral,wStar,output,params.BETA,...
      params.whichE3,params.Lifetime_Achievement_Award);
end
