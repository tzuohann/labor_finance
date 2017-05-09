function output = Estar_err(sepPol,delta,pi_Phi,wages,rra,BETA,E,nPhi,U,typeu,iLp_star,nL)
  Estar_test = zeros(size(E));
  for ip = 1:nPhi
    if sepPol(ip) == 1
      Estar_test(ip,:) = U;
    else
      for iL = 1:nL
        Ep = zeros(nPhi,1);
        for iphip = 1:nPhi
          sp        = max(sepPol(iphip),delta);
          Ep(iphip) = (1-sp).*E(iphip,iLp_star(ip,iphip,iL)) + sp*U;
        end
        W_D = pi_Phi(ip,:)*Ep;
        Estar_test(ip,iL) = utilFunc(wages(ip,iL),rra,typeu) + BETA*W_D;
      end
    end
  end
  output = max(vec(abs(Estar_test(:,2:nL-1) - E(:,2:nL-1))));
end