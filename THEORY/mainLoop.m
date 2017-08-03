function [U,phi_e_vec,phi_dw_vec,phi_db_vec,wStar_vec,phi_lim_vec] = mainLoop()
  globalDeclaration
  params.b = b;
  params.whichE3 = whichE3;
  params.E3_fix = E3_fix;
  params.R = R;
  params.r = r;
  params.phi_vec = phi_vec;
  params.prod_func_type = prod_func_type;
  params.delta = delta;
  params.utilFunc = utilFunc;
  params.BETA = BETA;
  params.ssigma = ssigma;
  params.whichCommitment = whichCommitment;
  
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
    U(ialpha)                             = getU(params,output,phi_cutoff,wStar,ptheta,aalpha);
    phi_e_vec(ialpha)                     = phi_e;
    phi_dw_vec(ialpha)                    = phi_d_fun(wStar,aalpha);
    phi_db_vec(ialpha)                    = phi_d_fun(b,aalpha);
    wStar_vec(ialpha)                     = wStar;
    phi_lim_vec(ialpha)                   = phi_cutoff;
  end
end
