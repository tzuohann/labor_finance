function [FirmObj,EnteringW0,EnteringLam_Idx,theta_star] = ...
    solveSearch(nZ,init_Prod,delta,E,V,U,BETA,EU_vect,b,rra,gamma_vect,sep_pol)

  FirmObj = -10;
  for iz=1:nZ
    
    %Firm offers contracts which workers are indifferent towards.
    %Contracts state value given to worker in each state of the world
    %This translates to specifying some V in each phi state
    %FOC shows that marginal E in each state is lambda
    separationProb          = max(delta,sep_pol);
    R_grid                  = ((1-separationProb)'.*init_Prod')*E;
    JV0                     = ((1-separationProb)'.*init_Prod')*V; %+ Value Vacancy = 0 becaus psi = 0
    feasSet                 = true(size(R_grid));
    %Off the bat, anything less than U0 is a no-go
    feasSet(R_grid < U)     = false;
    
    %Maximizing the worker's search problem
    rho(iz)         = (U(iz) - utilFunc(b,rra) - BETA* EU_vect(iz));
    A0              = rho(iz)./(BETA*(R_grid - EU_vect(iz)));
    
    %If A0 > 1, this means that the firm is offering so little that the
    %workers needs to get the job more than for sure. Hence, it is not
    %possible to offer that quantity
    feasSet(A0 > 1) = false;
    
    %Matching probability
    if any(A0(feasSet) > 1) || any(A0(feasSet) < 0)
      error('Matching probability error')
    end
    theta     = 1./qinv(A0);
    
    FirmFun                   = q(theta).*JV0;
    FirmFun(feasSet == false) = nan;
    
    if all(isnan(FirmFun))
      FirmObj         = 0;
      EnteringP0      = nan;
      EnteringW0      = nan;
      EnteringLam_Idx = nan;
      EnteringLam     = nan;
      theta_star      = nan;
    else
      
      [AR , BR]             = max(FirmFun);
      if BR == 1 || BR == numel(FirmFun)
        error('Corner solution to search problem')
      end
      if AR <= 0
        error('Firm value at entry at negative')
      end
      EnteringP0(iz)      = A0(BR);
      FirmObj(iz)         = AR;
      EnteringW0(iz)      = R_grid(BR);
      
      %For the case with PC, the multipler is a constant from entry
      EnteringLam_Idx(iz) = BR;
      EnteringLam(iz)     = gamma_vect(BR);
      theta_star          = theta(BR);
    end
  end
end