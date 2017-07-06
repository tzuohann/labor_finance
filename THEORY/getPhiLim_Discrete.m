function phi_lim = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,alpha)
  globalDeclaration
  
  %Critical values of phi
  phi_dw       = phi_d_fun(wStar);
  
  %Value of employment in the third period
  period = 3;
  E3 = 0;
  for ip = 1:length(phi_vec)
    phi           = phi_vec(ip);
    output        = prodFn(R,phi,alpha,r);
    consumption   = getWage(phi,phi_dw,phi_db,phi_e,[],output,period,wStar);
    E3            = E3 + utilFunc(consumption,ssigma,1);
  end
  E3 = E3/length(phi_vec);
  
  %Limited commitment threshold. Below phi_lim workers prefers to break the matc
  
  phi_lim = ((1-ssigma)*(1+BETA)*utilFunc(b,ssigma,1) - BETA*E3)^(1/(1-ssigma)) - R + r*alpha;
end