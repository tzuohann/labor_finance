function master()
  %%%%% worker utility U(c)= C^(1-rra)/(1-rra)
  %%%%% mathing function is CES as in schaal
  
  clear
  close all
  
  %Make comments in the parameterizationFile on what is going on.
  %Use a new file for each parameterization that does something
  parameterizationFile
%   commitType = 'perfect';
%   [dm.p.U_D,dm.p.EnteringW_err_D,dm.p.U_err_D,dm.p.Estar_err_D,...
%     dm.p.Vstar_err_D,dm.p.ExpPVOutput_D,dm.p.EnteringF_D,dm.p.Q_D,...
%     dm.p.P_D,dm.p.EnteringW_D,dm.p.EnteringLam_Idx_D,dm.p.EnteringLam,...
%     dm.p.sepPol_D,dm.p.wages_D,dm.p.dividends_D,dm.p.TP_D,dm.p.Estar_D,...
%     dm.p.Vstar_D,dm.p.massE_D,dm.p.massU,dm.p.massEnt] = ...
%     mainDynamicLoop(K,tau,r,R,rra,BETA,delta,gamma_matching,b,Ppsi,...
%     commitType,typeu,costofentry,prodcurve,Phi_grid,D_grid,Lambda_vect_ws0,...
%     CV_tol,Niter,nPhi,nL,pi_Phi,Lambda_vect,pi_z,nZ,init_Prod,CV_tol_U,...
%     maxIter_U,uSqueezeFactor);
  
  commitType = 'limited';
    [dm.l.U_D,dm.l.EnteringW_err_D,dm.l.U_err_D,dm.l.Estar_err_D,...
      dm.l.Vstar_err_D,dm.l.ExpPVOutput_D,dm.l.EnteringF_D,dm.l.Q_D,...
      dm.l.P_D,dm.l.EnteringW_D,dm.l.EnteringLam_Idx_D,dm.l.EnteringLam,...
      dm.l.sepPol_D,dm.l.wages_D,dm.l.dividends_D,dm.l.TP_D,dm.l.Estar_D,...
      dm.l.Vstar_D,dm.l.massE_D,dm.l.massU,dm.l.massEnt] = ...
      mainDynamicLoop(K,tau,r,R,rra,BETA,delta,gamma_matching,b,Ppsi,...
      commitType,typeu,costofentry,prodcurve,Phi_grid,D_grid,Lambda_vect_ws0,...
      CV_tol,Niter,nPhi,nL,pi_Phi,Lambda_vect,pi_z,nZ,init_Prod,CV_tol_U,...
      maxIter_U,uSqueezeFactor);
  2.288404282436217
  [dm.l.wages_D,dm.p.wages_D,dm.p.Estar_D,dm.l.Estar_D,dm.p.Vstar_D,dm.l.Vstar_D]
  
  save
  %   checkingPlots
  
end
