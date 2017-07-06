function phi_lim = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,alpha)
  globalDeclaration
  
  %Critical values of phi
  phi_dw          = phi_d_fun(wStar);
  
  %Expected value of employment in the third period
  period          = 3;
  E3 = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,alpha,[]);
  
  phi_lim = ((1-ssigma)*((1+BETA)*utilFunc(b,ssigma,1) - BETA*E3))^(1/(1-ssigma)) - R + r*alpha;
end