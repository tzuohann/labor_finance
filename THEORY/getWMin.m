function wMin    = getWMin(params,Utarget,aalpha,phi_e,output,phi_db)

	eval(reshape(structvars(params)',1,[]));
    
  wstarmax       = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  wstarmin       = b;
  options        = optimoptions('fmincon','Display','None');
  ptheta         = 1;
  phi_cutoff     = getPhiCutoff(params,aalpha,phi_e,wstarmax,output,phi_db); %Here, I am using
  %phi_lim for wstar = wstarmax. For the maximum w we have the largest E3
  %which implies the minimum phi_lim, which implies the highest possible U
  %over w. Thus, to have U = Utarget, wmin must be at its lowest value. For
  %example, if phi_lim is higher, then U is at lower level which implies w
  %min will increase in order to be equal to Utarget.
  wMin           = fmincon(@(wStar)...
      (getU(params,output,phi_cutoff,wStar,ptheta,aalpha,phi_db)...
      - Utarget).^2,(wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);
end

 

% U = u(b) + beta E2(w) + phi_cutoff*beta*u(b) + beta^2 (1-phi_cutoff)*E3(w)