function [U,phi_e_vec,phi_dw_vec,phi_db_vec,wStar_vec,phi_lim_vec] = mainLoop()
  globalDeclaration
  phi_e_func      = make_phi_e_func();
  phi_d_fun       = make_phi_d_func(phi_e_func);
  ptheta          = 1;
  for ialpha = 1:numel(alpha_vec)
    aalpha          = alphaGrid(ialpha);
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
    
    %Checking the feasibility of the problem
    phi_lim         = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,aalpha);
    if phi_lim < phi_e
      error('phi_lim cannot be smaller than phi_e')
    end
    period          = 2;
    E2              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    period          = 3;
    E3              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    
    switch whichCommitment
      case{'perfect'}
        limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
      case{'limited'}
        limitIntegral = sum(phi_vec < phi_lim)./numel(phi_vec);
      otherwise
        error('Perfect or Limited for now')
    end
    if E2 + BETA*(1-limitIntegral)*E3 ...
        + BETA*limitIntegral*utilFunc(b,ssigma,1) <= (1+BETA)*utilFunc(b,ssigma,1)
      error('Worker does not accept the job, the expected utility of being employed is smaller thant the expected utility of being unemployed. To fix the problem you may either decrease b, increase the mean value of phi, or change the boundary of alpha')
    end
    
    %Evaluating the remaing variable
    U(ialpha)                             = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,...
      whichCommitment,b,phi_vec,ssigma,BETA,ptheta);
    phi_e_vec(ialpha)                     = phi_e;
    phi_dw_vec(ialpha)                    = phi_d_fun(wStar,aalpha);
    phi_db_vec(ialpha)                    = phi_d_fun(b,aalpha);
    wStar_vec(ialpha)                     = wStar;
    phi_lim_vec(ialpha)                   = getPhiLim_Discrete(phi_d_fun,phi_db,...
      wStar,phi_e,aalpha);
  end
end
