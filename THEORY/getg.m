function g_discrete = getg(wStar,aalpha,phi_d_fun,phi_lim,phi_e)
  globalDeclaration;
  Eprof = calcExpectedProf(wStar,aalpha,phi_d_fun);
  
  switch whichCommitment
    case{'perfect'}
      limitIntegral = phi_e;
    case{'limited'}
      limitIntegral = phi_lim;
  end
  g_discrete = getGFunc(limitIntegral,phi_vec,BETA,Eprof);
end
function g_discrete = getGFunc(limitIntegral,phi_vec,BETA,Eprof)
  g_discrete = zeros(size(phi_vec));
  g_discrete(phi_vec < limitIntegral) = BETA*Eprof;
  g_discrete(phi_vec >= limitIntegral) = BETA*Eprof*(1+BETA);
  g_discrete = sum(g_discrete)/length(phi_vec);
end
