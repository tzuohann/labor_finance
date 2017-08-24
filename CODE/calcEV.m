function [E,V,w_star_v] = calcEV(TP,nPhi,nL,Lambda_vect,U0,sep_pol,psi,K,D,commitType,w_star_v)
  E = zeros(nPhi,nL);   %% Promised Value
  V = zeros(nPhi,nL);   %% Firm value
  
  %Taking a single sided derivative at the ends to prevent errors with
  %indexing further down.
  for iphi=1:nPhi
    for ilambda=1:nL
      if ilambda == 1
        E(iphi,ilambda) = (TP(iphi,ilambda+1) - TP(iphi,ilambda))/(Lambda_vect(2) - Lambda_vect(1));
      elseif ilambda == nL
        E(iphi,ilambda) = (TP(iphi,ilambda) - TP(iphi,ilambda-1))/(Lambda_vect(end) - Lambda_vect(end-1));
      else
        E(iphi,ilambda) = (TP(iphi,ilambda+1) - TP(iphi,ilambda-1))/(Lambda_vect(ilambda+1) - Lambda_vect(ilambda-1));
      end
    end
  end
  
  if strcmp(commitType,'perfect')
    for iphi=1:nPhi
      for ilambda = 1:nL
        if sep_pol(iphi) == 1
          V(iphi,ilambda) = 0;
          E(iphi,ilambda) = U0;
        else
          V(iphi,ilambda) = TP(iphi,ilambda) - Lambda_vect(ilambda).*E(iphi,ilambda);
        end
      end
    end
  elseif strcmp(commitType,'limited')
    for iphi=1:nPhi
      for ilambda = 1:nL
        if sep_pol(iphi) == 1 || TP(iphi,ilambda) == Lambda_vect(ilambda)*U0
          V(iphi,ilambda)         = 0;
          E(iphi,ilambda)         = U0;
          w_star_v(iphi,ilambda)  = nan;
        else
          V(iphi,ilambda) = TP(iphi,ilambda) - Lambda_vect(ilambda).*E(iphi,ilambda);
        end
      end
    end
    index = E < U0;
    E(index) = U0;
    V(index) = 0;
    w_star_v(index) = nan;
  else
    error('Commitment type misspecified')
  end
end