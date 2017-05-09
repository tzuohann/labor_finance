function [TP,iLp_star,w_star_v] = solvePareto(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,r,K,D,tau,w_star_pre_cons,commitType)
  
  iLp_star                  = ones(nPhi,nPhi,nL);
  w_star_v                  = w_star_pre;
  iLp_star(sep_pol == 1,sep_pol == 1,:)  = nan;
  w_star_v(sep_pol == 1,:)  = nan;
  TP                        = zeros(nPhi,nL);
  
  U2                        = (max(sep_pol,delta)).*U';
  EsigU                     = pi_Phi*U2(:);
  Obj_Pre     = r*K + (repmat(Phi_grid,1,nL) - D*r - w_star_pre)*(1-tau) ...
    + repmat(Lambda_vect,nPhi,1).*(w_star_pre_cons + BETA*repmat(EsigU,1,nL));
  
  %Helper variables for limited commitment case
  UCons = zeros(nPhi,nL,nL);
  for iphi = 1:nPhi
    for iL = 1:nL
      UCons(iphi,iL:nL,iL) = (Lambda_vect(iL) - Lambda_vect(iL:nL))*(1-max(sep_pol(iphi),delta))*U;
    end
  end
  SepP = zeros(nPhi,nL);
  
  tol  = 1;
  Iter = 0;
  while (tol > CV_tol && Iter < Niter )
    Iter = Iter +1;
    if Iter == Niter
      error('Maximum Iteration TP reached')
    end
    P = TP;
    switch commitType
      %Perfect commitment case sped up to the MAXXXXXXX
      case{'perfect'}
        EP       = BETA*pi_Phi*bsxfun(@times,(1-max(sep_pol,delta)),P);
        iLp_star = repmat(reshape(1:nL,1,1,nL),nPhi,nPhi,1);
        TP(sep_pol < 1,:)         = Obj_Pre(sep_pol < 1,:) + EP(sep_pol < 1,:);
      case{'limited'}
        
        
        for iPhi = 1:nPhi
          SepP(iPhi,:) = (1-max(sep_pol(iPhi),delta))*P(iPhi,:);
        end
        
        for iphi = 1:nPhi
          if sep_pol(iphi) < 1
            for iL = 1:nL
              [TP2,B0]              = min(SepP(:,iL:nL) + UCons(:,iL:nL,iL),[],2);
              B                     = B0+iL-1;
              iLp_star(iphi,:,iL)   = B;
              TP(iphi,iL)           = BETA.*pi_Phi(iphi,:)*TP2 + Obj_Pre(iphi,iL);
            end
          end
        end
        
      otherwise
        error('Commitment type not specifed correctly.')
    end
    
    tol = max(max(abs(TP - P)));
    if any(isnan(TP(:)))
      warning('Nans in TP')
    end
  end
end



