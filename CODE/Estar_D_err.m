function output = Estar_D_err(sepPol_D,delta,pi_Phi,wages_D,rra,BETA,Estar_D,nPhi,U_D)
  for ip = 1:nPhi
    sp = max(sepPol_D,delta);
    W_D = pi_Phi(ip,:)*((1-sp).*Estar_D + sp.*(ones(nPhi,1)*U_D));
    Estar_D_test(ip,1) = utilFunc(wages_D(ip),rra) + BETA*W_D;
  end
  output = max(abs(Estar_D_test - Estar_D));
end