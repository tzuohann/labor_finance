%This paramterization file should contain comments on what each
%paramterization file accomplishes.

%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0.2;          %Taxes
r                   = 0.2;          %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
rra                 = 0.5;          %Relative risk aversion.
BETA                = 1/(1+r);      %Discount factor
delta               = 0.05;         %Exogenous separation probability.
gamma_matching      = 0.75;         %Matching elasticity parameter
b                   = 0.1;          %Value of home production
Ppsi                = 0;            %fraction of recovered firm value if failed search
commitType          = 'perfect';    %Limited or perfect;
typeu               = 1;            %Utility type

%Aggregate productivity shock -- muted for now
z_0                 = 1;
nZ                  = 1;
pi_z                = 1;
iz                  = 1;

%Worker productivity shock
nPhi                = 10;
rho_Phi             = 0.0000001;
mean_Phi            = 0.3;
sigma_Phi           = 0.2;
m_Phi               = 3;
[Phi_grid, pi_Phi]  = mytauchen(mean_Phi,rho_Phi,sigma_Phi,nPhi,m_Phi);
%Make this random
pi_Phi(:)           = 1/nPhi;

% Initial productivity distrib
init_Prod           = pi_Phi^100;
init_Prod           = init_Prod(1,:)';

%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%
nL                  = 600;
LambdaMax           = 0.75;
Lambda_vect         = linspace(0,LambdaMax,nL);   % Lagrange multiplier grid
Lambda_vect_ws0     = Lambda_util_type(rra,Lambda_vect,tau,typeu);

% inner loop
Niter               = 500;
CV_tol              = 0.000001;

% outer loop
maxIter_U           = 1000;
CV_tol_U            = 0.000001;

%%% Optimizing grid over Debt D
%Choose debt so that it is both inbetween 0 and 1 and increases
%separations as a function of D
nD                  = 4;
D_grid              = linspace(0,0.5*K,nD);
% D_grid              = linspace(0,0.052105263157895,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 10;