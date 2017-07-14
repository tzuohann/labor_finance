%What is the worker's optimal choice.5
clear
close
globalDeclaration
tau             = 0.2; %Taxes
r               = 0.2; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0.5; %Relative risk aversion.
BETA            = 1/(1+r); %Discount factor
gamma           = 1; %Matching elasticity parameter
b               = 0.4; %Value of home production
phi_low         = -1; %lower bound for phi
phi_up          = 1; %upper bound for phi
whichCommitment = 'perfect'; %perfect vs limited commitment
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 1; %We use different production function to get the hump-shaped U
alphaGrid       = linspace(0,100,1000);
phi_vec         = linspace(phi_low,phi_up,50000);
delta           = 0.9; %decreasing return to scale production number 3

phi_e_func      = make_phi_e_func(delta);
phi_d_fun       = make_phi_d_func(phi_e_func);
ptheta          = 1;

for ialpha = 1:numel(alphaGrid)
    aalpha          = alphaGrid(ialpha);
    phi_e           = phi_e_func(aalpha);
    phi_db          = phi_d_fun(b,aalpha);
    wStar           = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
    U(ialpha)       = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,whichCommitment,b,phi_vec,ssigma,BETA,ptheta,delta);
end
plot(alphaGrid,U);