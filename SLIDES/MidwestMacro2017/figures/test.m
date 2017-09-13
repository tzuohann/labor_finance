clear all
close all

delt           = 0.1;
b              = 0.01;
r              = 1;
COE            = 0.001;
alp_min        = 0.02;
alp_max        = 0.08;
alp            = linspace(alp_min,alp_max,10000);
phie           = r*alp.*(COE + alp).^(-delt);
A              = (1/2*(1+phie).*(COE + alp).^delt - r*alp);
B              = b*(phie + (((1 - phie).*b.*(COE + alp).^(-delt))/2) - 2);
Exp_output     = (1/2*(1-phie.^2).*(COE + alp).^delt - r*alp.*(1-phie));
Max_output     = (COE + alp).^delt - r*alp;
C              = (COE.*((2-phie).*Exp_output + B + (2-phie).*phie*b)).^(1/2)./(2-phie);
w              = Max_output - (COE + alp).^(delt/2)*2^(0.5).*C.^(0.5);
phi_dw         = phie + w.*(COE + alp).^(-delt);
V2             = (1-phie).*A - ...
      (1/2*(1-phie) + A.*(COE + alp).^(-delt)).*w + 1/2*(COE + alp).^(-delt).*w.^2;
V              = (2-phie).*V2;
E2             = phie*b + (1 - phie).*w - 1/2*((COE + alp).^(-delt)).*w.^2;
E3             = E2 + 1/2*((COE + alp).^(-delt))*b^2;
E_net          = (2-phie).*E2 + B;
E_net_check    = E2 + phie*b + (1 - phie).*E3 - 2*b;
ptheta         = E_net./(E_net + V);
qtheta         = V./(E_net + V);
U              = b + ptheta.*(E2 + phie*b + (1 - phie).*E3) + (1 - ptheta)*2*b;
U_check        = E_net.^2./(E_net + V) + 3*b;
U_worker       = b + E2 + phie*b + (1 - phie).*E3;

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
