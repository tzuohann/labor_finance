%This paramterization file should contain comments on what each
%paramterization file accomplishes.

%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0.2;          %Taxes
rra                 = 0.2;          %Relative risk aversion.
r                   = 0.05;          %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
BETA                = 1/(1+r);      %Discount factor
delta               = 0.05;         %Exogenous separation probability.
gamma_matching      = 1.25;         %Matching elasticity parameter
b                   = 0.01;          %Value of home production
Ppsi                = 0;            %fraction of recovered firm value if failed search
commitType          = 'perfect';    %Limited or perfect;
typeu               = 1;            %Utility type

%Aggregate productivity shock -- muted for now
z_0                 = 1;
nZ                  = 1;
pi_z                = 1;
iz                  = 1;

%Worker productivity shock
nPhi                = 40;
rho_Phi             = 0.9;
mean_Phi            = 0.0048;
sigma_Phi           = 0.015;
m_Phi               = 3;
[Phi_grid, pi_Phi]  = mytauchen(mean_Phi,rho_Phi,sigma_Phi,nPhi,m_Phi);


% Initial productivity distrib
init_Prod           = pi_Phi^100;
init_Prod           = init_Prod(1,:)';
init_Prod(:)        = 0;
init_Prod(end)      = 1;

%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%
nL                  = 500;
LambdaMax           = 0.5;
Lambda_vect         = linspace(0,LambdaMax,nL);   % Lagrange multiplier grid
Lambda_vect_ws0     = Lambda_util_type(rra,Lambda_vect,tau,typeu);

% inner loop
Niter               = 500;
CV_tol              = 0.0000001;

% outer loop
maxIter_U           = 1000;
CV_tol_U            = 0.0000001;

%%% Optimizing grid over Debt D
%Choose debt so that it is both inbetween 0 and 1 and increases
%separations as a function of D
nD                  = 10;
D_grid              = linspace(0.35,0.37,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 2;

setupPlot