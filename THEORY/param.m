function [params,tech] = param(i_FC)
  %Global variables consume the most running time.
  
  %Economic Parameters
  params.tau             = 0; %Taxes
  params.r               = 1; %Return on capital.
  params.R               = params.r/(1-params.tau); %Gross return on capital
  params.ssigma          = 0; %Relative risk aversion.
  if params.ssigma == 0
      display('Worker is risk neutral')
  end
  assert(params.ssigma  >= 0 || params.ssigma < 1,'ssigma must be [0,1)')
  params.BETA            = 1; %1/(1+params.r); %Discount factor
  params.gamma_matching  = 1; %Matching elasticity parameter
  params.b               = 0.2; %Value of home production
  if params.b == 0
      warning('b is equal to zero: wp should be equal to wl and sp should be equal to sl.')
  end
  params.E3_fix          = NaN; %Exogenous value of E3.If whichE3 is endogenous doesnt matter
  params.Lifetime_Achievement_Award  = NaN; %Exogenous expected profit in period 3 if match is not broken
  params.whichCommitment = 'limited'; %perfect vs limited commitment
  params.whichE3         = 'endogenous'; %exogenous vs endogenous expected value in the third period
  params.FC_min          = 0.03;
  params.FC_max          = 0.12;
  params.length_FC       = 50;
  params.fix_cost_grid   = [linspace(params.FC_min,params.FC_max,params.length_FC)]; %Fixed cost of entry. Should be equal to K (equal to 1)
  params.fix_cost        = params.fix_cost_grid(i_FC);
  assert(params.fix_cost > 0,'The firm is fully owned by the worker. Use file: workerSolution.m')
  params.prod_func_type  = 8; %We use different production function to get the hump-shaped U
  params.delta           = 0.1; %decreasing return to scale active if production number 8
  assert(params.delta < 1,'The production function implies increasing returns to scale.')
  typeu                  = 1;
  
  params.phi_e_func      = make_phi_e_func(params.prod_func_type,params.r,params.R,params.delta);
  params.phi_d_fun       = make_phi_d_func(params.phi_e_func,params.prod_func_type,params.R,params.r,params.delta);
  params.utilFunc        = makeUtilFunc(params.ssigma,typeu);
  %Technical Parameters
  alpha_min              = 0.01;
  alpha_max              = 0.1;
  params.alpha_fix       = NaN;
  lenAalpha              = 20;
  phi_low                = 0; %lower bound for phi
  phi_up                 = 1; %upper bound for phi
  lenPphi                = 10000;
  
  %Grids
  %alpha grid. Given parameters we start with lowest alpha and go almost to 1
  params.phi_vec      = linspace(phi_low,phi_up,lenPphi);
  tech.alpha_vec      = linspace(alpha_min,alpha_max,lenAalpha);
  tech.tol            = 10^(-7); %tolerance to get convergence
  
  
  %Checking if b is too high for this production function
  prodFn_max          = prodFn(params.R,max(params.phi_vec),tech.alpha_vec,params.r,params.prod_func_type,params.delta);
  if prodFn_max < params.b
    error('Expected valued of production is always smaller than the reservation value.')
  end
  
end