function [V,F] = calcVF(TP,nPhi,nG,gamma_vect,U0,gp_star,sep_pol,psi,K,D)
  V = zeros(nPhi,nG);   %% Promised Value
  F = zeros(nPhi,nG);   %% Firm value
  
  %Taking a single sided derivative at the ends to prevent errors with
  %indexing further down.
  for iphi=1:nPhi
    if sep_pol(iphi) == 0
      for irho=1:nG
        if irho == 1
          V(iphi,irho) = (TP(iphi,irho+1) - TP(iphi,irho))/(gamma_vect(2) - gamma_vect(1));
        elseif irho == nG
          V(iphi,irho) = (TP(iphi,irho) - TP(iphi,irho-1))/(gamma_vect(end) - gamma_vect(end-1));
        else
          V(iphi,irho) = (TP(iphi,irho+1) - TP(iphi,irho-1))/(gamma_vect(irho+1) - gamma_vect(irho-1));
        end
      end
    else
      V(iphi,:) = U0;
    end
  end
  
  for iphi=1:nPhi
    
    if sep_pol(iphi) ==0
      F(iphi,:) = TP(iphi,:) - gp_star(iphi,:).*V(iphi,:);
    else
      F(iphi,:) = psi.*(K-D);  %% testing with K-D instead of 0
    end
    
  end
end