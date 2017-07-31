%Parameterization
globalDeclaration

%Economic Parameters
tau             = 0; %Taxes
r               = 0.2; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0; %Relative risk aversion.
if ssigma == 1
    error('RRA is equal to 1, use instead the logarithmic function.')
end
BETA            = 1/(1+r); %Discount factor
gamma           = 1.5; %Matching elasticity parameter
b               = 0.1; %Value of home production
E3_fix          = 3/2*b; %Exogenous value of E3.If whichE3 is endogenous doesnt matter
Lifetime_Achievement_Award  = E3_fix/2; %Exogenous expected profit in period 3 if match is not broken 
phi_low         = 0; %lower bound for phi
phi_up          = 10; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
whichE3         = 'exogenous'; %exogenous vs endogenous expected value in the third period
fix_cost        = 0.01; %Fixed cost of entry. Should be equal to K (equal to 1)
if fix_cost == 0
    error('The fixed cost is equal to zero. The firm is fully owned by the worker. Use file: workerSolution.m for this specific case.')
end
prod_func_type  = 8; %We use different production function to get the hump-shaped U
delta           = 0.5; %decreasing return to scale active if production number 8
if delta >= 1
    error('delta is equal or greater than one. The production function implies increasing returns to scale.')
end

%Technical Parameters
tol             = 10^(-8); %tolerance to get convergence
max_iter        = 1000; %maximum number of iteration
max_iter_alpha  = 20; %maximum number of iteration for the following alpha loop
err_alpha       = 1; %initial value of err_alpha
k               = 0; %initial value for counting the iterations of the loops
alpha_min       = 11.075;
alpha_max       = 11.125;
lenAalpha       = 20;
lenPphi         = 50000;
sigma_low       = 0; %for the loop of sigma varying
sigma_high      = 0;
if sigma_high >= 1
    error('For now sigma (RRA) can only be [0,1)')
end
lenSsigma       = 1;

%Grids
%alpha grid. Given parameters we start with lowest alpha and go almost to 1
alpha_vec       = linspace(alpha_min,alpha_max,lenAalpha);
phi_vec         = linspace(phi_low,phi_up,lenPphi);
sigma_vec       = linspace(sigma_low,sigma_high,lenSsigma); %for the loop of sigma varying

%Checking if b is too high for this production function
prodFn_max      = prodFn(R,max(phi_vec),alpha_vec,r,prod_func_type,delta);
if prodFn_max < b
    error('Expected valued of production is always smaller than the reservation value.')
end