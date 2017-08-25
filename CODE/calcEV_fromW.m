function [E,V,w_star_v,iLp_star] = calcEV_fromW(CV_tol,Niter,nPhi,nL,sep_pol,delta,pi_Phi,...
    Phi_grid,BETA,Lambda_vect,w_star_pre,U,r,K,D,tau,w_star_pre_cons,commitType,preTaxOutput)
  
  iLp_star                  = ones(nPhi,nPhi,nL);
  w_star_v                  = w_star_pre;
  w_star_v(sep_pol == 1,:)  = nan;
  Ep                        = zeros(nPhi,nL);
  Vp                        = zeros(nPhi,nL);
  
  U2                        = (max(sep_pol,delta)).*U';
  dividends                 = (1-tau)*(bsxfun(@minus,preTaxOutput,w_star_pre));
  
  separatedStates           = isnan(w_star_pre);
  w_star_pre_cons(isnan(w_star_pre_cons)) = 0;
  dividends(isnan(dividends))             = 0;
  
  tol  = 1;
  Iter = 0;
  while (tol > CV_tol && Iter < Niter)
    Iter = Iter +1;
    if Iter == Niter
      error('Maximum Iteration E/V reached')
    end
    switch commitType
      %Perfect commitment case sped up to the MAXXXXXXX
      case{'perfect'}
        %Utility of consuming plus continuation
        E  = w_star_pre_cons + BETA*pi_Phi*bsxfun(@plus,bsxfun(@times,(1-max(sep_pol,delta)),Ep),U2);
        %Dividends of plus continuation
        V  = dividends  + BETA*pi_Phi*bsxfun(@times,(1-max(sep_pol,delta)),Vp);
      case{'limited'}
%         keyboard
        
      otherwise
        error('Commitment type not specifed correctly.')
    end
    tol = max(max(abs(E - Ep))) + max(max(abs(V - Vp)));
    Ep = E;
    Vp = V;
  end
  E(separatedStates) = nan;
  V(separatedStates) = nan;
  switch commitType
    case{'perfect'}
      for il = 1:nL
        iLp_star(:,:,il) = il;
      end
    case{'limited'}  
  end
end
