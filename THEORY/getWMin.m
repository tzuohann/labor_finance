function wMin = getWMin(Utarget,phi_d_fun,phi_db,phi_e,aalpha)
  globalDeclaration
  wstarmax = prodFn(R,max(phi_vec),aalpha,r,prod_func_type);
  wstarmin = b;
  options = optimoptions('fmincon','Display','None');
  wMin = fmincon(@(wStar) (getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,whichCommitment,b,phi_vec,ssigma,BETA) - Utarget).^2,(wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);
end

function U = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,whichCommitment,b,phi_vec,ssigma,BETA)
  %Calculate U for a given WStar
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
  U             = utilFunc(b,ssigma,1) + BETA*E2_discrete + BETA^2*(limitIntegral*utilFunc(b,ssigma,1) + (1-limitIntegral)*E3_discrete);
end