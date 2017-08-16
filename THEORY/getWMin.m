function wMin = getWMin(params,Utarget,aalpha,phi_e,output,phi_db)
	eval(reshape(structvars(params)',1,[]));
  wstarmax = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  wstarmin = b;
  options = optimoptions('fmincon','Display','None');
  ptheta  = 1;
  phi_cutoff = getPhiCutoff(params,aalpha,phi_e,wstarmax,output,phi_db);
  wMin = fmincon(@(wStar)...
      (getU(params,output,phi_cutoff,wStar,ptheta,aalpha,phi_db)...
      - Utarget).^2,(wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);
end

 

% U = u(b) + beta E2(w) + phi_cutoff*beta*u(b) + (1-phi_cutoff)*E3 