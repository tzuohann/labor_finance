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
  tau                 = 0.1;          %Taxes
  r                   = 0.1;          %Return on capital.
  R                   = r/(1-tau);    %Gross return on capital
  rra                 = 0.6;          %Relative risk aversion.
  BETA                = 1/(1+r);      %Discount factor
  sigma               = 0.025;        %Exogenous separatoin probability. We call this delta in the paper.
  gamma_matching      = 0.5;          %Matching elasticity parameter
  b                   = 0.02;         %Value of home production
  psi                 = 0;            %fraction of recovered firm value if failed search
  
  %Aggregate productivity shock -- muted for now
  z_0                 = 1;
  nZ                  = 1;
  pi_z                = 1;
  iz                  = 1;
  
  %Worker productivity shock
  nPhi                = 20;
  rho_Phi             = 0.9;
  sigma_Phi           = 0.15;
  mean_Phi            = 0.10;
  
  mPhi                = 1;
  Phi_grid            = linspace(-mPhi*sigma_Phi,mPhi*sigma_Phi,nPhi)';
  pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,sigma_Phi);
  Phi_grid            = mean_Phi + (Phi_grid);
  
  %Initial productivity distrib
  init_Prod           = zeros(size(Phi_grid));
  init_Prod(end)      = 1;
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Technical parameters
  %%%%%%%%%%%%%%%%%%%%%%
  nG                  = 500;
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
  uSqueezeFactor      = 10;
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Plot parameters
  %%%%%%%%%%%%%%%%%%%%%%
  dynamicT            = 10;
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Core code
  %%%%%%%%%%%%%%%%%%%%%%
  for iD = 1:nD
    D = D_grid(iD);
    disp(['Calculating for iD = ',num2str(iD)])
    ke = K-D;   %%%%% entry cost depends on D
    if ke <= 0
      error('Cost of entry must be weakly positive')
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%Variables that only depend on D %%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    preTaxOutput    = outputFunc(K,r,tau,Phi_grid,D);
    sep_pol         = preTaxOutput*(1-tau) < 0;  %Endogenous separation policy
    %Wages and utility from consuming wages
    w_star0                     = gamma_vect_ws0;
    w_cons                      = (r/(1-tau)*K +(Phi_grid - D*r));
    posDiv                      = (bsxfun(@minus,preTaxOutput,w_star0).*(1-tau) >= 0);
    w_star_pre                  = bsxfun(@times,w_star0,posDiv) + bsxfun(@times,w_cons,(1-posDiv));
    w_star_pre(w_star_pre <= 0) = nan;
    w_star_pre_cons             = utilFunc(w_star_pre,rra);
    
    %lowest possible utlity is consuming b forever
    U_min   = utilFunc(b,rra)/(1-BETA);
    %highest possible utlity is consuming all production
    U_max   = utilFunc(max(preTaxOutput)*(1-tau),rra)/(1-BETA);
    
    %Check that there is entry at U_min
    [~,~,~,~,~,~,FirmObj] = solveGivenU(...
      CV_tol,Niter,nPhi,nG,sep_pol,sigma,pi_Phi,...
      Phi_grid,BETA,gamma_vect,w_star_pre,U_min,pi_z,r,K,D,tau,w_star_pre_cons,psi,nZ,init_Prod,b,rra);
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
      [TP,gp_star,w_star_v,EU_vect,...
        V,F,FirmObj,EnteringP0,EnteringW0,EnteringLam_Idx,theta_star] = solveGivenU(...
        CV_tol,Niter,nPhi,nG,sep_pol,sigma,pi_Phi,...
        Phi_grid,BETA,gamma_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,psi,nZ,init_Prod,b,rra);
      
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
    
    %What the firm compares to ke
    FirmObj_D(iD)       = FirmObj;
    %Matching probability p
    EnteringP0_D(iD)    = EnteringP0;
    %Promised worker value conditional on matching.
    %This is what's offered in the search market.
    EnteringW0_D(iD)    = EnteringW0;
    %Value of unemployment
    U0_D(iD)            = U;
    %Separation policy
    sepPol_D(:,iD)      = sep_pol;
    %Wages, this works because Entering_Lam is identical in all states
    wages_D(:,iD)       = w_star_v(:,EnteringLam_Idx(iz));
    %Dividends, this works because Entering_Lam is identical in all states
    dividends_D(:,iD)   = (preTaxOutput - w_star_v(:,EnteringLam_Idx(iz)))*(1-tau);
    %Saddle point problem solution
    TP_D(:,iD)          = TP(:,EnteringLam_Idx(iz));
    %Value of worker in each state of the world
    Vstar_D(:,iD)       = V(:,EnteringLam_Idx);
    %Value of firm in each state of the world
    Fstar_D(:,iD)       = F(:,EnteringLam_Idx);
    %Calculate SS distrib of E, U etc
    [massE_D(:,iD), massU(iD)] = calcEmpDist(nPhi,pi_Phi,sep_pol,sigma,EnteringP0,init_Prod);
    massEnt(iD)         = theta_star.*massU(iD);
    
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
  plot(D_grid,TP_D(5,:),'-*','LineWidth',3);
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
  
  
  
end
