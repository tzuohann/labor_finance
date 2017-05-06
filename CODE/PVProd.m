function output = PVProd(nPhi,sepPol_D,delta,R,K,Phi_grid,r,D,wages,tau,BETA,pi_Phi,Vstar_D)
  for ip = 1:nPhi
    if sepPol_D(ip) == 1
      V_test(ip,1) = 0'; %psi assumed to be zero here
    else
    sp = max(sepPol_D,delta);
    div_test(ip,1) = (R*K + Phi_grid(ip) - r*D - wages(ip))*(1-tau);
    V_test(ip,1) = div_test(ip) + BETA*pi_Phi(ip,:)*((1-sp).*Vstar_D);
    end
  end
  output = max(abs(V_test - Vstar_D));
end