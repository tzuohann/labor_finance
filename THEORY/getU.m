function U  = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,...
        whichCommitment,b,phi_vec,ssigma,BETA,ptheta)
  %globalDeclaration
  %Calculate U ASSUMING that probabily of finding a job is ptheta
  phi_lim       = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,aalpha);
  period        = 2;
  E2_discrete   = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
  period        = 3;
  E3_discrete   = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
  switch whichCommitment
    case {'perfect'}
      limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
    case{'limited'}
      limitIntegral = sum(phi_vec < phi_lim)./numel(phi_vec);
    otherwise
      error('Perfect or Limited for now')
  end
  U             = utilFunc(b,ssigma,1) ...
    + ptheta*(BETA*E2_discrete ...
    + BETA^2*(limitIntegral*utilFunc(b,ssigma,1) ...
    + (1-limitIntegral)*E3_discrete)) ...
    + (1-ptheta)*(BETA + BETA^2)*utilFunc(b,ssigma,1);
end