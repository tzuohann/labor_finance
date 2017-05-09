function output = EnteringW_err(sepPol_D,delta,init_Prod,Estar_D,nPhi,U_D,EnteringW_D)
  %Unused because this equation simply verifies code
  sp = max(sepPol_D,delta);
  EnteringW_D_test = init_Prod'*((1-sp).*Estar_D + sp.*ones(nPhi,1)*U_D);
  output = abs(EnteringW_D_test - EnteringW_D);
end