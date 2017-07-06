%Parameterization

%Economic Parameters
K = 1; %Fixed required capital normalized to 1.
tau = 0.01; %Taxes
r = 0.2; %Return on capital.
R = r/(1-tau); %Gross return on capital
sigma = 0.5; %Relative risk aversion.
BETA = exp(-r); %Discount factor
gamma = 0.75; %Matching elasticity parameter
b = 0; %Value of home production
phi_low = -1; %lower bound for phi
phi_up = 1; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
w_min = b; %minimum level of wage
w_max = R + phi_up; %maximum level of wage

%Technical Parameters
tol = 10^(-8); %tolerance to get convergence
max_iter = 1000; %maximum number of iteration
max_iter_alpha = 20; %maximum number of iteration for the following alpha loop
alpha_test = 0.01; %initial value of alpha
err_alpha = 1; %initial value of err_alpha
k = 0; %initial value for counting the iterations of the loops


