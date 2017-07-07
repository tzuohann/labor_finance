%Parameterization
globalDeclaration

%Economic Parameters
tau = 0.01; %Taxes
r = 0.2; %Return on capital.
R = r/(1-tau); %Gross return on capital
ssigma = 0.5; %Relative risk aversion.
BETA = exp(-r); %Discount factor
gamma = 0.75; %Matching elasticity parameter
b = 0.1; %Value of home production
phi_low = -1; %lower bound for phi
phi_up = 1; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
fix_cost = 0.45; %Fixed cost of entry. Should be equal to K (equal to 1)

%Technical Parameters
tol             = 10^(-8); %tolerance to get convergence
max_iter        = 1000; %maximum number of iteration
max_iter_alpha  = 20; %maximum number of iteration for the following alpha loop
alpha_test      = 0.01; %initial value of alpha
err_alpha       = 1; %initial value of err_alpha
k               = 0; %initial value for counting the iterations of the loops
alpha_low       = 0.5;
alpha_high      = 4;
lenAalpha       = 20;
lenPphi         = 50000;

%Grids
%alpha grid. Given parameters we start with lowest alpha and go almost to 1
alpha_vec = linspace(alpha_low,alpha_high,lenAalpha);
phi_vec = linspace(phi_low,phi_up,lenPphi);