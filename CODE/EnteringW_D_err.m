function output = EnteringW_D_err(sepPol_D,delta,init_Prod,Estar_D,nPhi,U_D,EnteringW_D)
  sp = max(sepPol_D,delta);
  EnteringW_D_test = init_Prod'*((1-sp).*Estar_D + sp.*ones(nPhi,1)*U_D);
  output = abs(EnteringW_D_test - EnteringW_D);
end