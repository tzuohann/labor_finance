function [FirmObj,U_u,U_l,EnteringP0,EnteringW0,EnteringLam_Idx,BR,theta] = solveSearch(nZ,init_Prod,sigma,V,F,U,BETA,EU_vect,U_u,U_l,ke,b,rra,gamma_vect,uSqueezeFactor)
%   nZ
%   init_Prod
%   sigma
%   nansum(V(:))
%   nansum(F(:))
%   U0
%   BETA
%   EU_vect
%   U_u
%   U_l
%   ke
%   U
%   b
%   rra
%   sum(gamma_vect)
%     
%   keyboard
%   
  FirmObj = -10;
  for iz=1:nZ
    
    %Firm offers contracts which workers are indifferent towards.
    %Contracts state value given to worker in each state of the world
    %This translates to specifying some V in each phi state
    %Therefore for each V offered, the firm gives some combination of V
    %in each phi so that his expected marginal F is equal in all phi.
    %TP = F + LAMBDA*W so the marginal loss to F is LAMBDA
    %So the firm offers W from the same lambda across all different
    %states. Assume this is correct for now, come back to this later.
    R_grid                  = (1-sigma).*init_Prod'*V;
    JV0                     = (1-sigma).*init_Prod'*F;
    feasSet                 = true(size(R_grid));
    %Off the bat, anything less than U0 is a no-go
    feasSet(R_grid < U)    = false;
    
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
      U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
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
      
      
      %Not sure what happens here with the initial probability
      %distribution
      EnteringLam_Idx(iz) = BR + 1;
      EnteringLam(iz)     = gamma_vect(EnteringLam_Idx(iz));
      
      if FirmObj(iz)>=ke
        U_l(iz)=(U_u(iz)+(uSqueezeFactor - 1)*U_l(iz))/uSqueezeFactor;
      else
        U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
      end
    end
    U0(iz)=(U_u(iz) + U_l(iz))/2;
  end
end