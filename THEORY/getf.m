function f_discrete = getf(wStar,phi_db,phi_e,phi_d_fun,aalpha,U_given)
  globalDeclaration
  
  phi_lim       = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,aalpha);
  
  period        = 2;
  E2_discrete   = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
  period        = 3;
  E3_discrete   = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
  den_discrete  = 0;
  
  switch whichCommitment
    case{'perfect'}
      limitIntegral = phi_e;
    case{'limited'}
      limitIntegral = phi_lim;
  end
  f_discrete = getFdiscrete(limitIntegral,phi_vec,BETA,E2_discrete,b,ssigma,E3_discrete,U_given);
  
  %Only difference between LC and PC is the limit of the integral which is
  %the point at which the worker leaves the firm for unemployment.
end

function f_discrete = getFdiscrete(limitIntegral,phi_vec,BETA,E2_discrete,b,ssigma,E3_discrete,U_given)
  den_discrete                            = zeros(size(phi_vec));
  den_discrete(phi_vec < limitIntegral)   = (BETA*(E2_discrete + BETA*utilFunc(b,ssigma,1) - (1+BETA)*utilFunc(b,ssigma,1)));
  den_discrete(phi_vec >= limitIntegral)  = (BETA*(E2_discrete + BETA*E3_discrete - (1+BETA)*utilFunc(b,ssigma,1)));
  den_discrete                            = sum(den_discrete)/length(phi_vec);
  f_discrete                              = (U_given - (1+BETA+BETA^2)*utilFunc(b,ssigma,1))/den_discrete;
end