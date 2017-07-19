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

clear
close all
globalDeclaration
tau             = 0.15; %Taxes
r               = 0.1; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0.7; %Relative risk aversion.
if ssigma == 1
  error('Use Log C')
end
BETA            = 1/(1+r); %Discount factor
gamma           = 1; %Matching elasticity parameter
b               = 0; %Value of home production
phi_low         = -0.5; %lower bound for phi
phi_up          = 4; %upper bound for phi
whichCommitment = 'limited'; %perfect vs limited commitment
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 7; %We use different production function to get the hump-shaped U
delta           = 10; %decreasing return to scale active if production number 3
alphaGrid       = linspace(0.01,4,200);
phi_vec         = linspace(phi_low,phi_up,100000);

phi_e_func      = make_phi_e_func();
phi_d_fun       = make_phi_d_func(phi_e_func);
ptheta          = 1;

for ialpha = 1:numel(alphaGrid)
  aalpha          = alphaGrid(ialpha);
  phi_e           = phi_e_func(aalpha);
  %Make sure that phi_e is within phi_up and phi_low
  if phi_e < phi_low
    phi_e = phi_low;
  elseif phi_e > phi_up
    phi_e = phi_up;
  end
  phi_db          = phi_d_fun(b,aalpha);
  if phi_db < phi_low
    phi_db = phi_low;
  elseif phi_db > phi_up
    phi_db = phi_up;
  end
  if phi_db < phi_e
    error('Phi_e is not greater than phi_db') 
  end
  wStar                                   = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  [U(ialpha) limitIntegral_vec(ialpha)]   = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,ptheta);
  phi_e_vec(ialpha)                       = phi_e;
  phi_dw_vec(ialpha)                      = phi_d_fun(wStar,aalpha);
  phi_db_vec(ialpha)                      = phi_d_fun(b,aalpha);
  wStar_vec(ialpha)                       = wStar;
end
subplot(1,2,1)
plotyy(alphaGrid,[U;ones(size(U)).*(1+BETA+BETA^2)*utilFunc(b,ssigma,1)],alphaGrid,wStar_vec);
legend({'U','Umin','wstar'})
subplot(1,2,2)
plot(alphaGrid,[phi_e_vec;phi_db_vec]);
legend({'phi_e','phi_db'})
figure(2)
plot(alphaGrid,limitIntegral_vec)
