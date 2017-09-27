clear all
close all

%Parameterization
delt           = 0.1; %parameter of the decreasing return to scale
b              = 0.2; %worker outside option
r              = 1; %interest rate to owe to the bank
COE            = 0.005; %initial endowment (initial equity)
alp_min        = 0.001; %minimum level of debt
alp_max        = 0.3; %maximum level of debt
alp            = linspace(alp_min,alp_max,10000); %Grid over debt choice

%Endogenous functions
phie           = r*alp.*(COE + alp).^(-delt); %probability of default
A              = (1/2*(1+phie).*(COE + alp).^delt - r*alp); %Technical object
B              = b*(phie + (((1 - phie).*b.*(COE + alp).^(-delt))/2) - 2); %Technical object
Exp_output     = (1/2*(1-phie.^2).*(COE + alp).^delt - r*alp.*(1-phie)); 
Max_output     = (COE + alp).^delt - r*alp;
C              = (COE.*((2-phie).*Exp_output + B + (2-phie).*phie*b)).^(1/2)./(2-phie); %Technical object
w              = Max_output - (COE + alp).^(delt/2)*2^(0.5).*C.^(0.5); %wage
phi_dw         = phie + w.*(COE + alp).^(-delt); %probability of having zero profits
V2             = (1-phie).*A - ...
      (1/2*(1-phie) + A.*(COE + alp).^(-delt)).*w + 1/2*(COE + alp).^(-delt).*w.^2; 
V              = (2-phie).*V2; %firm's value for a given match
E2             = phie*b + (1 - phie).*w - 1/2*((COE + alp).^(-delt)).*w.^2;
E3             = E2 + 1/2*((COE + alp).^(-delt))*b^2;
E_net          = (2-phie).*E2 + B; %employment's value for a given match
E_net_check    = E2 + phie*b + (1 - phie).*E3 - 2*b;
ptheta         = E_net./(E_net + V); %worker's prob of matching
qtheta         = V./(E_net + V); %firm's prob of matching
U              = b + ptheta.*(E2 + phie*b + (1 - phie).*E3) + (1 - ptheta)*2*b; %Value of unemployment
U_check        = E_net.^2./(E_net + V) + 3*b;

%Worker solution - Set w equal to Max_output
E2_worker      = phie*b + (1 - phie).*Max_output - 1/2*((COE + alp).^(-delt)).*Max_output.^2;
E3_worker      = E2_worker + 1/2*((COE + alp).^(-delt))*b^2;
U_worker       = b + E2_worker + phie*b + (1 - phie).*E3_worker;
E_worker_fake  = b + E2_worker + E3_worker;

%Some checks
if sum(abs(E_net - E_net_check)) > 10^(-8)
      display('Net value of employment is wrong')
end
if sum(abs(E2 + V2 - Exp_output - phie*b)) > 10^(-8)
      display('Either E2 or V2 is wrong')
end
if sum(abs(E_net + V - (2-phie).*(Exp_output + phie*b) - B)) > 10^(-8)
      display('Either E_net or V is wrong')
end
if sum(abs(U - U_check)) > 10^(-8)
      display('Value of unemployment is wrong')
end

%Optimal Ds
[max_w               loc_D_w]                = max(w);
[max_Exp             loc_D_Exp]              = max(Exp_output);
[max_U               loc_D_U]                = max(U);
[max_U_worker        loc_D_U_worker]         = max(U_worker);
[max_ptheta          loc_D_ptheta]           = max(ptheta);
[max_qtheta          loc_D_qtheta]           = min(qtheta);
[max_V               loc_D_V]                = max(V);
[max_V2              loc_D_V2]               = max(V2);
[max_Ey              loc_D_Ey]               = max((2-phie).*(Exp_output + phie*b) + B);

if loc_D_U - loc_D_U_worker > 0
      display('Worker Solution and Search Solution are different')
end

%Plots
figure(1)
newPosition = [1 41 1920 963];
newUnits = 'normalized';
set(gcf,'Position', newPosition,'Units', newUnits);
hL.Orientation = 'horizontal';
hL.FontSize = 16;

subplot(2,2,1)
hold on
plot(alp,U,'LineWidth',2,'Color','b')
plot(alp,w,'LineWidth',2,'Color','r')
plot(alp,U_worker,'LineWidth',2,'Color','k')
plot(alp,Exp_output,'LineWidth',2,'Color','g')
plot(alp(loc_D_U),U(loc_D_U),'*')
plot(alp(loc_D_w),w(loc_D_w),'*')
plot(alp(loc_D_U_worker),U_worker(loc_D_U_worker),'*')
grid on
xlabel('Grid over D') % x-axis label
% ylabel('Value of Unemployment') % y-axis label
legend('Unemployment','Wage','Worker Solution')
title('Optimal level of Debt')
hold off

subplot(2,2,2)
hold on
plot(alp,ptheta,'LineWidth',2,'Color','b')
plot(alp,qtheta,'LineWidth',2,'Color','r')
plot(alp(loc_D_U),ptheta(loc_D_U),'*')
plot(alp(loc_D_U),qtheta(loc_D_U),'*')
grid on
xlabel('Grid over D') % x-axis label
% ylabel('Value of Unemployment') % y-axis label
legend('p(\theta)','q(\theta)')
title('Probabilities of Matching')
hold off

subplot(2,2,3)
hold on
plot(alp,V,'LineWidth',2,'Color','b')
plot(alp,V2,'LineWidth',2,'Color','r')
plot(alp(loc_D_U),V(loc_D_U),'*')
plot(alp(loc_D_U),V2(loc_D_U),'*')
grid on
xlabel('Grid over D') % x-axis label
% ylabel('Value of Unemployment') % y-axis label
legend('V','V2')
title('Firm Values')
hold off

figure(2)
hold on
plot(alp,E_worker_fake,'LineWidth',2,'Color','b')
plot(alp,U_worker,'LineWidth',2,'Color','r')
plot(alp,E2_worker,':','LineWidth',1,'Color','r')
plot(alp,E3_worker,'--','LineWidth',1,'Color','r')
plot(alp(loc_D_U_worker),U_worker(loc_D_U_worker),'*')
[ciccio loc_D_E_worker_fake] = max(E_worker_fake);
plot(alp(loc_D_E_worker_fake),E_worker_fake(loc_D_E_worker_fake),'*')
[ciccio loc_D_E2_worker] = max(E2_worker);
[ciccio loc_D_E3_worker] = max(E3_worker);
plot(alp(loc_D_E2_worker),E2_worker(loc_D_E2_worker),'*')
plot(alp(loc_D_E3_worker),E3_worker(loc_D_E3_worker),'*')
grid on
xlabel('Grid over D') % x-axis label
legend('E worker fake','U','E2','E3')
title('First Proposition')
hold off






