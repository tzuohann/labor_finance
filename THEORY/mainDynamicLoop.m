function [U_store,w_store,vacancies,p_theta,q_theta,obj_store,phi_e_store,phi_lim_store] = mainDynamicLoop(params,tech)
  
  eval(reshape(structvars(params)',1,[]));
  eval(reshape(structvars(tech)',1,[]));
  
  %Evaluate optimal w, U, vacancies given alpha
  for ia = 1:length(alpha_vec) %loop over alpha, we do for all the possible alphas
    disp(['alpha = ',num2str(ia)])
    %Technical parameters
    err_both          = 1; %initial value for err_U
    k                 = 0; %initial value for counting the iterations of the loops
    aalpha            = alpha_vec(ia);
    
    %These quantities depend only on alpha and not on U
    phi_e     = phi_e_func(aalpha);
    phi_db    = phi_d_fun(b,aalpha);
    if phi_e >= phi_db
      error('phi_e cannot be greater than phi_db.')
    end
    output    = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
    wStar_up  = output(end);
    
    %Boundaries of U
    U_min     = (1+BETA+BETA^2)*utilFunc(b,ssigma,1);
    [U_max,wStar_up,E2_Up]     = getUMax(params,aalpha,phi_e,phi_db,output);
    if U_min >= U_max
      error('U_min cannot be greater than U_max. The problem may be the parameterization.')
    end
    limitIntegral = getContinuationProb();
    checkFeasibility(limitIntegral)
    
    while err_both > tol && k < max_iter
      k       = k + 1; %Iteration
      U       = (U_min + U_max)/2; %bisectional U
      
      %wmin has to be a function of U while w_max doesn't change
      w_min   = getWMin(U,phi_d_fun,phi_db,phi_e,aalpha,R,phi_vec,r,prod_func_type,...
        delta,b,whichCommitment,ssigma,BETA,whichE3,E3_fix);
      if w_min <= 0
        error('w_min cannot be lower than zero.')
      end
      w_max    = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
      if w_max <= w_min
        error('w_max cannot be smaller than w_min. The problem may be the parameterization.')
      end
      gridW   = linspace(w_min,w_max,100);
      phi_lim = getPhiLim_Discrete(phi_d_fun,phi_db,gridW(end),phi_e,aalpha,...
        R,phi_vec,r,prod_func_type,delta,whichE3,E3_fix,ssigma,BETA,b,...
        whichCommitment);
      
      %First ensure that for U, there is a solution to the problem
      if getf(gridW(end),phi_db,phi_e,phi_d_fun,aalpha,U) > 1
        disp('U is too large, lower U')
        U_max = U; %Bisection U, we decrease it
        err_U = abs(U_max - U_min);
      else
        
        f = @(w) getf(w,phi_db,phi_e,phi_d_fun,aalpha,U);
        f_max  =  f(w_max);
        f_min  =  f(w_min);
        
        g = @(w) getg(w,aalpha,phi_d_fun,phi_lim,phi_e);
        
        obj = @(w) -((1 - f(w).^gamma_matching).^(1/gamma_matching).*g(w)); %We max this guy!
        options = optimoptions('fmincon','Display','None');
        wstar = fmincon(obj,(w_min + w_max)/2,[],[],[],[],w_min,w_max,[],options);
        
        if -obj(wstar) > fix_cost;
          U_min = U;
        else
          U_max = U;
        end
        err_alpha = abs(fix_cost + obj(wstar));
        err_U = abs(U_max - U_min);
        if err_U < 10^(-14)
          error('Fix cost is too high to find a solution. If fix cost is already very close to zero then either b is too high, or phi_vec is too low.')
        end
        err_both = err_U + err_alpha;
      end
      
      if k == max_iter
        error('No Feasible Solution')
      end
    end
    
    U_store(ia)         = U;
    w_store(ia)         = wstar;
    vacancies(ia)       = (f(wstar)^(-gamma_matching) - 1)^(-1/gamma_matching);
    p_theta(ia)         = f(wstar);
    q_theta(ia)         = p_theta(ia)/vacancies(ia);
    obj_store(ia)       = -obj(wstar);
    phi_e_store(ia)     = phi_e;
    phi_lim_store(ia)   = phi_lim;
  end
end

