%What is the worker's optimal choice.5
clear
close
globalDeclaration
tau             = 0.01; %Taxes
r               = 0.2; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0.5; %Relative risk aversion.
BETA            = 1/(1+r); %Discount factor
gamma           = 1; %Matching elasticity parameter
b               = 0.4; %Value of home production
phi_low         = 0; %lower bound for phi
phi_up          = 2; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 3; %We use different production function to get the hump-shaped U
alphaGrid       = linspace(0,1,1000);
phi_vec         = linspace(phi_low,phi_up,100000);
delta           = 0.9; %decreasing return to scale production number 3

phi_e_func      = make_phi_e_func(delta);
phi_d_fun       = make_phi_d_func(phi_e_func);
ptheta          = 1;

for ialpha = 1:numel(alphaGrid)
    aalpha          = alphaGrid(ialpha);
    phi_e           = phi_e_func(aalpha);
    phi_db          = phi_d_fun(b,aalpha);
    limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
    U(ialpha)   = b + ptheta*(BETA*(1+aalpha)*R - r*aalpha - 1/12*((1+aalpha)*R*phi_up - r*aalpha ...
        - max(b,((1+aalpha)*R*phi_low - r*aalpha)))^2 + BETA^2*(limitIntegral*b ...
        + (1-limitIntegral)*(1+aalpha)*R - r*aalpha - 1/12*((1+aalpha)*R*phi_up - r*aalpha ...
        - max(b,((1+aalpha)*R*phi_low - r*aalpha)))^2)) + (1-ptheta)*(BETA + BETA^2)*b;
end
plot(alphaGrid,U);