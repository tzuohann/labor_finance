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
    output    = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
    
    %Boundaries of U
    U_min                   = (1+BETA+BETA^2)*utilFunc(b);
    [U_max,E2_up,E3_up]     = getUMax(params,aalpha,phi_e,output,U_min);
    checkFeasibility(params,aalpha,phi_e,E2_up,E3_up,output)
    solved = 1;
    while err_both > tol && k < max_iter
      k       = k + 1; %Iteration
      U       = (U_min + U_max)/2; %bisectional U
      
      %wmin has to be a function of U while w_max doesn't change
      w_min   = getWMin(params,U,aalpha,phi_e,output);
      if w_min <= 0
        error('w_min cannot be lower than zero.')
      end
      w_max    = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
      if w_max <= w_min
        error('w_max cannot be smaller than w_min.')
      end
      gridW   = linspace(w_min,w_max,100);
      
      %First ensure that for U, there is a solution to the problem
      if getf(params,gridW(end),phi_e,aalpha,U,output) > 1
        U_max = U; %Bisection U, we decrease it
      else
        
        f = @(w) getf(params,w,phi_e,aalpha,U,output);
        g = @(w) getg(params,w,aalpha,output,phi_e);
        obj = @(w) getObjFunc(w,params,aalpha,phi_e,output,U); %We max this guy!
        
        options = optimoptions('fmincon','Display','None','TolX',tol,'TolFun',tol);
        
        if ia == 1
          wstar = fmincon(obj,(w_min + w_max)/2,[],[],[],[],w_min,w_max,[],options);
        else
          wstar = fmincon(obj,w_store(ia-1),[],[],[],[],w_min,w_max,[],options);
        end
        
        if -obj(wstar) > fix_cost;
          U_min = U;
        else
          U_max = U;
        end
        err_alpha = abs(fix_cost + obj(wstar));
        err_U = abs(U_max - U_min);
        if err_U < 1e-14
          U
          U_min
          fix_cost
          -obj(wstar)
          warning('Fix cost is too high to find a solution. No solution even at U = Umin');
          solved = 0;
          err_both = 0;
        else
          err_both = err_U + err_alpha;
        end
      end
      
      if k == max_iter
        warning('No Feasible Solution')
        solved = 0;
      end
    end
    
    if solved == 1
      U_store(ia)         = U;
      w_store(ia)         = wstar;
      vacancies(ia)       = (f(wstar)^(-gamma_matching) - 1)^(-1/gamma_matching);
      p_theta(ia)         = f(wstar);
      q_theta(ia)         = p_theta(ia)/vacancies(ia);
      obj_store(ia)       = -obj(wstar);
      phi_e_store(ia)     = phi_e;
      phi_lim_store(ia)   = getPhiCutoff(params,aalpha,phi_e,wstar);
    else
      U_store(ia)         = nan;
      w_store(ia)         = nan;
      vacancies(ia)       = nan;
      p_theta(ia)         = nan;
      q_theta(ia)         = nan;
      obj_store(ia)       = nan;
      phi_e_store(ia)     = nan;
      phi_lim_store(ia)   = nan;
    end
  end
end

