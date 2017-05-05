function Code_Mar2017_v2()
  %%%%% worker utility U(c)= C^(1-rra)/(1-rra)
  %%%%% mathing function is CES as in schaal
  
  clear
  close all
  global gamma_matching
  
  %Make comments in the parameterizationFile on what is going on.
  %Use a new file for each parameterization that does something
  parameterizationFile
  
  %Plot the setup of the problem to get a sense of how it works.
  setupPlot
  
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
    [~,~,~,~,~,~,EnteringF0,~,~,theta_star] = solveGivenU(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,Phi_grid,BETA,Lambda_vect,w_star_pre,U_min,pi_z,r,K,D,tau,w_star_pre_cons,Ppsi,nZ,init_Prod,b,rra);
    if BETA*EnteringF0*q(theta_star) > ke
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
        E,V,EnteringF0,EnteringW0,EnteringLam_Idx,theta_star] = solveGivenU(...
        CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
        Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,Ppsi,nZ,init_Prod,b,rra);
      
      %Update U_u and U_l given solution to problem
      if isnan(q(theta_star))
        FirmObj = -666;
      else
        FirmObj = BETA.*EnteringF0.*q(theta_star);
      end
      for iz = 1:nZ
        if FirmObj(iz)>=ke %(This captures the case when FirmObj is nan which happens when U is too high)
          U_l(iz)=(U_u(iz)+(uSqueezeFactor - 1)*U_l(iz))/uSqueezeFactor;
        else
          U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
        end
      end
      
      tol_U = abs(FirmObj - ke);
      
    end
    
    if EnteringLam_Idx == 1 || EnteringLam_Idx == nL
      iD
      if EnteringLam_Idx == 1
        warning('Solution is Lambda = 0, workers get 0 at entry, makes no sense.')
      elseif EnteringLam_Idx == nL
        warning('Solution is lambda = LambdaMax, make lambda grid larger and rerun.')
      end
    end
    
    EnteringW_err(iD) = EnteringW_D_err(sep_pol,delta,init_Prod,E(:,EnteringLam_Idx),nPhi,U,EnteringW0);
    U_err(iD)         = U_D_err(b,rra,BETA,theta_star*q(theta_star),EnteringW0,U);
    Estar_err(iD)     = Estar_D_err(sep_pol,delta,pi_Phi,w_star_v(:,EnteringLam_Idx(iz)),rra,BETA,E(:,EnteringLam_Idx),nPhi,U);
    Vstar_err(iD)     = Vstar_D_err(nPhi,sep_pol,delta,R,K,Phi_grid,r,D,w_star_v(:,EnteringLam_Idx(iz)),tau,BETA,pi_Phi,V(:,EnteringLam_Idx(iz)));
    
    %What the firm compares to ke
    EnteringF_D(iD)     = FirmObj;
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
    
  end
  
  save
  checkingPlots
  
end
