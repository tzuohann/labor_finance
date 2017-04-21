function [TP,igp_star,gp_star,w_star_v,EU_vect,U] = solvePareto(CV_tol,Niter,nPhi,nG,sep_pol,sigma,TP,pi_Phi,...
    Phi_grid,BETA,igp_star,gp_star,gamma_vect,w_star_v,w_star_pre,U0,pi_z,r,K,D,tau,w_star_pre_cons)
  
  U       = U0;
  EU0     = pi_z*(U(:));
  EU_vect = EU0;
  
  EU = pi_z*U(:);
  U2 = (max(sep_pol,sigma)).*U';
  %EsigU  = pi_z*U2(:);  % mistake here..
  EsigU  = pi_Phi*U2(:);
  
  U3 = (1-sep_pol).*U';  %%%%%%should be W0, not U0%%%%%%%%%%%
  EsigU3  = pi_z*U3(:);
  
  Obj_Pre = r*K + (repmat(Phi_grid,1,nG) - D*r)*(1-tau) + repmat(gamma_vect,nPhi,1).*(w_star_pre_cons +  BETA*repmat(EsigU,1,nG)) - w_star_pre*(1-tau);
  
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
      P_sl    = P(:,ig);
      P2      = (1-max(sep_pol,sigma)).*P_sl;%  + max(sep_pol,sigma)*(K-D); %% testing with K-D
      EP0     = pi_Phi*P2(:);   % this one includes separation
      EP(:,ig)    = EP0;
    end
    
    for iphi = 1:nPhi
      
      Phi = Phi_grid(iphi);
      EP_Phi0 = squeeze(EP(iphi,:));
      EsigU0 = squeeze(EsigU(iphi));
      max_EP_Phi0 = max(EP_Phi0,0);
      
      if sep_pol(iphi) < 1   % as long as there is no separation
        
        Obj = zeros(1,nG);
        for ig = 1:nG
          
          %Maximize more frequently as we get closer to the solution
          if rand() < 2%max(CV_tol/tol,0.5)
            [A,B0]            = min(BETA*max_EP_Phi0(ig:nG));
            B                 = B0+ig-1;
          else
            B                 = igp_star(iphi,ig);
            A                 = BETA*max_EP_Phi0(B);
          end
          igp_star(iphi,ig)   = B;
          gp_star(iphi,ig)    = gamma_vect(B);
          w_star_v(iphi,ig)   = w_star_pre(iphi,ig);                 % independent of ig
          TP(iphi,ig)         = A + Obj_Pre(iphi,ig);
          
        end
        
      end
      
    end
    
    tol = max((TP(:) - P(:)).^2);
    
  end
end