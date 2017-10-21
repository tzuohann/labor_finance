clear all
close all

%Exogenous Parameters
b        = 0.1; %value of leisure
W        = 0.025; %initial net worth
lam      = 0.05; %on the job search fraction
alp      = 1/3; %curvature of the production function
r        = 1; %interest rate
D_min    = 0; %minimum level of debt
D_max    = 0.5; %maximum level of debt
gam      = 1; %efficiency of the matching function
D        = linspace(D_min,D_max,1000); %Grid over debt choice


%Endogenous Parameters
phib           = (r*D + b)./((W + D).^alp);
H              = 1/2*(W + D).^alp - r*D + 1/2*phib.*(r*D + b);
Max_output     = (W + D).^alp - r*D;
w_star         = Max_output ...
               - (2*((W + D).^alp)*(W^(gam/(1+gam))).*((H - b).^(1/(1+gam)))).^(1/2);
phiw           = (r*D + w_star)./((W + D).^alp); 
E              = phib*b + (phiw - phib).*(1/2*(phiw + phib).*(W + D).^alp - r*D) ...
               + (1 - phiw).*w_star;
V              = (1 - phiw).*(1/2*(1 + phiw).*(W + D).^alp - r*D - w_star);
if sum(abs(V + E - H)) > 10^(-10)
      error('V, E, or H is wrong')
end
p_theta        = ((E - b)./(E + V - b)).^(1/gam);
q_theta        = (V./(E + V - b)).^(1/gam);
U = b + p_theta.*(E - b);
[max_U loc_U]  = max(U);
[max_H loc_H]  = max(H);
[max_E loc_E]  = max(E);
[max_V loc_V]  = max(V);

%On the Job Search
w_star_ojs             = Max_output ...
                       - ((2*((W + D).^alp)*(W^(gam/(1+gam)))...
                       .*((H - b).^(1/(1+gam))))/(1-lam)).^(1/2);
p_theta_ojs            = (((1-lam)*E + lam*H - b)./((1-lam)*E + lam*H + lam*V - b)).^(1/gam);
q_theta_ojs            = (((1-lam)*V)./((1-lam)*E + lam*H + lam*V - b)).^(1/gam);
U_ojs                  = b + p_theta_ojs.*((1-lam)*E + lam*H - b);
[max_U_ojs loc_U_ojs]  = max(U_ojs);


