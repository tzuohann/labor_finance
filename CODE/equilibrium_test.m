% Clear and close previous material
clear all
close all

% Loading equilibrium matrices form 'Code_Mar2017_v2.m'
load wages_D %Wages, this works because Entering_Lam is identical in all states
load Vstar_D %Value of worker in each state of the world - this is E in the draft
load U_D %Value of unemployment
load TP_D %Saddle point problem solution
load sepPol_D %Separation policy
load Q_D %Matching probability p
load P_D %Matching probability p
load massU %Steady state distribution of unemployment
load massEnt %Steady state distribution of entring?
load massE_D %Steady state distribution of Employment
load Fstar_D %Value of firm in each state of the world
load EnteringW_D %Promised worker value conditional on matching. What's offered in the search market.
load EnteringLam_Idx_D %This tells us how much of lambda is actually used
load EnteringF_D %What the firm compares to ke
load dividends_D %Dividends, this works because Entering_Lam is identical in all states

% Parameterization from 'Code_Mar2017_v2.m'
K = 1; %Fixed required capital normalized to 1.
tau = 0.5; %Taxes
r = 0.5; %Return on capital.
R = r/(1-tau); %Gross return on capital
rra = 0.5; %Relative risk aversion.
BETA = 1/(1+r); %Discount factor
delta = 0.05; %Exogenous separation probability.
gamma_matching = 2; %Matching elasticity parameter
b = 0; %Value of home production
psi = 0; %fraction of recovered firm value if failed search
nD = 10; %grid for debt

%Worker productivity shock
nPhi = 30;
rho_Phi = 0.9;
delta_Phi = 0.15;
mean_Phi = 0.10;
Phi_grid            = linspace(-r/(1-tau),0.5,nPhi)';
pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,delta_Phi); 
%Initial productivity distrib
init_Prod           = zeros(size(Phi_grid));
init_Prod(end)      = 1; 

% Equilibirum conditions for U
U_test = ones(1,nD); %prealloacating matrix
U_test = ones(1,nD)*utilFunc(b,rra) + BETA*(P_D.*EnteringW_D + (1 - P_D).*U_D); %I am using P_D!
U_err = max(abs(U_test - U_D)) %error - it is very small! Very good Tzuo =)

% Equilibrium condition for entering W - W_sigma^(phi_0)
% Shall I use the separation policy here?
initial_prob = pi_Phi(end,:);
EnteringW_D_test = initial_prob*((ones(nPhi,nD) - sepPol_D).*Vstar_D + sepPol_D.*repmat(U_D,nPhi,1));
EnteringW_D_err = max(abs(EnteringW_D_test - EnteringW_D)) %here the error is different from zero

%Equilibrium for the value of employment (E in the draft) 
% Here I did it for the initial value of phi (the last one) since I do not
% know the value of W in steady state. I know at the begininning which is
% EnteringW_D
Vstar_D_test = utilFunc(wages_D(end,:),rra) + BETA.*EnteringW_D;
Vstar_D_err = max(abs(Vstar_D_test - Vstar_D(end,:)))

%Equilibrium condition for the firm's value
Fstar_D_test = pi_Phi(end,:)*((ones(nPhi,nD) - sepPol_D).*Vstar_D);
Fstar_D_err = max(abs(Fstar_D_test-Fstar_D(end,:)))












