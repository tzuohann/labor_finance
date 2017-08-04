function [U_store,w_store,vacancies,p_theta,q_theta,obj_store,...
    phi_e_store,phi_lim_store,w_store_max,w_store_min,E1_store] = mainLoop(params,tech)
  
  eval(reshape(structvars(params)',1,[]));
  eval(reshape(structvars(tech)',1,[]));
  
  phi_e_func      = make_phi_e_func(prod_func_type,r,R,delta);
  phi_d_fun       = make_phi_d_func(phi_e_func,prod_func_type,R,r,delta);
  ptheta          = 1;
  for ialpha = 1:numel(alpha_vec)
    aalpha          = alpha_vec(ialpha);
    % Check the boundary of the production function
    prodFn_max      = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
    if prodFn_max < b
      error('Expected valued of production is always smaller than the reservation value.')
    end
    phi_e           = phi_e_func(aalpha);
    %Make sure that phi_e is within phi_up and phi_low
    if phi_e < min(phi_vec)
      phi_e = min(phi_vec);
    elseif phi_e > max(phi_vec)
      phi_e = max(phi_vec);
    end
    phi_db          = phi_d_fun(b,aalpha);
    if phi_db < min(phi_vec)
      phi_db = min(phi_vec);
    elseif phi_db > max(phi_vec)
      phi_db = max(phi_vec);
    end
    if phi_db < phi_e
      error('Phi_e is not greater than phi_db')
    end
    
    %wStar is the maximum level of the production, firm gives everything to
    %the worker always
    wStar           = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
    output          = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
    
    %Checking the feasibility of the problem
    phi_cutoff      = getPhiCutoff(params,aalpha,phi_e,wStar);
    E2              = calcExpectedUtil(params,output,phi_cutoff,wStar);
    E3              = getE3(params,wStar,output);
    
    switch whichCommitment
      case{'perfect'}
        limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
      case{'limited'}
        limitIntegral = sum(phi_vec < phi_cutoff)./numel(phi_vec);
      otherwise
        error('Perfect or Limited for now')
    end
    if E2 + BETA*(1-limitIntegral)*E3 ...
        + BETA*limitIntegral*utilFunc(b) <= (1+BETA)*utilFunc(b)
      error('Worker does not accept the job, the expected utility of being employed is smaller thant the expected utility of being unemployed. To fix the problem you may either decrease b, increase the mean value of phi, or change the boundary of alpha')
    end
    
    %Evaluating the remaing variable
    U_store(ialpha)                       = getU(params,output,phi_cutoff,wStar,ptheta,aalpha);
    phi_e_store(ialpha)                   = phi_e;
    phi_dw_store(ialpha)                  = phi_d_fun(wStar,aalpha);
    phi_db_store(ialpha)                  = phi_d_fun(b,aalpha);
    w_store(ialpha)                       = wStar;
    phi_lim_store(ialpha)                 = phi_cutoff;
    w_store_max(ialpha)                   = wStar;
    w_store_min(ialpha)                   = wStar;
    vacancies(ialpha)                     = nan;
    p_theta(ialpha)                       = 1;
    q_theta(ialpha)                       = nan;
    obj_store(ialpha)                     = nan;
    E1_store(ialpha)                      = E2;
  end
end
