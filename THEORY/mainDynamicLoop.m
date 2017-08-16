function [U_store,w_store,vacancies,p_theta,q_theta,obj_store,...
    phi_e_store,phi_lim_store,w_store_max,w_store_min,E2_store,E3_store,E_store]...
    = mainDynamicLoop(params,tech)
  
  eval(reshape(structvars(params)',1,[]));
  eval(reshape(structvars(tech)',1,[]));
  
  %Evaluate optimal w, U, vacancies given alpha
  for ia = 1:length(alpha_vec) %loop over alpha, we do for all the possible alphas
    disp(['alpha = ',num2str(ia)])
    %Technical parameters
    err_alpha          = 1; %initial value for err_U
    aalpha             = alpha_vec(ia);
    
    %These quantities depend only on alpha and not on U
    phi_e     = phi_e_func(aalpha);
    phi_db    = phi_d_fun(params.b,aalpha);
    output    = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
    
    %Boundaries of U
    U_min                     = (1+BETA+BETA^2)*utilFunc(b);
    [U_max,E2_up,E3_up]       = getUMax(params,aalpha,phi_e,output,U_min,phi_db);
    checkFeasibility(params,aalpha,phi_e,E2_up,E3_up,output,phi_db)
    [~,firmValUMin,~,~] = solveGivenU(U_min,params,aalpha,phi_e,output,phi_db);
    [~,firmValUMax,~,~] = solveGivenU(U_max,params,aalpha,phi_e,output,phi_db);
    if firmValUMin > fix_cost && firmValUMax < fix_cost
      while err_alpha > tol
        U       = (U_min + U_max)/2; %bisectional U
        
        [wstar,firmVal,w_min,w_max]   = solveGivenU(U,params,aalpha,phi_e,output,phi_db);
        
        if firmVal > fix_cost;
          U_min = U;
        else
          U_max = U;
        end
        err_alpha = abs(firmVal - fix_cost);
        err_U = abs(U_max - U_min);
        if err_U < 1e-14
          error('Some strangeness has occured in minimization over U');
        end
      end
      
      f = @(w) getf(params,w,phi_e,aalpha,U,output,phi_db);
      g = @(w) getg(params,w,aalpha,output,phi_e);
      
      U_store(ia)           = U;
      w_store(ia)           = wstar;
      w_store_max(ia)       = w_max;
      w_store_min(ia)       = w_min;
      vacancies(ia)         = (f(wstar)^(-gamma_matching) - 1)^(-1/gamma_matching);
      p_theta(ia)           = f(wstar);
      q_theta(ia)           = p_theta(ia)/vacancies(ia);
      obj_store(ia)         = firmVal;
      phi_e_store(ia)       = phi_e;
      phi_lim_store(ia)     = getPhiCutoff(params,aalpha,phi_e,wstar,output,phi_db);
      phi_dw_store(ia)      = phi_d_fun(wstar,aalpha);
      phi_db_store(ia)      = phi_d_fun(b,aalpha);
      E2_store(ia)          = calcExpectedUtil(params,output,phi_lim_store(ia),wstar);
      E3_store(ia)          = getE3(params,wstar,output,aalpha,phi_db);
      E_store(ia)           = getE(params,wstar,output,phi_lim_store(ia),E3_store(ia),E2_store(ia));
      
    else
        if firmValUMax      > fix_cost
            U_store(ia)           = NaN;
            vacancies(ia)         = NaN;
            p_theta(ia)           = NaN;
            q_theta(ia)           = NaN;
            obj_store(ia)         = NaN;
            phi_e_store(ia)       = NaN;
            phi_lim_store(ia)     = NaN;
            w_store(ia)           = NaN;
            w_store_max(ia)       = NaN;
            w_store_min(ia)       = NaN;
            phi_dw_store(ia)      = NaN;
            phi_db_store(ia)      = NaN;
            E2_store(ia)          = NaN;
            E3_store(ia)          = NaN;
            E_store(ia)           = NaN;
            warning('firmValUMax is greater than the cost of entry. No solution available')
        elseif firmValUMin  < fix_cost
            U_store(ia)           = NaN;
            vacancies(ia)         = NaN;
            p_theta(ia)           = NaN;
            q_theta(ia)           = NaN;
            obj_store(ia)         = NaN;
            phi_e_store(ia)       = NaN;
            phi_lim_store(ia)     = NaN;
            w_store(ia)           = NaN;
            w_store_max(ia)       = NaN;
            w_store_min(ia)       = NaN;
            phi_dw_store(ia)      = NaN;
            phi_db_store(ia)      = NaN;
            E2_store(ia)          = NaN;
            E3_store(ia)          = NaN;
            E_store(ia)           = NaN;
            warning('firmValUMin is smaller than the cost of entry. No solution available')
        end
    end
  end
end

function [wstar,firmVal,w_min,w_max] = solveGivenU(U,params,aalpha,phi_e,output,phi_db)
  
  %wmin has to be a function of U while w_max doesn't change
  w_min   = getWMin(params,U,aalpha,phi_e,output,phi_db);
  w_max    = max(output);
  if w_min <= 0
    error('w_min cannot be lower than zero.')
  elseif w_max <= w_min
    error('w_max cannot be smaller than w_min.')
  end
  
  gridW   = linspace(w_min,w_max,100);
  
  %First ensure that for U, there is a solution to the problem
  if getf(params,gridW(end),phi_e,aalpha,U,output,phi_db) > 1
    firmVal = -666;
    wstar   = nan;
  else
    obj = @(w) getObjFunc(w,params,aalpha,phi_e,output,U,phi_db); %We max this guy!
    
    options = optimoptions('fmincon','Display','None','TolX',1e-8,'TolFun',1e-8);
    wstarint = fmincon(obj,(w_min + w_max)/2,[],[],[],[],w_min,w_max,[],options);
    
    %Consider the interiors as well
    wstarvec  = [w_min,wstarint,w_max];
    [~,wstar] = min([obj(w_min),obj(wstarint),obj(w_max)]);
    wstar     = wstarvec(wstar);
    firmVal   = -obj(wstar);
  end
end




