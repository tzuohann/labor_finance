%3 period model where in the final period, any output below b results in
%firm quitting and worker consuming b.
%In period 1, all workers are unemployed and consume b
%All action is therefore in second period.
%Under limited commitment, workers can quite in period 2.
%Phi_e is when exit is forced.
%Phi_d is where firm becomes distressed
%Phi_lim is where worker quits firm in the limited commitment case

%At fixed cost = 0, p(theta) = 1 and workers own the whole firm
%We must be able to get a hump shape in the worker's choice in this setup

clear
close
globalDeclaration
tau             = 0.15; %Taxes
r               = 0.1; %Return on capital.
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
delta           = 0.9; %decreasing return to scale active if production number 3
alphaGrid       = linspace(0,2,1000);
phi_vec         = linspace(phi_low,phi_up,50000);

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