function Code_Mar2017_v2()
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
  r                   = 0.5;          %Return on capital.
  R                   = r/(1-tau);    %Gross return on capital
  rra                 = 0.5;          %Relative risk aversion.
  BETA                = 1/(1+r);      %Discount factor
  delta               = 0.05;         %Exogenous separation probability.
  gamma_matching      = 0.5;          %Matching elasticity parameter
  b                   = 0;            %Value of home production
  psi                 = 0;            %fraction of recovered firm value if failed search
  
  %Aggregate productivity shock -- muted for now
  z_0                 = 1;
  nZ                  = 1;
  pi_z                = 1;
  iz                  = 1;
  
  %Worker productivity shock
  nPhi                = 30;
  rho_Phi             = 0.9;
  delta_Phi           = 0.15;
  mean_Phi            = 0.10;
  
  mPhi                = 1;
  Phi_grid            = linspace(-1,0.1,nPhi)';
  pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,delta_Phi);
  
  % Initial productivity distrib
  init_Prod           = pi_Phi^100;
  init_Prod           = init_Prod(1,:)';
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Technical parameters
  %%%%%%%%%%%%%%%%%%%%%%
  nL                  = 2000;
  LambdaMax           = 0.75;
  Lambda_vect         = linspace(0,LambdaMax,nL);   % Lagrange multiplier grid
  Lambda_vect_ws0     = (Lambda_vect/(1-tau)).^(1/rra);
  
  % inner loop
  Niter               = 500;
  CV_tol              = 0.0000000001;
  
  % outer loop
  maxIter_U           = 1000;
  CV_tol_U            = 0.0000000001;
  
  %%% Optimizing grid over Debt D
  %Choose debt so that it is both inbetween 0 and 1 and increases
  %separations as a function of D
  nD                  = 14;
  D_grid              = 1/(1-tau) + Phi_grid(1:nD)/r;
  
  nD                  = 4;
  D_grid              = linspace(D_grid(1),D_grid(end),nD);
  
  if any(K - D_grid) <= 0
    error('Cost of entry must be weakly positive. Check K - D_grid')
  end
  
  %%% Bringing the unemployment value limits in the outer loop closer
  uSqueezeFactor      = 10;
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Core code
  %%%%%%%%%%%%%%%%%%%%%%
  for iD = 1:nD
    D = D_grid(iD);
    ke = K - D;
    disp(['Calculating for iD = ',num2str(iD)])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%Variables that only depend on D %%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    preTaxOutput                = outputFunc(K,r,tau,Phi_grid,D);
    sep_pol                     = preTaxOutput*(1-tau) <= 0;  %Endogenous separation policy
    %Wages and utility from consuming wages
    w_star0                     = Lambda_vect_ws0;
    w_cons                      = (r/(1-tau)*K +(Phi_grid - D*r));
    posDiv                      = bsxfun(@minus,preTaxOutput,w_star0) >= 0;
    w_star_pre                  = bsxfun(@times,w_star0,posDiv) + bsxfun(@times,w_cons,(1-posDiv));
    w_star_pre(w_star_pre <= 0) = nan;
    w_star_pre_cons             = utilFunc(w_star_pre,rra);
    
    %lowest possible utlity is consuming b forever
    U_min   = utilFunc(b,rra)/(1-BETA);
    %highest possible utlity is consuming all production
    U_max   = utilFunc(max(preTaxOutput)*(1-tau),rra)/(1-BETA);
    
    %Check that there is entry at U_min
    [~,~,~,~,~,~,FirmObj] = solveGivenU(...
      CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
      Phi_grid,BETA,Lambda_vect,w_star_pre,U_min,pi_z,r,K,D,tau,w_star_pre_cons,psi,nZ,init_Prod,b,rra);
    if FirmObj > ke
    else
      error('No entry at U_min')
    end
    
    %Initialize U levels
    U_l     = U_min*ones(nZ,1);
    U_u     = U_max*ones(nZ,1);
    tol_U = 1;
    iter_U = 0;
    while(tol_U > CV_tol_U &&  iter_U < maxIter_U )
      %Update U
      U   = (U_l + U_u)/2;
      iter_U =  iter_U +1;
      if iter_U == maxIter_U
        error('Maximum Iteration U reached')
      end
      
      %Solve the entire problem given U
      %Lp_star is unused because in PC case, Lambda' - Lambda
      %EU_vect is unused because there is only one aggregate state
      [TP,Lp_star,w_star_v,EU_vect,...
        E,V,FirmObj,EnteringW0,EnteringLam_Idx,theta_star] = solveGivenU(...
        CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
        Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,psi,nZ,init_Prod,b,rra);
      
      %Update U_u and U_l given solution to problem
      for iz = 1:nZ
        if FirmObj(iz)>=ke
          U_l(iz)=(U_u(iz)+(uSqueezeFactor - 1)*U_l(iz))/uSqueezeFactor;
        else
          U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
        end
      end
      tol_U = (FirmObj - ke)^2;
    end
    
    EnteringW_err(iD) = EnteringW_D_err(sep_pol,delta,init_Prod,E(:,EnteringLam_Idx),nPhi,U,EnteringW0);
    U_err(iD)         = U_D_err(b,rra,BETA,theta_star*q(theta_star),EnteringW0,U);
    Estar_err(iD)     = Estar_D_err(sep_pol,delta,pi_Phi,w_star_v(:,EnteringLam_Idx(iz)),rra,BETA,E(:,EnteringLam_Idx),nPhi,U);
    Vstar_err(iD)     = Vstar_D_err(nPhi,sep_pol,delta,R,K,Phi_grid,r,D,w_star_v(:,EnteringLam_Idx(iz)),tau,BETA,pi_Phi,V(:,EnteringLam_Idx(iz)));
    
    %What the firm compares to ke
    EnteringF_D(iD)     = FirmObj./q(theta_star);
    %Firm matching probability q
    Q_D(iD)             = q(theta_star);
    %Worker matching probability p
    P_D(iD)             = theta_star*q(theta_star);
    %Promised worker value conditional on matching.
    %This is what's offered in the search market.
    EnteringW_D(iD)     = EnteringW0;
    %Entering Lambda
    %This tells us how much of lambda is actually used
    EnteringLam_Idx_D(iD) = EnteringLam_Idx;
    EnteringLam(iD)       = Lambda_vect(EnteringLam_Idx_D(iD));
    %Value of unemployment
    U_D(iD)             = U;
    %Separation policy including delta
    sepPol_D(:,iD)      = max(delta,sep_pol);
    %Wages, this works because Entering_Lam is identical in all states
    wages_D(:,iD)       = w_star_v(:,EnteringLam_Idx(iz));
    %Dividends, this works because Entering_Lam is identical in all states
    dividends_D(:,iD)   = (preTaxOutput - w_star_v(:,EnteringLam_Idx(iz)))*(1-tau);
    %Saddle point problem solution
    TP_D(:,iD)          = TP(:,EnteringLam_Idx_D(iD));
    %Value of worker in each state of the world
    Estar_D(:,iD)       = E(:,EnteringLam_Idx);
    %Value of firm in each state of the world
    Vstar_D(:,iD)       = V(:,EnteringLam_Idx);
    %Calculate SS distrib of E, U etc
    [massE_D(:,iD), massU(iD)] = calcEmpDist(nPhi,pi_Phi,sep_pol,delta,P_D(iD),init_Prod);
    massEnt(iD)         = theta_star.*massU(iD);
    
    %Understanding where we can get a hump
    
    %ROE period output of economy / capital injected in each period
    ROE_D1(:,iD)         = (nansum(massE_D(:,iD).*(wages_D(:,iD) + dividends_D(:,iD))) + b.*massU(iD))/(massEnt(iD).*(K - D));
    %ROE period output of economy / capital injected and used in each period
    ROE_D2(:,iD)         = (nansum(massE_D(:,iD).*(wages_D(:,iD) + dividends_D(:,iD))) + b.*massU(iD))/(Q_D(iD).*massEnt(iD).*(K - D));
    %ROE period output of economy / capital injected by all firms
    ROE_D3(:,iD)         = (nansum(massE_D(:,iD).*(wages_D(:,iD) + dividends_D(:,iD))) + b.*massU(iD))/(sum(massE_D(:,iD)).*(K - D));
    %ROE period output of economy / K - D
    ROE_D4(:,iD)         = (nansum(massE_D(:,iD).*(wages_D(:,iD) + dividends_D(:,iD))) + b.*massU(iD))/(K - D);
    %ROE period VALUE / K - D
    ROE_D5(:,iD)         = (EnteringF_D(iD) + EnteringLam(iD)*EnteringW_D(iD))/(K - D);
    %ROE period VALUE / K - D
    ROE_D6(:,iD)         = Q_D(iD).*(EnteringF_D(iD) + EnteringLam(iD)*EnteringW_D(iD))/(K - D);
    %ROE period VALUE / K - D
    ROE_D7(:,iD)         = nansum(massE_D(:,iD).*TP_D(:,iD))/(K - D);
    %ROE period VALUE / K - D
    ROE_D8(:,iD)         = Q_D(iD)*(init_Prod'*(sepPol_D(:,iD).*TP_D(:,iD)))/(K - D);
    %ROE period VALUE / K - D
    ROE_D9(:,iD)         = (init_Prod'*(sepPol_D(:,iD).*TP_D(:,iD)))/(K - D);
  end
  
  save
  checkingPlots
  EnteringW_err
  U_err
  Estar_err
  Vstar_err
  
end
