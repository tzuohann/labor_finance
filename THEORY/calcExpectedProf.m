function Eprof = calcExpectedProf(wStar,aalpha,phi_d_fun,prod_func_type)
  %Calculate expected profits in a given period given the wStar.
  globalDeclaration;
  
  phi_dw  = phi_d_fun(wStar,aalpha);
  
  Eprof   = zeros(size(phi_vec));
  Eprof(phi_vec < phi_dw)   = 0;
  Eprof(phi_vec >= phi_dw)  = (1-tau)*(prodFn(R,phi_vec(phi_vec >= phi_dw),...
      aalpha,r,prod_func_type,delta) - wStar);
  Eprof = sum(Eprof)/length(phi_vec);
end