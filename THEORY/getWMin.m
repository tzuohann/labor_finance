function wMin = getWMin(params,Utarget,aalpha,phi_e,output)
	eval(reshape(structvars(params)',1,[]));
  wstarmax = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  wstarmin = b;
  options = optimoptions('fmincon','Display','None');
  ptheta  = 1;
  phi_cutoff = getPhiCutoff(params,aalpha,phi_e,wstarmax);
  wMin = fmincon(@(wStar)...
      (getU(params,output,phi_cutoff,wStar,ptheta,aalpha)...
      - Utarget).^2,(wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);
end