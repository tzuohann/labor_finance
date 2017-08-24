function [TP,iLp_star,w_star_v] = solvePareto(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,r,K,D,tau,w_star_pre_cons,commitType,preTaxOutput)
  
  iLp_star                  = ones(nPhi,nPhi,nL);
  w_star_v                  = w_star_pre;
  iLp_star(sep_pol == 1,sep_pol == 1,:)  = nan;
  w_star_v(sep_pol == 1,:)  = nan;
  TP                        = zeros(nPhi,nL);
  
  U2                        = (max(sep_pol,delta)).*U';
  EsigU                     = pi_Phi*U2(:);
  Obj_Pre                   = bsxfun(@minus,preTaxOutput,w_star_pre)*(1-tau) ...
    + repmat(Lambda_vect,nPhi,1).*(w_star_pre_cons + BETA*repmat(EsigU,1,nL));
  
  SepP = zeros(nPhi,nL);
  TP2  = zeros(nPhi,nL);
    
  tol  = 1;
  Iter = 0;
  while (tol > CV_tol && Iter < Niter)
    Iter = Iter +1;
    if Iter == Niter
      error('Maximum Iteration TP reached')
    end
    P = TP;
    switch commitType
      %Perfect commitment case sped up to the MAXXXXXXX
      case{'perfect'}
        EP                        = BETA*pi_Phi*bsxfun(@times,(1-max(sep_pol,delta)),P);
        iLp_star                  = repmat(reshape(1:nL,1,1,nL),nPhi,nPhi,1);
        TP(sep_pol < 1,:)         = Obj_Pre(sep_pol < 1,:) + EP(sep_pol < 1,:);
        TP(sep_pol == 1,:)        = nan;
      case{'limited'}
        
        %Helper variables for limited commitment case
        UCons = zeros(nPhi,nL,nL);
        for iphi = 1:nPhi
          for iL = 1:nL
            UCons(iphi,iL:nL,iL) = (Lambda_vect(iL) - Lambda_vect(iL:nL))*(1-max(sep_pol(iphi),delta))*U;
          end
        end
        
        %FAST
        for iPhi = 1:nPhi
          SepP(iPhi,:) = (1-max(sep_pol(iPhi),delta))*P(iPhi,:);
        end
        
        TP2(:) = 0;
        for iL = 1:nL
          [TP2(:,iL),B0]              = min(SepP(:,iL:nL) + UCons(:,iL:nL,iL),[],2);
          iLp_star(:,:,iL)            = repmat(B0'+iL-1,nPhi,1);
        end
        
        for iphi = 1:nPhi
          if sep_pol(iphi) < 1
            TP(iphi,:)                = Obj_Pre(iphi,:) + BETA.*pi_Phi(iphi,:)*TP2;
          end
        end
        
        TP(sep_pol == 1,:)        = nan;
        index                     = TP < bsxfun(@times,ones(size(TP)),Lambda_vect*U);
        %TP is at minimum, lambda times U because E >= U in LC
        TP(index)                 = nan;
      otherwise
        error('Commitment type not specifed correctly.')
    end
    
    tol = max(max(abs(TP - P)));
    if any(isnan(TP(:)))
      warning('Nans in TP')
    end
  end
end
