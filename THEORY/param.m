%Parameterization
globalDeclaration

%Economic Parameters
tau             = 0.01; %Taxes
r               = 0.2; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0.5; %Relative risk aversion.
BETA            = 1/(1+r); %Discount factor
gamma           = 1.5; %Matching elasticity parameter
b               = 0; %Value of home production
phi_low         = 0; %lower bound for phi
phi_up          = 4; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 8; %We use different production function to get the hump-shaped U
delta           = 0.5; %decreasing return to scale active if production number 8

%Technical Parameters
tol             = 10^(-8); %tolerance to get convergence
max_iter        = 1000; %maximum number of iteration
max_iter_alpha  = 20; %maximum number of iteration for the following alpha loop
err_alpha       = 1; %initial value of err_alpha
k               = 0; %initial value for counting the iterations of the loops
alpha_low       = 1;
alpha_high      = 2;
lenAalpha       = 20;
lenPphi         = 50000;
sigma_low       = 0.5; %for the loop of sigma varying
sigma_high      = 0.5;
lenSsigma       = 1;

%Grids
%alpha grid. Given parameters we start with lowest alpha and go almost to 1
alpha_vec       = linspace(alpha_low,alpha_high,lenAalpha);
phi_vec         = linspace(phi_low,phi_up,lenPphi);
sigma_vec       = linspace(sigma_low,sigma_high,lenSsigma); %for the loop of sigma varying