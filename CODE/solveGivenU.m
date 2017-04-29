function [TP,gp_star,w_star_v,EU_vect,...
        V,F,FirmObj,EnteringW0,EnteringLam_Idx,theta_star] = solveGivenU(...
        CV_tol,Niter,nPhi,nG,sep_pol,sigma,pi_Phi,...
        Phi_grid,BETA,gamma_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons,psi,nZ,init_Prod,b,rra)
  
  % Solve the SPP
  [TP,gp_star,w_star_v,EU_vect] = solvePareto(CV_tol,Niter,nPhi,nG,sep_pol,sigma,pi_Phi,...
    Phi_grid,BETA,gamma_vect,w_star_pre,U,pi_z,r,K,D,tau,w_star_pre_cons);
  
  % Converting the solution from Lagrange multiplier space to promised value space
  [V,F] = calcVF(TP,nPhi,nG,gamma_vect,U,gp_star,sep_pol,psi,K,D);
  
  %Solve the search problem
  [FirmObj,EnteringW0,EnteringLam_Idx,theta_star] = ...
    solveSearch(nZ,init_Prod,sigma,V,F,U,BETA,EU_vect,b,rra,gamma_vect);
end

