function [EnteringF0,EnteringW0,EnteringLam_Idx,theta_star] = ...
    solveSearch(nZ,init_Prod,delta,E,V,U,BETA,b,rra,Lambda_vect,sep_pol,...
    typeu,pi_z,gamma_matching)
  
  E(isnan(E)) = 0;
  V(isnan(V)) = 0;
  
  EU_vect                   = pi_z*(U(:));
  for iz=1:nZ
    
    %Firm offers contracts which workers are indifferent towards.
    %Contracts state value given to worker in each state of the world
    %This translates to specifying some V in each phi state
    %FOC shows that marginal E in each state is lambda
    separationProb          = max(delta,sep_pol);
    W0_grid                 = init_Prod'*(bsxfun(@plus,bsxfun(@times,(1-separationProb),E),bsxfun(@times,separationProb,U)));
    F0_grid                 = ((1-separationProb)'.*init_Prod')*V; %+ Value Vacancy = 0 because Ppsi = 0
    feasSet                 = true(size(W0_grid));
    %Off the bat, anything less than U0 is a no-go
    feasSet(W0_grid < U)    = false;
    
    %Maximizing the worker's search problem
    rho(iz)         = max((U(iz) - utilFunc(b,rra,typeu) - BETA* EU_vect(iz)),0);
    A0              = rho(iz)./(BETA*(W0_grid - EU_vect(iz)));
    
    %If A0 > 1, this means that the firm is offering so little that the
    %workers needs to get the job more than for sure. Hence, it is not
    %possible to offer that quantity
    feasSet(A0 > 1) = false;
    
    %Matching probability
    if any(A0(feasSet) > 1) || any(A0(feasSet) < 0)
      error('Matching probability error')
    end
    theta     = 1./qinv(A0,gamma_matching);
    
    FirmFun                   = q(theta,gamma_matching).*F0_grid;
    FirmFun(feasSet == false) = nan;
    
    if all(isnan(FirmFun))
      EnteringF0      = -666666666;
      EnteringP0      = nan;
      EnteringW0      = nan;
      EnteringLam_Idx = nan;
      EnteringLam     = nan;
      theta_star      = nan;
    else
      
      [AR , BR]       = max(FirmFun);
%       if AR <= 0
%         error('Firm value at entry at negative')
%       end
      EnteringP0(iz)      = A0(BR);
      EnteringF0(iz)      = AR./q(theta(BR),gamma_matching);
      EnteringW0(iz)      = W0_grid(BR);
      
      %For the case with PC, the multipler is a constant from entry
      EnteringLam_Idx(iz) = BR;
      EnteringLam(iz)     = Lambda_vect(BR);
      theta_star          = theta(BR);
    end
  end
end