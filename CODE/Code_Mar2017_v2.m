%%%%% LT labor contracts, search, and Capital Structure
%%% Boualam - Law - Dec 2016
%%% v1. Dec 2 - 2016
%%% This version: Feb 21 2017
%%% This version: Mar 3 2017  -- now include separation due to
%%% period-by-period budget constraint


%%%%%%%%%%%% Mar 28: Y - Still work in progress - This is the PC case,
%%%%%%%%%%%% with the period by period constraint (but with paramters that
%%%%%%%%%%%% avoid separation)


%%%%% worker utility U(c)= C^(1-rra)/(1-rra)
%%%%% mathing function is CES as in schaal



%%%
%Tzuo's Comments
%Maybe normalize to median capital
%at IPO or entry. Maybe use the Berk figure of 3m
% There is a while debate on what this number should
%be right. Explain if you know how this affects us.
%There should be something to ensure that for some value of Z, there is
%separation for sure no matter what.
%Also wonder if there is some way of making sure that there are values so
%that all firms are constrained, but not forced to exit
%Also some values of Z

clear 
close all

global gamma_matching


%%%%%%%%%%%%%%%%%%%%%%
% Model parameters
%%%%%%%%%%%%%%%%%%%%%%
K       = 1;            %Fixed required capital normalized to 1.
tau     = 0.2;          %Taxes
r       = 0.1;          %Return on capital.
R       = r/(1-tau);    %Gross return on capital
rra     = 0.5;          %Relative risk aversion.
BETA    = 0.9;          %Discount factor
sigma   = 0.025;        %Exogenous separatoin probability. We call this delta in the paper.
gamma_matching = 1.75;  %Matching elasticity parameter
b       = 0.02;         %Value of home production
psi     = 0; %fraction of recovered firm value if failed search

%Aggregate productivity shock -- muted for now
z_0     = 1;
nZ      = 1;
pi_z    = 1;
iz      = 1;


% Worker productivity shock
nPhi        = 5;
rho_Phi     = 0.9;
sigma_Phi   = 0.15;
mean_Phi    = 0.08;

mPhi        = 1;
Phi_grid    = linspace(-mPhi*sigma_Phi,mPhi*sigma_Phi,nPhi)';
pi_Phi      = create_y_mat(nPhi,Phi_grid,rho_Phi,sigma_Phi);
Phi_grid    = mean_Phi + (Phi_grid);



%%%%%%%%%%%%%%%%%%%%%%
% Technical parameters
%%%%%%%%%%%%%%%%%%%%%%

nG = 500;
nV = 500;

gamma_vect = linspace(0,1.5,nG);   % Lagrange multiplier grid
gamma_vect_ws0 = (gamma_vect/(1-tau)).^(1/rra);

% inner loop
Niter   = 300;
CV_tol  = 0.00000001;

% outer loop
maxIter_U = 600;
CV_tol_U  = 0.0000001;

%%% Optimizing grid over Debt D
nD      = 3;
D_grid  = linspace(0,K-0.1,nD);

%nD      = 1;
%D_grid  = linspace(0.8,0.8,nD);





%%%%%%%%%%%%%%%%%%%%%%
% Core code
%%%%%%%%%%%%%%%%%%%%%%

for iD = 1:nD
    tic
    
    D = D_grid(iD)
    ke = max(K-D,0);   %%%%% entry cost depends on D
    
    
    %Endogenous separation policy
    sep_pol = 1*(K*r +(Phi_grid - D*r)*(1-tau) < 0);
    
    w_star0 = gamma_vect_ws0; 
                        
    % accounting for distress case, and making sure w is positive
    bla1       = (r*K + (bsxfun(@minus,Phi_grid , w_star0) - D*r)*(1-tau) >= 0);
    
    w_star_pre = max(bsxfun(@times,w_star0,bla1) + bsxfun(@times,(r/(1-tau)*K +(Phi_grid - D*r)),(1-bla1)),0);
    w_star_pre_cons = utilFunc(w_star_pre,rra);
    
    U_min   = ((b^(1-rra))/(1-rra))/(1-BETA); % lowest possible value
    U_max   = ((max(K*r +(Phi_grid - D*r)*(1-tau))^(1-rra))/(1-rra))/(1-BETA);%6*U_min; %4
    U_l     = U_min*ones(nZ,1);
    U_u     = U_max*ones(nZ,1);
    
    
    
    
    % initial values
    U0 = U_min*ones(1,nZ);
    U = U0;
    
    P = zeros(nPhi, nG);
    TP= zeros(nPhi, nG);
    
    tol_U = 1;
    iter_U = 0;
    
    while(tol_U>CV_tol_U &&  iter_U < maxIter_U  )
        
        U       = U0;
        EU0     = pi_z*(U(:));
        EU_vect = EU0;
        
        
        
        tol  = 1;
        Iter = 0;
        
        while (tol > CV_tol && iter_U < Niter )
            
            Iter = Iter +1;
            P    = TP;
            
            
            % computing expectations
            for ig = 1:nG
                
                P_sl    = P(:,ig);
                
                P2      = (1-max(sep_pol,sigma)).*P_sl;%  + max(sep_pol,sigma)*(K-D); %% testing with K-D
                EP0     = pi_Phi*P2(:);   % this one includes separation
                EP(:,ig)    = EP0;
                
                
                EU = pi_z*U(:);
                U2 = (max(sep_pol,sigma)).*U';
                %EsigU  = pi_z*U2(:);  % mistake here..
                EsigU  = pi_Phi*U2(:);
                
                U3 = (1-sep_pol).*U';  %%%%%%should be W0, not U0%%%%%%%%%%%
                EsigU3  = pi_z*U3(:);
                
            end
            
            
            
            
            for iphi = 1:nPhi
                
                Phi = Phi_grid(iphi);
                EP_Phi0 = squeeze(EP(iphi,:));
                EsigU0 = squeeze(EsigU(iphi));
                max_EP_Phi0 = max(EP_Phi0,0);
                
                if sep_pol(iphi) < 1   % as long as there is no separation
                    
                    Obj = zeros(1,nG);
                    for ig = 1:nG
                        
                        w_star     = w_star_pre(iphi,ig);
                        
                        Obj(ig:nG) = r*K + (Phi - D*r)*(1-tau) + gamma_vect(ig)*(w_star_pre_cons(iphi,ig) +  BETA*EsigU0)  + BETA*max_EP_Phi0(ig:nG) - w_star*(1-tau);                             
                        
                        [A B0]            = min(Obj(ig:nG));
                        B                 = B0+ig-1;
                        igp_star(iphi,ig) = B;
                        gp_star(iphi,ig)  = gamma_vect(B);
                        w_star_v(iphi,ig) = w_star;                 % independent of ig
                        TP(iphi,ig)       = A;
                        
                        
                    end
                    
                end
                
            end
            
            tol = sum((TP(:) - P(:)).^2);
            
        end
        
        tol;
        
        
        
        % Converting the solution from Lagrange multiplier space to promised value space
        
        V = zeros(nPhi,nG-2);   %% Promised Value
        F = zeros(nPhi,nG-2);   %% Firm value
        
        for iphi=1:nPhi
            
            if sep_pol(iphi) ==0
                
                for irho=2:nG-1
                    V(iphi,irho-1) = (TP(iphi,irho+1) - TP(iphi,irho-1))/(2*(gamma_vect(2) - gamma_vect(1)));
                end
                
            else
                
                V(iphi,1:nG-2) = U0;
                
            end
            
        end
        
        
        for iphi=1:nPhi
            
            if sep_pol(iphi) ==0
                
                F(iphi,:) = TP(iphi,2:end-1) - gp_star(iphi,2:end-1).*V(iphi,:);
                
            else
                
                F(iphi,1:nG-2) = 0;%K-D;  %% testing with K-D instead of 0
                
            end
            
        end
        
        
        
        V_grid0 = squeeze(V(:,2:end));
        min_V = min(V_grid0 (:));
        max_V = max(V_grid0 (:));
        V_grid = linspace(min_V, max_V,nV);
        
        J0=  squeeze(F(:,2:end));
        JV = zeros(nPhi,nG);
        
        
        for iphi=1:nPhi
            
            if sum(TP(iphi,:)) >0
                
                V1 = squeeze(V_grid0(iphi,:));
                [A1, B1] = unique(V1);
                J1 = squeeze(J0(iphi,B1));
                JV(iphi,:) = interp1(A1,J1,V_grid);
                
            else
                
                JV(iphi,:) = 0;
                
            end
            
        end
        
        
        
        for iz=1:nZ
            
            Rmin = min(U0(iz));
            Rmax = max(max_V,U_max) ;
            R_grid = linspace(Rmin,Rmax,nV);
            
            rho(iz) = (U(iz) - ((b)^(1-rra))/(1-rra)- BETA* EU_vect(iz));%%%%%% ADJUST
            A0 = rho(iz)./(R_grid- BETA*EU_vect(iz));   %%%%%% ADJUST
            
            minA0 = min(A0);
            maxA0 = max(A0);
            A0 = min(max(A0,0),1);
            theta = 1./(qinv(A0));
            
            
            Phi0 = 4; % ceil(nPhi/2);  %%%%%%%%%%%%%%%%%%%%%%%%%%here for now, assumption is Phi0 is the worker productivity at inception
            
            %             V1 = squeeze(V(Phi0,:));
            %             [A1 B1] = unique(V1);
            %             J1 = squeeze(F(Phi0,B1));
            JV00                = squeeze(JV(Phi0,:))';
            JV0                 = interp1(V_grid,JV00,R_grid);
            
            FirmFun             =  q(theta).*(JV0);% + (1-q(theta))*psi*ke;   %l. 188 in in draft; second term doesnt matter for now, as psi = 0
            
            [AR BR]             = max(FirmFun);
            EnteringP0(iz)      = A0(BR)*(AR>0);
            EnteringAR(iz)      = AR;
            X                   = R_grid(BR)*(AR>0);
            FirmObj(iz)         = max(AR,0);
            EnteringW0(iz)      = X;
            
            
            [X0 Y0]             = min(abs((X) - (squeeze(V(Phi0,:)))));
            EnteringLam_Idx(iz) = max(Y0,1);
            EnteringLam(iz)     = gamma_vect(EnteringLam_Idx(iz));
            OptimalWage(iz)     = w_star_v(iphi,EnteringLam_Idx(iz) )*(AR>0);
            
            
            
            if FirmObj(iz)>=ke
                U_l(iz)=(U_u(iz)+5*U_l(iz))/6;
            else
                U_u(iz)=(5*U_u(iz)+U_l(iz))/6;
            end
            
            U0(iz)=(U_u(iz) + U_l(iz))/2;
        end
        
        
        
        iter_U =  iter_U +1;
        tol_U = sum((FirmObj(:) -ke).^2);
        
        
    end
    toc
    tol_U
    iter_U
    ke
    FirmObj_D(iD)       = FirmObj
    EnteringP0_D(iD)    = EnteringP0
    EnteringW0_D(iD)    = EnteringW0
    OptimalWage_D(iD)   = OptimalWage
    U0_D(iD)            = U0
    sep_pol'
    
end;



%%%% plot variables at contract inception, vs. debt level D
figure(1);
plot(D_grid(1:end-1), EnteringP0_D(1:end-1));

figure(2);
plot1 = plot(D_grid(1:end-1), EnteringW0_D(1:end-1));
hold on
plot2 = plot(D_grid(1:end-1), U0_D(1:end-1));
set(plot1,'DisplayName','Promised Value W');
set(plot2,'DisplayName','U');
legend4 = legend('show');
set(legend4,'location','northeast','box','off');

figure(3);
plot(D_grid(1:end-1), OptimalWage_D(1:end-1));











%%%%%%%%%%%%%%%%%%%%%%
% Dynamics - Example
%%%%%%%%%%%%%%%%%%%%%%

clear   wage_TS div_TS iGammap_TS Gammap_TS
done_idx= 0;   % done_idx =1 means separation and no contract from that point onward

T=20;
phi_vect=[ 4 3 3 4 5 5 4 4 3 3 3 3 2 2 2 1 1 2 3 3];


igamma      = EnteringLam_Idx(iz);
EnteringP   = EnteringP0(iz);

iGammap_TS(1) = igamma;
wage_TS(1)    = OptimalWage_D(1);
Gammap_TS(1)  = gamma_vect(iGammap_TS(1));
div_TS(1)     = r*K + (Phi_grid(phi_vect(1))- wage_TS(1) - D*r)*(1-tau);


for t=2:T
    
    iphi        = phi_vect(t);
    sep_TS(t)   = sep_pol(iphi);
    
    if done_idx == 0
        
        if sep_TS(t) == 1;
            
            done_idx        = 1;
            wage_TS(t)      = 0;
            iGammap_TS(t)   = 0;
            Gammap_TS(t)    = 0;
            div_TS(t)       = 0;
            
        else
            
            iGammap_TS(t)   = igp_star(iphi,igamma);
            Gammap_TS(t)    = gamma_vect(iGammap_TS(t));
            wage_TS(t)      = w_star_v(iphi,igamma);
            div_TS(t)       = r*K + (Phi_grid(iphi)- wage_TS(t) - D*r)*(1-tau);
            sep_TS(t)       = sep_pol(iphi);
            igamma          = iGammap_TS(t);
            
        end
        
    else
        
        done_idx        = 1;
        wage_TS(t)      = 0;
        iGammap_TS(t)   = 0;
        Gammap_TS(t)    = 0;
        div_TS(t)       = 0;
        sep_TS(t)       = 1;
        
    end
end


%%%%% plot dynamics
figure(5);
plot(Gammap_TS)

figure(6);
plot1= plot(Phi_grid(phi_vect),'--k')
hold on
plot2 = plot(wage_TS,'--b')
hold on
plot3 = plot(div_TS,'-r')
set(plot1,'DisplayName','\phi shock');
set(plot2,'DisplayName','wage');
set(plot3,'DisplayName','dividend');
legend4 = legend('show');
set(legend4,'location','northeast','box','off');

close all
EnteringW0_D
disp([5.3299, 6.0199 ,7.5283])
