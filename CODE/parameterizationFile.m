%This paramterization file should contain comments on what each
%paramterization file accomplishes.

%%%%%%%%%%%%%%%%%%%%
% Model parameters %
%%%%%%%%%%%%%%%%%%%%
K                   = 1;            %Fixed required capital normalized to 1.
tau                 = 0;            %Taxes
r                   = 1;            %Return on capital.
R                   = r/(1-tau);    %Gross return on capital
rra                 = 0.5;            %Relative risk aversion.
assert(rra > 0,'Risk Neutrality is not supported.')
BETA                = 1/(1+r);      %Discount factor
delta               = 0.01;         %Exogenous separation probability.
gamma_matching      = 1;            %Matching elasticity parameter
b                   = 0;            %Value of home production
Ppsi                = 0;            %fraction of recovered firm value if failed search
commitType          = 'perfect';    %Limited or perfect;
typeu               = 1;            %Utility type
costofentry         = 0.001;     %Cost of entry
prodcurve           = 0.5;          %Curvature on production function

%Aggregate productivity shock -- muted for now
z_0                 = 1;
nZ                  = 1;
pi_z                = 1;
iz                  = 1;

%Worker productivity shock
nPhi                = 10;
rho_Phi             = 0.9;
mean_Phi            = 0.2;
sigma_Phi           = 0.15;
m_Phi               = 1;
mPhi                = 1;
Phi_grid            = linspace(-mPhi*sigma_Phi,mPhi*sigma_Phi,nPhi)';
pi_Phi              = create_y_mat(nPhi,Phi_grid,rho_Phi,sigma_Phi);
Phi_grid            = mean_Phi + (Phi_grid);

warning('Uniform distribution for phi being used.')
Phi_grid            = linspace(0,1,nPhi)';
pi_Phi(:)           = 1./nPhi;

% Initial productivity distrib
init_Prod           = pi_Phi^100;
init_Prod           = init_Prod(1,:)';
init_Prod(:)        = 0; 
init_Prod(end)      = 1; 

%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%
nL                  = 1000;
Lambda_vect         = linspace(0.3,0.7,nL);   % Lagrange multiplier grid
Lambda_vect_ws0     = Lambda_util_type(rra,Lambda_vect,tau,typeu);

% inner loop
Niter               = 500;
CV_tol              = 1e-10;

% outer loop
maxIter_U           = 1000;
CV_tol_U            = 1e-6;

%%% Optimizing grid over Debt D
%Choose debt so that it is both inbetween 0 and 1 and increases
%separations as a function of D
nD                  = 5;
D_grid              = linspace(0.1,0.4,nD);

%%% Bringing the unemployment value limits in the outer loop closer
uSqueezeFactor      = 4;

setupPlot
warning('Make sure that the problem is properly parameterized.')