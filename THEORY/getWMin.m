function wMin = getWMin(Utarget,phi_d_fun,phi_db,phi_e,aalpha)
  globalDeclaration
  wstarmax = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  wstarmin = b;
  options = optimoptions('fmincon','Display','None');
  ptheta  = 1;
  wMin = fmincon(@(wStar)...
      (getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,whichCommitment,b,phi_vec,ssigma,BETA,ptheta)...
      - Utarget).^2,(wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);
end