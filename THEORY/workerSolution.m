%3 period model where in the final period, any output below b results in
%firm quitting and worker consuming b.
%In period 1, all workers are unemployed and consume b
%All action is therefore in second period.
%Under limited commitment, workers can quit in period 2.
%Phi_e is when exit is forced.
%Phi_d is where firm becomes distressed
%Phi_lim is where worker quits firm in the limited commitment case

%At fixed cost = 0, p(theta) = 1 and workers own the whole firm
%We must be able to get a hump shape in the worker's choice in this setup

clear global
close all
globalDeclaration
tau             = 0; %Taxes - %If zero no anymore tax shields!
r               = 1; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0; %Relative risk aversion.
delta           = 0.5; %decreasing return to scale active if production number 8
if ssigma == 1
  error('Use Log C')
end
BETA            = 1;%/(1+r); %Discount factor
b               = 0.1; %Value of home production

whichE3         = 'exogenous'; %exogenous vs endogenous expected value in the third period
E3_fix          = 3/2*b; %value of E3 when whichE3 is exogenous
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 8; %We use different production function to get the hump-shaped U
phi_low         = 0; %lower bound for phi
phi_up          = 1; %upper bound for phi
phi_vec         = linspace(phi_low,phi_up,5000);
alpha_min       = 0.05;
alpha_max       = 0.5;
alpha_vec       = linspace(alpha_min,alpha_max,1000);
if alpha_min > alpha_max
  error('alpha_min cannot be greater than alpha_max')
end
utilFunc = makeUtilFunc(ssigma,1);


whichCommitment = 'perfect'; %perfect vs limited commitment
[U_p,phi_e_p,phi_dw_p,phi_db_p,wStar_p,phi_lim_p] = mainLoop();
whichCommitment = 'limited'; %perfect vs limited commitment
[U_lc,phi_e_lc,phi_dw_lc,phi_db_lc,wStar_lc,phi_lim_lc] = mainLoop();

[aa, bb] = max(U_p);
% [aa_E3 bb_E3] = max(E3_vec);
if bb == length(alpha_vec)
  error('alpha_max is too small. The maximization problem is constrained by alpha_max.')
elseif bb == 1
  error('alpha_min is too large. The maximization problem is constrained by alpha_min.')
end
bbp = bb;

[aa, bb] = max(U_lc);
% [aa_E3 bb_E3] = max(E3_vec);
if bb == length(alpha_vec)
  error('alpha_max is too small. The maximization problem is constrained by alpha_max.')
elseif bb == 1
  error('alpha_min is too large. The maximization problem is constrained by alpha_min.')
end
bblc = bb;

subplot(2,1,1)
plot(alpha_vec,U_p,'.-')
hold on
plot(alpha_vec,U_lc,'.-')
legend({'PC','LC'})
plot(alpha_vec(bbp),U_p(bbp),'o')
plot(alpha_vec(bblc),U_lc(bblc),'o')
hold off

subplot(2,1,2)
plot(alpha_vec,wStar_p,'.-')
hold on
plot(alpha_vec,wStar_lc,'.-')
legend({'PC','LC'})
plot(alpha_vec(bbp),wStar_p(bbp),'o')
plot(alpha_vec(bblc),wStar_lc(bblc),'o')
hold off
