function phi_lim = getPhiLim_Discrete(params,aalpha,phi_e,wStar,phi_db,output)

  eval(reshape(structvars(params)',1,[]))
  %Expected value of employment in the third period
  E3              = getE3(params,wStar,output,aalpha,phi_db);
  %Make sure a solution exists first
  %Solution to solve: u(w(phi)) + BETA*E3 = (1+BETA)u(b)
  %At phi_min, LHS lower, and phi_max LHS higher
  minProd         = prodFn(R,min(phi_vec),aalpha,r,prod_func_type,delta);
  if minProd <= 0
    minProd = 0;
  end
  if utilFunc(minProd) + BETA*E3 >= (1+BETA)*utilFunc(b)
    phi_lim = phi_e;
%     warning('Worker will never quit in second period')
  else
    
    phi_lim = aalpha^(1-delta) ...
        + aalpha^(-delta)*((1-ssigma)*((1+BETA)*utilFunc(b) - BETA*E3))^(1/(1-ssigma));
    if phi_lim < phi_e
        error('phi_lim cannot be smaller than phi_e')
    end

  end
end