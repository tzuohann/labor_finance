function g_discrete    = getGdiscrete(limitIntegral,wStar,output,BETA,whichE3,Lifetime_Achievement_Award)
  Eprof         = calcExpectedProf(wStar,output);
  switch whichE3
    case{'endogenous'}
      g_discrete          = limitIntegral * (BETA*Eprof) + (1 - limitIntegral) * BETA*Eprof*(1+BETA);
    case{'exogenous'}
      g_discrete          = limitIntegral * (BETA*Eprof) + (1 - limitIntegral) * (BETA*Eprof + BETA^2*Lifetime_Achievement_Award);
  end
  end