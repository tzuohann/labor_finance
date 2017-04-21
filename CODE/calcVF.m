function [V,F] = calcVF(TP,nPhi,nG,gamma_vect,U0,gp_star,sep_pol,psi,K,D)
  V = zeros(nPhi,nG-2);   %% Promised Value
  F = zeros(nPhi,nG-2);   %% Firm value
  
  for iphi=1:nPhi
    
    if sep_pol(iphi) == 0
      
      for irho=2:nG-1
        
        V(iphi,irho-1) = (TP(iphi,irho+1) - TP(iphi,irho-1))/(2*(gamma_vect(2) - gamma_vect(1)));
        
      end
    else
      V(iphi,1:nG-2) = U0;
    end
    
  end
  
  
  for iphi=1:nPhi
    
    if sep_pol(iphi) ==0
      
      F(iphi,:) = TP(iphi,2:end-1) - gp_star(iphi,2:end-1).*V(iphi,:);
      
    else
      
      F(iphi,1:nG-2) = psi.*(K-D);  %% testing with K-D instead of 0
    end
    
  end
end