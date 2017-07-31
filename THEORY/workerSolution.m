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
r               = 1; %Return on capital.
R               = r/(1-tau); %Gross return on capital
ssigma          = 0; %Relative risk aversion.
delta           = 0.5; %decreasing return to scale active if production number 8
if ssigma == 1
    error('Use Log C')
end
BETA            = 1;%/(1+r); %Discount factor
b               = 0.1; %Value of home production
phi_low         = 0; %lower bound for phi
phi_up          = 1; %upper bound for phi
if phi_low > phi_up
    error('phi_low cannot be greater than phi_up')
end
whichCommitment = 'perfect'; %perfect vs limited commitment
whichE3         = 'exogenous'; %exogenous vs endogenous expected value in the third period
E3_fix          = 3/2*b; %value of E3 when whichE3 is exogenous
fix_cost        = 0; %Fixed cost of entry. Should be equal to K (equal to 1)
prod_func_type  = 8; %We use different production function to get the hump-shaped U
phi_vec         = linspace(phi_low,phi_up,100000);
phi_e_func      = make_phi_e_func();
phi_d_fun       = make_phi_d_func(phi_e_func);
ptheta          = 1;
alpha_min       = 0.1;
alpha_max       = 0.22;
if alpha_min > alpha_max
    error('alpha_min cannot be greater than alpha_max')
end
alphaGrid       = linspace(alpha_min,alpha_max,200);
% Check the boundary of the production function
prodFn_max      = prodFn(R,max(phi_vec),alphaGrid,r,prod_func_type,delta);
if prodFn_max < b
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
    wStar           = prodFn(R,max(phi_vec),aalpha,r,prod_func_type,delta);
    
    %Checking the feasibility of the problem
    phi_lim         = getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,aalpha);    
    if phi_lim < phi_e
        error('phi_lim cannot be smaller than phi_e')
    end
    period          = 2;
    E2              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    period          = 3;
    E3              = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    
    switch whichCommitment
        case{'perfect'}
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
    %   period = 2;
    %   whichCommitment = 'perfect'; %perfect vs limited commitment
    %   E2_p = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    %   whichCommitment = 'limited'; %perfect vs limited commitment
    %   E2_l = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim);
    %   E2_p_vec(ialpha)                      = E2_p;
    %   E2_l_vec(ialpha)                      = E2_l;
    %   E3_vec(ialpha)                        = E3;
    %   proof(ialpha)                         = (phi_lim-phi_e)*(b*(1+BETA) - 1/2*aalpha^delta*(phi_e + phi_lim) ...
    %                                         - aalpha - BETA*E3);
    
end

[aa, bb] = max(U);
% [aa_E3 bb_E3] = max(E3_vec);
if bb == length(alphaGrid)
    error('alpha_max is too small. The maximization problem is constrained by alpha_max.')
elseif bb == 1
    error('alpha_min is too large. The maximization problem is constrained by alpha_min.')
end
aa
w_opt = wStar_vec(bb);

U_p = @(alp) b + BETA*((alp^(1-delta)*b*(1+BETA) ...
    + (1-alp^(1-delta))*(1/2*alp^delta*(1+alp^(1-delta)) - alp) ...
    +  BETA*(1-alp^(1-delta))*(((alp+b)^2)/(2*alp^delta) + 1/2*alp^delta - alp)));
U_p(alphaGrid(bb))
dU_p = @(alp) 1/2*alp^(-1 - 2 *delta) *BETA *(-alp^(1 + 2 *delta) *(2 + 3 *BETA) + ...
    alp^(3* delta) *(1 + BETA)* delta + ...
    alp* (alp + b)* BETA *(-3 *alp - b + 2* (alp + b)* delta) - ...
    alp^delta* (alp^2 *(1 + 3* BETA)* (-2 + delta) + ...
    2* alp* b *(1 + 2 *BETA)* (-1 + delta) + b^2* BETA* delta));

plot(alphaGrid,arrayfun(dU_p,alphaGrid),'*')


% subplot(1,2,1)
% hold on
% plotyy(alphaGrid,[U;ones(size(U)).*(1+BETA+BETA^2)*utilFunc(b,ssigma,1)],alphaGrid,wStar_vec);
% legend({'U','Umin','wstar'})
% subplot(1,2,2)
% hold on
% plot(alphaGrid,[phi_lim_vec-phi_e_vec]);
% legend({'phi_l-phi_e'})
% %
% figure(2)
% hold on
% plot(alphaGrid,[E2_p_vec;E2_l_vec;E3_vec;U])
% legend('E2_perfect','E2_limited','E3','U')
% [maxval,maxalpha] = max(E2_p_vec);
% [maxval2,maxalpha2] = max(E2_l_vec);
% [maxval3,maxalpha3] = max(E3_vec);
% [maxval4,maxalpha4] = max(U);
% plot(alphaGrid(maxalpha),maxval,'*')
% plot(alphaGrid(maxalpha2),maxval2,'*')
% plot(alphaGrid(maxalpha3),maxval3,'*')
% plot(alphaGrid(maxalpha4),maxval4,'*')



figure(3)
plot(alphaGrid,U,'*')