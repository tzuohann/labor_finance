function [E,V] = calcEV(TP,nPhi,nL,Lambda_vect,U0,Lp_star,sep_pol,psi,K,D)
  E = zeros(nPhi,nL);   %% Promised Value
  V = zeros(nPhi,nL);   %% Firm value
  
  %Taking a single sided derivative at the ends to prevent errors with
  %indexing further down.
  for iphi=1:nPhi
    if sep_pol(iphi) == 0
      for irho=1:nL
        if irho == 1
          E(iphi,irho) = (TP(iphi,irho+1) - TP(iphi,irho))/(Lambda_vect(2) - Lambda_vect(1));
        elseif irho == nL
          E(iphi,irho) = (TP(iphi,irho) - TP(iphi,irho-1))/(Lambda_vect(end) - Lambda_vect(end-1));
        else
          E(iphi,irho) = (TP(iphi,irho+1) - TP(iphi,irho-1))/(Lambda_vect(irho+1) - Lambda_vect(irho-1));
        end
      end
    else
      E(iphi,:) = U0;
    end
  end
  
  for iphi=1:nPhi
    
    if sep_pol(iphi) ==0
      V(iphi,:) = TP(iphi,:) - Lp_star(iphi,:).*E(iphi,:);
    else
      V(iphi,:) = psi.*(K-D);  %% testing with K-D instead of 0
    end
    
  end
end