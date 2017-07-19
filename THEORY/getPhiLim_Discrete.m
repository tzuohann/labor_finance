function phi_lim = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,alpha)
  globalDeclaration
  %Expected value of employment in the third period
  period          = 3;
  E3              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,alpha,[]);
  %Make sure a solution exists first
  %Solution to solve: u(w(phi)) + BETA*E3 = (1+BETA)u(b)
  %At phi_min, LHS lower, and phi_max LHS higher
  maxProd         = prodFn(R,max(phi_vec),alpha,r,prod_func_type,delta);
  minProd         = prodFn(R,min(phi_vec),alpha,r,prod_func_type,delta);
  if utilFunc(maxProd,ssigma,1) + BETA*E3 <= (1+BETA)*utilFunc(b,ssigma,1)
    error('Worker does not accept the job because in all states of world, worker is better off in U')
  elseif utilFunc(minProd,ssigma,1) + BETA*E3 >= (1+BETA)*utilFunc(b,ssigma,1)
    %Worker will never quit in second period
    phi_lim       = max(phi_vec);
  else
    targetProd      = ((1-ssigma)*((1+BETA)*utilFunc(b,ssigma,1) - BETA*E3))^(1/(1-ssigma));
    minProb         = @(phi) (prodFn(R,phi,alpha,r,prod_func_type,delta) - targetProd).^2;
    options         = optimoptions('fminunc');
    options.TolFun  = 1e-10;
    options.TolX    = 1e-10;
    options.Display = 'off';
    phi_lim         = fminunc(minProb,mean(phi_vec),options);
  end
end