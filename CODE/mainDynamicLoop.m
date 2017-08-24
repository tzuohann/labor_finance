function [U_D,EnteringW_err_D,U_err_D,Estar_err_D,Vstar_err_D,ExpPVOutput_D,...
    EnteringF_D,Q_D,P_D,EnteringW_D,EnteringLam_Idx_D,EnteringLam,sepPol_D,...
    wages_D,dividends_D,TP_D,Estar_D,Vstar_D,massE_D,massU,massEnt]...
    = mainDynamicLoop(K,tau,r,R,rra,BETA,delta,gamma_matching,b,Ppsi,...
    commitType,typeu,costofentry,prodcurve,Phi_grid,D_grid,Lambda_vect_ws0,...
    CV_tol,Niter,nPhi,nL,pi_Phi,Lambda_vect,pi_z,nZ,init_Prod,CV_tol_U,...
    maxIter_U,uSqueezeFactor)
  
  %%%%%%%%%%%%%%%%%%%%%%
  % Core code
  %%%%%%%%%%%%%%%%%%%%%%
  for iD = 1:numel(D_grid)
    D = D_grid(iD);
    ke = costofentry;
    disp(' ')
    disp(['Calculating for iD = ',num2str(iD)])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%Variables that only depend on D %%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    preTaxOutput                = outputFunc(K,r,tau,Phi_grid,D,prodcurve);
    sep_pol                     = preTaxOutput*(1-tau) <= 0;  %Endogenous separation policy
    %Wages and utility from consuming wages
    w_star0                     = Lambda_vect_ws0;
    w_cons                      = preTaxOutput;
    posDiv                      = bsxfun(@minus,preTaxOutput,w_star0) >= 0;
    w_star_pre                  = bsxfun(@times,w_star0,posDiv) + bsxfun(@times,w_cons,(1-posDiv));
    w_star_pre(w_star_pre < 0)  = nan;
    w_star_pre_cons             = utilFunc(w_star_pre,rra,typeu);
    
    %lowest possible utlity is consuming b forever
    U_min                       = utilFunc(b,rra,typeu)/(1-BETA);
    %highest possible utlity is consuming all production always
    U_max                       = utilFunc(max(preTaxOutput)*(1-tau),rra,typeu)/(1-BETA);
    
    %Check that there is entry at U_min
    [~,~,~,~,~,EnteringF0,~,~,theta_star] = solveGivenU(CV_tol,Niter,nPhi,...
      nL,sep_pol,delta,pi_Phi,Phi_grid,BETA,Lambda_vect,w_star_pre,U_min,...
      pi_z,r,K,D,tau,w_star_pre_cons,Ppsi,nZ,init_Prod,b,rra,commitType,typeu,...
      preTaxOutput,gamma_matching);
    if BETA*EnteringF0*q(theta_star,gamma_matching) > ke
    else
      error('No entry at U_min')
    end
    
    %Initialize U levels
    U_l     = U_min*ones(nZ,1);
    U_u     = U_max*ones(nZ,1);
    tol_U   = 10000000;
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
      [TP,iLp_star,w_star_v,...
        E,V,EnteringF0,EnteringW0,EnteringLam_Idx,theta_star] = solveGivenU(...
        CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
        Phi_grid,BETA,Lambda_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,...
        Ppsi,nZ,init_Prod,b,rra,commitType,typeu,preTaxOutput,gamma_matching);
      
      %Update U_u and U_l given solution to problem
      if isnan(q(theta_star,gamma_matching))
        FirmObj = -666;
      else
        FirmObj = BETA.*EnteringF0.*q(theta_star,gamma_matching);
      end
      for iz = 1:nZ
        if FirmObj(iz)>=ke %(This captures the case when FirmObj is nan which happens when U is too high)
          U_l(iz)=(U_u(iz)+(uSqueezeFactor - 1)*U_l(iz))/uSqueezeFactor;
        else
          U_u(iz)=((uSqueezeFactor - 1)*U_u(iz)+U_l(iz))/uSqueezeFactor;
        end
      end
      
      tol_U = abs(FirmObj - ke)./ke;
      disp(sprintf('iD = %3i, iU = %3i, tol_U = %6.2d, ke = %6.2d',iD,iter_U,tol_U,ke))
      disp(sprintf('FO = %7.2d, Ul = %6.2d, U = %6.2d, Uu = %6.2d',FirmObj,U_l,U,U_u));
      
      disp('')
    end
    
    %CHeck solution for correctness
    if EnteringLam_Idx == 1 || EnteringLam_Idx == nL
      iD
      if EnteringLam_Idx == 1
        warning('Solution is Lambda = 0, workers get 0 at entry, makes no sense.')
      elseif EnteringLam_Idx == nL
        warning('Solution is lambda = LambdaMax, make lambda grid larger and rerun.')
      end
    end
    
    EnteringW_err_D(iD) = EnteringW_err(sep_pol,delta,init_Prod,E(:,EnteringLam_Idx),nPhi,U,EnteringW0);
    U_err_D(iD)         = U_err(b,rra,BETA,theta_star*q(theta_star,gamma_matching),EnteringW0,U,typeu);
    Estar_err_D(iD)     = Estar_err(sep_pol,delta,pi_Phi,w_star_v,rra,BETA,E,nPhi,U,typeu,iLp_star,nL);
    Vstar_err_D(iD)     = Vstar_err(sep_pol,delta,pi_Phi,w_star_v,BETA,V,nPhi,iLp_star,nL,R,K,Phi_grid,r,D,tau);
    PVOutput            = PVProd(nPhi,sep_pol,delta,R,K,Phi_grid,r,D,w_star_v(:,EnteringLam_Idx(iz)),tau,BETA,pi_Phi,CV_tol);
    
    %Expected dividends plus wages
    ExpPVOutput_D(iD)   = init_Prod'*PVOutput;
    %What the firm compares to ke
    EnteringF_D(iD)     = EnteringF0;
    %Firm matching probability q
    Q_D(iD)             = q(theta_star,gamma_matching);
    %Worker matching probability p
    P_D(iD)             = theta_star*q(theta_star,gamma_matching);
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
end