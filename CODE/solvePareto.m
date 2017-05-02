function [TP,Lp_star,w_star_v,EU_vect] = solvePareto(CV_tol,Niter,nPhi,nG,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons)
  
  iLp_star                  = ones(nPhi,nG);
  Lp_star                   = ones(nPhi,nG);
  w_star_v                  = ones(nPhi,nG);
  iLp_star(sep_pol == 1,:)  = nan;
  Lp_star(sep_pol == 1,:)   = nan;
  w_star_v(sep_pol == 1,:)  = nan;
  TP                        = zeros(nPhi, nG);
  
  EU_vect                   = pi_z*(U(:));
    
  U2                        = (max(sep_pol,delta)).*U';
  EsigU                     = pi_Phi*U2(:);
  
  %Seems correct...
  Obj_Pre     = r*K + (repmat(Phi_grid,1,nG) - D*r - w_star_pre)*(1-tau) ...
              + repmat(Lambda_vect,nPhi,1).*(w_star_pre_cons + BETA*repmat(EsigU,1,nG)); 
  
  tol  = 1;
  Iter = 0;
  while (tol > CV_tol && Iter < Niter )
    Iter = Iter +1;
    if Iter == Niter
      error('Maximum Iteration TP reached')
    end
    P    = TP;
    
    % computing expectations
    EP = zeros(nPhi,nG);
    for ig = 1:nG
      EP(:,ig)    = pi_Phi*(1-max(sep_pol,delta)).*P(:,ig);
    end
    
    for iphi = 1:nPhi
      
      EP_Phi0 = squeeze(EP(iphi,:));
      max_EP_Phi0 = max(EP_Phi0,0);
      
      if sep_pol(iphi) < 1   % as long as there is no separation
        
        %This is the slow part. Make this faster.
        for ig = 1:nG
          
          %Maximize more frequently as we get closer to the solution
          if rand() < max(CV_tol/tol,0.2)
            [A,B0]            = min(BETA*max_EP_Phi0(ig:nG));
            B                 = B0+ig-1;
          else
            B                 = iLp_star(iphi,ig);
            A                 = BETA*max_EP_Phi0(B);
          end
          iLp_star(iphi,ig)   = B;
          Lp_star(iphi,ig)    = Lambda_vect(B);
          w_star_v(iphi,ig)   = w_star_pre(iphi,ig);         
          TP(iphi,ig)         = A + Obj_Pre(iphi,ig);
          
        end
        
      end
      
    end
    
    tol = max(max((TP - P).*(TP - P)));
    
  end
end