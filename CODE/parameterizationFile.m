%This paramterization file should contain comments on what each
%paramterization file accomplishes.

%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0.1;          %Taxes
r                   = 0.5;          %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
rra                 = 0.5;          %Relative risk aversion.
BETA                = 1/(1+r);      %Discount factor
delta               = 0.05;         %Exogenous separation probability.
gamma_matching      = 0.5;            %Matching elasticity parameter
b                   = 0;            %Value of home production
psi                 = 0;            %fraction of recovered firm value if failed search

%Aggregate productivity shock -- muted for now
z_0                 = 1;
nZ                  = 1;
pi_z                = 1;
iz                  = 1;

%Worker productivity shock
nPhi                = 30;
rho_Phi             = 0.0000001;
mean_Phi            = 0.12;
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
nL                  = 1000;
LambdaMax           = 0.5;
Lambda_vect         = linspace(0,LambdaMax,nL);   % Lagrange multiplier grid
Lambda_vect_ws0     = (Lambda_vect/(1-tau)).^(1/rra);

% inner loop
Niter               = 500;
CV_tol              = 0.00001;

% outer loop
maxIter_U           = 1000;
CV_tol_U            = 0.00001;

%%% Optimizing grid over Debt D
%Choose debt so that it is both inbetween 0 and 1 and increases
%separations as a function of D
nD                  = 20;
D_grid              = linspace(0,0.99*K,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 10;