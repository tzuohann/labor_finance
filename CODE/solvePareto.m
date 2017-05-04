function [TP,Lp_star,w_star_v,EU_vect] = solvePareto(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons)
  
  iLp_star                  = ones(nPhi,nL);
  Lp_star                   = ones(nPhi,nL);
  w_star_v                  = ones(nPhi,nL);
  iLp_star(sep_pol == 1,:)  = nan;
  Lp_star(sep_pol == 1,:)   = nan;
  w_star_v(sep_pol == 1,:)  = nan;
  TP                        = repmat(Lambda_vect.*U,nPhi,1);
  
  EU_vect                   = pi_z*(U(:));
    
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
    
    P    = TP;
    % Expectations over phi shock
    EP   = pi_Phi*bsxfun(@times,(1-max(sep_pol,delta)),P);
        
    for iphi = 1:nPhi
      
      if sep_pol(iphi) < 1   
        
        EP_Phi0 = squeeze(EP(iphi,:));
        max_EP_Phi0 = max(EP_Phi0,Lambda_vect.*U);
        
        for ig = 1:nL
          
          iLp_star(iphi,ig)   = ig;
          Lp_star(iphi,ig)    = Lambda_vect(ig);
          w_star_v(iphi,ig)   = w_star_pre(iphi,ig);         
          TP(iphi,ig)         = Obj_Pre(iphi,ig) + BETA*max_EP_Phi0(ig);
          
        end
        
      end
      
    end
    
    tol = max(max(abs(TP - P)));
    
  end
end