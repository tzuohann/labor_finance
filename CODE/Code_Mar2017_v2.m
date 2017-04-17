%%%%% worker utility U(c)= C^(1-rra)/(1-rra)
%%%%% mathing function is CES as in schaal

clear
close all

global gamma_matching

%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0.2;          %Taxes
r                   = 0.1;          %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
rra                 = 0.5;          %Relative risk aversion.
BETA                = 0.9;          %Discount factor
sigma               = 0.025;        %Exogenous separatoin probability. We call this delta in the paper.
gamma_matching      = 1.75;         %Matching elasticity parameter
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
mean_Phi            = 0.08;

mPhi                = 1;
Phi_grid            = linspace(-mPhi*sigma_Phi,mPhi*sigma_Phi,nPhi)';
pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,sigma_Phi);
Phi_grid            = mean_Phi + (Phi_grid);

%%%%%%%%%%%%%%%%%%%%%%
% Plot parameters
%%%%%%%%%%%%%%%%%%%%%%
dynamicT            = 20;

%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%
nG                  = 10000;
gamMax              = .5;
gamma_vect          = linspace(0,gamMax,nG);   % Lagrange multiplier grid
gamma_vect_ws0      = (gamma_vect/(1-tau)).^(1/rra);

% inner loop
Niter               = 300;
CV_tol              = 0.000000001;

% outer loop
maxIter_U           = 600;
CV_tol_U            = 0.000000001;

%%% Optimizing grid over Debt D
nD                  = 20;
D_grid              = linspace(0,K-0.01,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 6;

%%%%%%%%%%%%%%%%%%%%%%
% Core code
%%%%%%%%%%%%%%%%%%%%%%

for iD = 14:16
  D = D_grid(iD);
  disp(['Calculating for iD = ',num2str(iD)])
  ke = K-D;   %%%%% entry cost depends on D
  if ke <= 0
    error('Cost of entry must be weakly positive')
  end
    
  %Endogenous separation policy
  sep_pol = (K*r +(Phi_grid - D*r)*(1-tau) < 0);
  
  %Variables that only depend on D
  w_star0         = gamma_vect_ws0;
  bla1            = (r*K + (bsxfun(@minus,Phi_grid , w_star0) - D*r)*(1-tau) >= 0);
  w_star_pre      = max(bsxfun(@times,w_star0,bla1) + bsxfun(@times,(r/(1-tau)*K +(Phi_grid - D*r)),(1-bla1)),0);
  w_star_pre_cons = utilFunc(w_star_pre,rra);
  
  %lowest possible utlity is consuming b forever
  U_min   = utilFunc(b,rra)/(1-BETA); 
  %highest possible utlity is consuming all production
  U_max   = utilFunc(max(K*r +(Phi_grid - D*r)*(1-tau)),rra)/(1-BETA);
  U_l     = U_min*ones(nZ,1);
  U_u     = U_max*ones(nZ,1);
  
  
  igp_star          = nG*ones(nPhi,nG);
  gp_star           = gamma_vect(nG)*ones(nPhi,nG);
  w_star_v          = gamma_vect(nG)*ones(nPhi,nG);
  
  % initial values
  U0 = (U_l + U_u)/2;
  U = U0;
  
  P = zeros(nPhi, nG);
  TP= zeros(nPhi, nG);
  
  tol_U = 1;
  iter_U = 0;
  
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
            
            if rand() > 0.9
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
      
      tol = sum((TP(:) - P(:)).^2);
      
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
    
    
    
    for iz=1:nZ

      %Assume for now entrants get max Phi
      Phi0                = nPhi;
      
      %These are the possible values that firms can promise workers.
      R_grid              = V(Phi0,:);
      R_grid              = R_grid(V(Phi0,:) > U0);
      JV0                 = F(Phi0,V(Phi0,:) > U0);
      
      %Maximizing the worker's search problem
      rho(iz)   = (U(iz) - utilFunc(b,rra) - BETA* EU_vect(iz));
      A0        = rho(iz)./(R_grid - BETA*EU_vect(iz));   
      
      %Matching probability
      A0        = min(max(A0,0),1);
      theta     = 1./qinv(A0);
      
      FirmFun             = q(theta).*JV0;
      
      [AR , BR]             = max(FirmFun);
      if BR == 1 || BR == numel(FirmFun)
        error('Corner solution to search problem')
      end
      EnteringP0(iz)      = A0(BR)*(AR>0);
      EnteringAR(iz)      = AR;
      X                   = R_grid(BR)*(AR>0);
      FirmObj(iz)         = max(AR,0);
      EnteringW0(iz)      = X;
      
      
      [X0 , Y0]             = min(abs((X) - (squeeze(V(Phi0,:)))));
      EnteringLam_Idx(iz) = max(Y0,1);
      EnteringLam(iz)     = gamma_vect(EnteringLam_Idx(iz));
      OptimalWage(iz)     = w_star_v(iphi,EnteringLam_Idx(iz) )*(AR>0);
      
      if FirmObj(iz)>=ke
        U_l(iz)=(U_u(iz)+(uSqueezeFactor - 1)*U_l(iz))/uSqueezeFactor;
      else
        U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
      end
      
      U0(iz)=(U_u(iz) + U_l(iz))/2;
    end
    
    
    
    tol_U = sum((FirmObj(:) -ke).^2);
    
    
  end
  
  %What the firm compares to ke
  FirmObj_D(iD)       = FirmObj;
  %Matching probability p 
  EnteringP0_D(iD)    = EnteringP0;
  %Promised worker value conditional on matching.
  EnteringW0_D(iD)    = EnteringW0;
  %Lagrange multiplier at entry
  OptimalWage_D(iD)   = OptimalWage;
  %Value of unemployment
  U0_D(iD)            = U0;
  %Separation policy
  sepPol_D(:,iD)      = sep_pol;
end;



%%%% plot variables at contract inception, vs. debt level D
figure(1);
plot(D_grid(1:end-1), EnteringP0_D(1:end-1));

figure(2);
plot1 = plot(D_grid(1:end-1), EnteringW0_D(1:end-1));
hold on
plot2 = plot(D_grid(1:end-1), U0_D(1:end-1));
set(plot1,'DisplayName','Promised Value W');
set(plot2,'DisplayName','U');
legend4 = legend('show');
set(legend4,'location','northeast','box','off');

figure(3);
plot(D_grid(1:end-1), OptimalWage_D(1:end-1));


%%%%%%%%%%%%%%%%%%%%%%
% Dynamics - Example
%%%%%%%%%%%%%%%%%%%%%%
[phi_vect]  = hmmgenerate(dynamicT,pi_Phi,eye(nPhi));
done_idx    = 1;
igamma      = EnteringLam_Idx(iz);
EnteringP   = EnteringP0(iz);
iGammap_TS(1) = igamma;
wage_TS(1)    = OptimalWage_D(1);
Gammap_TS(1)  = gamma_vect(iGammap_TS(1));
div_TS(1)     = r*K + (Phi_grid(phi_vect(1))- wage_TS(1) - D*r)*(1-tau);
for t=2:dynamicT
  
  iphi        = phi_vect(t);
  sep_TS(t)   = sep_pol(iphi);
  
  if done_idx == 0
    
    if sep_TS(t) == 1;
      
      done_idx        = 1;
      wage_TS(t)      = 0;
      iGammap_TS(t)   = 0;
      Gammap_TS(t)    = 0;
      div_TS(t)       = 0;
      
    else
      
      iGammap_TS(t)   = igp_star(iphi,igamma);
      Gammap_TS(t)    = gamma_vect(iGammap_TS(t));
      wage_TS(t)      = w_star_v(iphi,igamma);
      div_TS(t)       = r*K + (Phi_grid(iphi)- wage_TS(t) - D*r)*(1-tau);
      sep_TS(t)       = sep_pol(iphi);
      igamma          = iGammap_TS(t);
      
    end
    
  else
    
    done_idx        = 1;
    wage_TS(t)      = 0;
    iGammap_TS(t)   = 0;
    Gammap_TS(t)    = 0;
    div_TS(t)       = 0;
    sep_TS(t)       = 1;
    
  end
end