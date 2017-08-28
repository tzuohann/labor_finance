function wMin    = getWMin(params,Utarget,aalpha,phi_e,output,phi_db)

eval(reshape(structvars(params)',1,[]));
wMin = b;
%   wstarmax       = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
%   wstarmin       = b;
%   options        = optimoptions('fmincon','Display','None');
%   ptheta         = 1;
%   wMin           = fmincon(@(wStar)...
%       (getU(params,output,getPhiCutoff(params,aalpha,phi_e,wStar,output,phi_db),...
%       wStar,ptheta,aalpha,phi_db)- Utarget).^2,...
%       (wstarmax + wstarmin)/2,[],[],[],[],wstarmin,wstarmax,[],options);

end



% U = u(b) + beta E2(w) + phi_cutoff*beta*u(b) + beta^2 (1-phi_cutoff)*E3(w)