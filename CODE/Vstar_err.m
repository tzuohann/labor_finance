function output = Vstar_err(sepPol,delta,pi_Phi,wages,BETA,V,nPhi,iLp_star,nL,R,K,Phi_grid,r,D,tau)
  Vstar_test = zeros(size(V));
  for ip = 1:nPhi
    if sepPol(ip) == 1
      Vstar_test(ip,:) = 0;
    else
      for iL = 1:nL
        Vp = zeros(nPhi,1);
        for iphip = 1:nPhi
          sp        = max(sepPol(iphip),delta);
          Vp(iphip) = (1-sp).*V(iphip,iLp_star(ip,iphip,iL));
        end
        div_test          = (R*K + Phi_grid(ip) - r*D - wages(ip,iL))*(1-tau);
        F_D               = pi_Phi(ip,:)*Vp;
        Vstar_test(ip,iL) = div_test + BETA*F_D;
      end
    end
  end
  output = max(vec(abs(Vstar_test(:,2:nL-1) - V(:,2:nL-1))));
end