function [TP,iLp_star,w_star_v] = solvePareto(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,commitType)
  
  iLp_star                  = ones(nPhi,nL);
  Lp_star                   = ones(nPhi,nL);
  w_star_v                  = w_star_pre;
  iLp_star(sep_pol == 1,:)  = nan;
  w_star_v(sep_pol == 1,:)  = nan;
  TP                        = zeros(nPhi,nL);
  
  U2                        = (max(sep_pol,delta)).*U';
  EsigU                     = pi_Phi*U2(:);
  Obj_Pre     = r*K + (repmat(Phi_grid,1,nL) - D*r - w_star_pre)*(1-tau) ...
    + repmat(Lambda_vect,nPhi,1).*(w_star_pre_cons + BETA*repmat(EsigU,1,nL));
  
  tol  = 1;
  Iter = 0;
  while (tol > CV_tol && Iter < Niter )
    Iter = Iter +1;
    if Iter == Niter
      error('Maximum Iteration TP reached')
    end
    P = TP;
    switch commitType
      case{'perfect'}
        EP       = BETA*pi_Phi*bsxfun(@times,(1-max(sep_pol,delta)),P);
        iLp_star = repmat(1:nL,nPhi,1);
        for iphi = 1:nPhi
          if sep_pol(iphi) < 1
            TP(iphi,:)         = Obj_Pre(iphi,:) + EP(iphi,:);
          end
        end
      case{'limited'}
        [TP,iLp_star] = calcLC(TP,iLp_star,pi_Phi,sep_pol,delta,P,nPhi,Lambda_vect,Obj_Pre,BETA,nL);
      otherwise
        error('Commitment type not specifed correctly.')
    end
    
    tol = max(max(abs(TP - P)));
    
  end
end

function [TP,iLp_star] = calcLC(TP,iLp_star,pi_Phi,sep_pol,delta,P,nPhi,Lambda_vect,U,Obj_Pre,BETA,nL)
  sep_pol = max(sep_pol,delta);
  for iphi = 1:nPhi
    if sep_pol(iphi) < 1
      for iL = 1:nL
        TP2 = zeros(nPhi,1);
        for iphip = 1:nPhi
          [TP2(iphip,1),B0]         = min((1-sep_pol(iphip))*P(iphip,iL:nL) + (Lambda_vect(iL) - Lambda_vect(iL:nL))*(1-sep_pol(iphip))*U);
          B                         = B0+iL-1;
          iLp_star(iphi,iphip,iL)   = B;
        end
        TP(iphi,iL)                 = BETA.*pi_Phi(iphi,:)*TP2 + Obj_Pre(iphi,iL);
      end
    end
  end
end


