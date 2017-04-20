%%%%% worker utility U(c)= C^(1-rra)/(1-rra)
%%%%% mathing function is CES as in schaal

clear
close all

global gamma_matching

%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0.1;            %Taxes
r                   = 0.1;          %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
rra                 = 0.6;          %Relative risk aversion.
BETA                = 1/(1+r);      %Discount factor
sigma               = 0.025;        %Exogenous separatoin probability. We call this delta in the paper.
gamma_matching      = .5;           %Matching elasticity parameter
b                   = 0.02;         %Value of home production
psi                 = 0;            %fraction of recovered firm value if failed search

%Aggregate productivity shock -- muted for now
z_0                 = 1;
nZ                  = 1;
pi_z                = 1;
iz                  = 1;

%Worker productivity shock
nPhi                = 10;
rho_Phi             = 0.9;
sigma_Phi           = 0.15;
mean_Phi            = 0.03;

mPhi                = 1;
Phi_grid            = linspace(-mPhi*sigma_Phi,mPhi*sigma_Phi,nPhi)';
pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,sigma_Phi);
Phi_grid            = mean_Phi + (Phi_grid);

%Initial productivity distrib
init_Prod           = zeros(size(Phi_grid));
init_Prod(end)      = 1;

%%%%%%%%%%%%%%%%%%%%%%
% Plot parameters
%%%%%%%%%%%%%%%%%%%%%%
dynamicT            = 10;

%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%
nG                  = 1000;
gamMax              = 2;
gamma_vect          = linspace(0,gamMax,nG);   % Lagrange multiplier grid
gamma_vect_ws0      = (gamma_vect/(1-tau)).^(1/rra);

% inner loop
Niter               = 500;
CV_tol              = 0.0000000001;

% outer loop
maxIter_U           = 1000;
CV_tol_U            = 0.0000000001;

%%% Optimizing grid over Debt D
nD                  = 6;
D_grid              = linspace(0.1,K-0.1,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 6;

%%%%%%%%%%%%%%%%%%%%%%
% Core code
%%%%%%%%%%%%%%%%%%%%%%
firstRun = true;
for iD = 1:nD
  D = D_grid(iD);
  disp(['Calculating for iD = ',num2str(iD)])
  ke = 0.2%K-0.7*D;   %%%%% entry cost depends on D
  if ke <= 0
    error('Cost of entry must be weakly positive')
  end
  
  %Endogenous separation policy
  sep_pol         = (K*r +(Phi_grid - D*r)*(1-tau) < 0);
  
  %Variables that only depend on D
  w_star0         = gamma_vect_ws0;
  bla1            = (r*K + (bsxfun(@minus,Phi_grid , w_star0) - D*r)*(1-tau) >= 0);
  w_star_pre      = bsxfun(@times,w_star0,bla1) + bsxfun(@times,(r/(1-tau)*K +(Phi_grid - D*r)),(1-bla1));
  w_star_pre(w_star_pre <= 0) = nan;
  w_star_pre_cons = utilFunc(w_star_pre,rra);
  
  %lowest possible utlity is consuming b forever
  U_min   = utilFunc(b,rra)/(1-BETA);
  %highest possible utlity is consuming all production
  U_max   = utilFunc(max(K*r +(Phi_grid - D*r)*(1-tau)),rra)/(1-BETA);
  if firstRun
    U_l     = U_min*ones(nZ,1);
    U_u     = U_max*ones(nZ,1);
  else
    U_l     = max(U_min,0.7*U)*ones(nZ,1);
    U_u     = min(U_max,1.3*U)*ones(nZ,1);
  end
  
  igp_star          = nG*ones(nPhi,nG);
  gp_star           = gamma_vect(nG)*ones(nPhi,nG);
  w_star_v          = gamma_vect(nG)*ones(nPhi,nG);
  
  % initial values
  U0  = (U_l + U_u)/2;
  U   = U0;
  
  %Start from zero, but otherwise, just start from previous value
  %   if firstRun
  P = zeros(nPhi, nG);
  %   end
  TP = P;
  
  tol_U = 1;
  iter_U = 0;
  firstRun = false;
  while(tol_U>CV_tol_U &&  iter_U < maxIter_U  )
    iter_U =  iter_U +1;
    if iter_U == maxIter_U
      error('Maximum Iteration U reached')
    end
    
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
        error('Maximum Iteration U reached')
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
            if rand() < max(CV_tol/tol,0.5)
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
    
    
    % Converting the solution from Lagrange multiplier space to promised value space
    
    V = zeros(nPhi,nG-2);   %% Promised Value
    F = zeros(nPhi,nG-2);   %% Firm value
    
    for iphi=1:nPhi
      
      if sep_pol(iphi) == 0
        
        for irho=2:nG-1
          
          V(iphi,irho-1) = (TP(iphi,irho+1) - TP(iphi,irho-1))/(2*(gamma_vect(2) - gamma_vect(1)));
          
        end
      else
        V(iphi,1:nG-2) = U0;
      end
      
    end
    
    
    for iphi=1:nPhi
      
      if sep_pol(iphi) ==0
        
        F(iphi,:) = TP(iphi,2:end-1) - gp_star(iphi,2:end-1).*V(iphi,:);
        
      else
        
        F(iphi,1:nG-2) = psi.*(K-D);  %% testing with K-D instead of 0
      end
      
    end
    
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
      feasSet(R_grid < U0)    = false;
      
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
    
    tol_U = (FirmObj - ke)^2;
    
  end
  
  %What the firm compares to ke
  FirmObj_D(iD)       = FirmObj;
  %Matching probability p
  EnteringP0_D(iD)    = EnteringP0;
  %Promised worker value conditional on matching.
  %This is what's offered in the search market.
  EnteringW0_D(iD)    = EnteringW0;
  %Value of unemployment
  U0_D(iD)            = U0;
  %Separation policy
  sepPol_D(:,iD)      = sep_pol;
  %Wages, this works because Entering_Lam is identical in all states
  wages_D(:,iD)       = w_star_v(:,EnteringLam_Idx(iz));
  %Saddle point problem solution
  TP_D(:,iD)          = TP(:,EnteringLam_Idx(iz));
  %Calculate SS distrib of E, U etc
  [massE_D(:,iD), massU(iD)] = calcEmpDist(nPhi,pi_Phi,sep_pol,sigma,EnteringP0,init_Prod);
  massEnt(iD)         = theta(BR).*massU;
end

figure(1)
subplot(2,2,1)
plot(D_grid, EnteringP0_D,'-*','LineWidth',3);
title('Matching probability over debt choice')
subplot(2,2,2)
hold on
plot(D_grid, EnteringW0_D,'-*','LineWidth',3);
plot(D_grid, U0_D,'-*','LineWidth',3);
hold off
legend({'W','U'})
title('W and U')
subplot(2,2,3)
plot(D_grid, FirmObj_D,'-*','LineWidth',3);
title('Cost of entry = expected value from search')
xlabel('Debt')
subplot(2,2,4)
plot(D_grid,TP_D(nPhi,:),'-*','LineWidth',3);
title('TP')

figure(2)
subplot(2,2,1)
imagesc(D_grid,Phi_grid,sepPol_D)
xlabel('Debt')
ylabel('Phi')
title('Separations (Yellow)')
subplot(2,2,2)
imagesc(D_grid,Phi_grid,massE_D)
colorbar
xlabel('Debt')
ylabel('Phi')
title('Mass')
subplot(2,2,3)
plotyy(D_grid,massU,D_grid,massEnt)
colorbar
xlabel('Debt')
title('Unemployment (Left), Entrants (Right)')


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Dynamics - Just to look at wages as phi starts high, decreases and
% % increases
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [phi_vect]  = [nPhi:-1:2,1:1:nPhi];
% igamma      = EnteringLam_Idx(iz);
% EnteringP   = EnteringP0(iz);
% iGammap_TS(1) = igamma;
% wage_TS(1)    = OptimalWage_D(1);
% Gammap_TS(1)  = gamma_vect(iGammap_TS(1));
% div_TS(1)     = r*K + (Phi_grid(phi_vect(1))- wage_TS(1) - D*r)*(1-tau);
% for t=2:dynamicT
%
%   iphi        = phi_vect(t);
%   sep_TS(t)   = sep_pol(iphi);
%
%   if done_idx == 0
%
%     if sep_TS(t) == 1;
%
%       done_idx        = 1;
%       wage_TS(t)      = 0;
%       iGammap_TS(t)   = 0;
%       Gammap_TS(t)    = 0;
%       div_TS(t)       = 0;
%
%     else
%
%       iGammap_TS(t)   = igp_star(iphi,igamma);
%       Gammap_TS(t)    = gamma_vect(iGammap_TS(t));
%       wage_TS(t)      = w_star_v(iphi,igamma);
%       div_TS(t)       = r*K + (Phi_grid(iphi)- wage_TS(t) - D*r)*(1-tau);
%       sep_TS(t)       = sep_pol(iphi);
%       igamma          = iGammap_TS(t);
%
%     end
%
%   else
%
%     done_idx        = 1;
%     wage_TS(t)      = 0;
%     iGammap_TS(t)   = 0;
%     Gammap_TS(t)    = 0;
%     div_TS(t)       = 0;
%     sep_TS(t)       = 1;
%
%   end
% end



