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
tau             = 0; %Taxes - %If zero no anymore tax shields!
r               = 0.01; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0.4; %Relative risk aversion.
delta           = 0.5; %decreasing return to scale active if production number 8
if ssigma == 1
  error('Use Log C')
end
BETA            = 1/(1+r); %Discount factor
gamma           = 1.6; %Matching elasticity parameter
b               = 0.01; %Value of home production
phi_low         = -0.5; %lower bound for phi
phi_up          = 4; %upper bound for phi
if phi_low > phi_up
    error('phi_low cannot be greater than phi_up')
end
whichCommitment = 'perfect'; %perfect vs limited commitment
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 8; %We use different production function to get the hump-shaped U
phi_vec         = linspace(phi_low,phi_up,100000);
phi_e_func      = make_phi_e_func();
phi_d_fun       = make_phi_d_func(phi_e_func);
ptheta          = 1;
alpha_min       = 0.4;
alpha_max       = 1;
alphaGrid       = linspace(alpha_min,alpha_max,200);
% Check the boundary of the production function
all_prodFn      = prodFn(R,max(phi_vec),alphaGrid,r,prod_func_type,delta);
if all_prodFn < b
    error('Expected valued of production is always smaller than the reservation value.')
end

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
  
  %wStar is the maximum level of the production, firm gives everything to
  %the worker always
  wStar             = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
  
  %Checking the feasibility of the problem
  period          = 2;
  E2              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,[]);
  period          = 3;
  E3              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,[]);
  phi_lim         = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,aalpha);
    switch whichCommitment
    case {'perfect'}
      limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
    case{'limited'}
      limitIntegral = sum(phi_vec < phi_lim)./numel(phi_vec);
    otherwise
      error('Perfect or Limited for now')
    end
   if E2 + BETA*(1-limitIntegral)*E3 ...
         + BETA*limitIntegral*utilFunc(b,ssigma,1) <= (1+BETA)*utilFunc(b,ssigma,1)
    error('Worker does not accept the job, the expected utility of being employed is smaller thant the expected utility of being unemployed. To fix the problem you may either decrease b, increase the mean value of phi, or change the boundary of alpha')
   end
   
  %Evaluating the remaing variable 
  U(ialpha)                             = getU(wStar,phi_d_fun,phi_db,phi_e,aalpha,...
                                          whichCommitment,b,phi_vec,ssigma,BETA,ptheta);
  phi_e_vec(ialpha)                     = phi_e;
  phi_dw_vec(ialpha)                    = phi_d_fun(wStar,aalpha);
  phi_db_vec(ialpha)                    = phi_d_fun(b,aalpha);
  wStar_vec(ialpha)                     = wStar;
  phi_lim_vec(ialpha)                   = getPhiLim_Discrete(phi_d_fun,phi_db,...
                                          wStar,phi_e,aalpha);
end

[aa, bb] = max(U);
if bb == length(alphaGrid)
    error('alpha_max is too small. The maximization problem is constrained by alpha_max.')
elseif bb == 1
    error('alpha_min is too large. The maximization problem is constrained by alpha_min.')
end
w_opt = wStar_vec(bb)

% subplot(1,2,1)
% hold on
% plotyy(alphaGrid,[U;ones(size(U)).*(1+BETA+BETA^2)*utilFunc(b,ssigma,1)],alphaGrid,wStar_vec);
% legend({'U','Umin','wstar'})
% subplot(1,2,2)
% hold on
% plot(alphaGrid,[phi_e_vec;phi_db_vec]);
% legend({'phi_e','phi_db'})

figure(2)
hold on
plot(alphaGrid,U,'.')