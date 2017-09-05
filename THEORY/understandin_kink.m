clear all
close all

%Exogenous Parameters
alp            = 0.05;
delt           = 0.1;
phie           = alp^(1-delt);
A              = (1/2*(1+phie)*alp^delt - alp);
Exp_output     = (1/2*(1-phie^2)*alp^delt - alp*(1-phie));
Max_output     = alp^delt - alp;
which_COE      = 'L';
switch which_COE
      case{'H'}
            COE            = 0.25;
      case{'right'}
            COE            = 0.12371854952;
      case{'L'}
            COE            = 0.12;
end

%Grid for w
w              = linspace(0,1,1000000);

%Functions
phi_dw         = phie + w*alp^(-delt);
Vt_check       = 1/2*(1 - phi_dw.^2)*alp^delt - (1 - phi_dw).*(alp + w);
Vt             = (1-phie)*A - (1/2*(1-phie)+A*alp^(-delt)).*w + 1/2*alp^(-delt).*w.^2;
if sum(abs(Vt_check - Vt)) > 10^(-10)
      error('Analytical solution for Vt is wrong.')
end
Et             = (1 - (Vt./Exp_output)).*Exp_output;
Et_check       = (1 - phie)*w - 1/2*alp^(-delt)*w.^2; 
if sum(abs(Et - Et_check)) > 10^(-10)
      error('Analytical solution of Et is wrong.')
end
CE_int         = (2 - phie)*Vt.^2./Exp_output;
CE_con         = (1 - phie)*Vt;
U_int          = (2 - phie)*Et.^2./Exp_output;
U_con          = Et;

%Locations
set_loc        = find(U_int-U_con > 0,2,'first');
set_loc        = set_loc(2);
set_loc_con    = find(CE_con - COE < 0,1,'first');
set_loc_int    = find(CE_int - COE < 0,1,'first');

%Analytical wage
w_check_int    = Max_output - alp^(delt/2)*2^(0.5)*(COE/(2-phie)*Exp_output)^(0.25);
if abs(w(set_loc_int) - w_check_int) > 10^(-5)
      warning('Analytical interior solution for wstar is wrong.')
end
w_check_con    = Max_output - alp^(delt/2)*(2*COE/(1-phie))^(0.5);
if abs(w(set_loc_con) - w_check_con) > 10^(-5)
      warning('Analytical constrained solution for wstar is wrong.')
end
      
%Checks

%P of theta
p_int          = U_int(set_loc_int)/((2-phie)*Et(set_loc_int));
if p_int > 1 || p_int < 0
      display('p(theta) is greater than 1.')
end
%q of theta
q_int          = 1 - p_int;
if q_int > 1 || p_int < 0
      display('p(theta) is greater than 1.')
end

%wstar
w_int          = w(set_loc_int);
if w_int - Exp_output > 0
      display('wstar is greater than expected output.')
end

%Cost of Entry
CE_int_check   = (1-U_int(set_loc_int)/((2-phie)*Et(set_loc_int))).*(2-phie)*Vt(set_loc_int);
if abs(CE_int_check - COE) > 10^(-5)
      display('Firm does not reach the cost of entry.')
end

%Value of unemployment
U_int_check    = p_int*Et(set_loc_int)*(2-phie);
if abs(U_int_check - U_int(set_loc_int)) > 10^(-5)
      display('U is not consistent with the equilibrium wage.')
end

asd

%Plots
figure(1)
newPosition = [1 41 1920 963];
newUnits = 'normalized';
set(gcf,'Position', newPosition,'Units', newUnits);
hL.Orientation = 'horizontal';
hL.FontSize = 16;

subplot(2,3,1)
hold on
plot(w,CE_int,'LineWidth',2,'Color','b')
plot(w,CE_con,'LineWidth',2,'Color','r')
line([w(set_loc) w(set_loc)],[0 .7])
plot(w,ones(1,length(w))*COE)
legend('Interior Solution','Constrained Solution')
grid on
xlabel('Grid over w') % x-axis label
ylabel('Cost of Entry') % y-axis label
title('Cost of Entry')
axis([0 .6 0 .6])
hold off

subplot(2,3,2)
hold on
plot(w,U_int,'LineWidth',2,'Color','b')
plot(w,U_con,'LineWidth',2,'Color','r')
line([w(set_loc) w(set_loc)],[0 .7])
plot(w(set_loc_int),U_int(set_loc_int),'*')
plot(w(set_loc_con),U_con(set_loc_con),'*')
legend('Interior Solution','Constrained Solution')
grid on
xlabel('Grid over w') % x-axis label
ylabel('Value of Unemployment') % y-axis label
title('Value of Unemployment')
axis([0 .6 0 .6])
hold off

subplot(2,3,3)
hold on
plot(w,Et,'LineWidth',2,'Color','b')
plot(w,Vt,'LineWidth',2,'Color','r')
line([w(set_loc) w(set_loc)],[0 .7])
plot(w(set_loc_int),Et(set_loc_int),'*')
plot(w(set_loc_con),Vt(set_loc_con),'*')
legend('E_t','V_t')
grid on
xlabel('Grid over w') % x-axis label
ylabel('E_t, V_t') % y-axis label
title('Value at period t of employment and firm')
axis([0 .6 0 .6])
hold off

subplot(2,3,4)
hold on
plot(w,(1-phie)*Et,'LineWidth',2,'Color','b')
plot(w,(1-phie)*Vt,'LineWidth',2,'Color','r')
line([w(set_loc) w(set_loc)],[0 .7])
plot(w(set_loc_int),(1-phie)*Et(set_loc_int),'*')
plot(w(set_loc_con),(1-phie)*Vt(set_loc_con),'*')
legend('(1-\phi_e)E_t','(1-\phi_e)V_t')
grid on
xlabel('Grid over w') % x-axis label
ylabel('(1-\phi_e)E_t, (1-\phi_e)V_t') % y-axis label
title('Net Value at period t of employment and firm')
axis([0 .6 0 .6])
hold off

subplot(2,3,5)
hold on
plot(w,(2-phie)*Et,'LineWidth',2,'Color','b')
plot(w,(2-phie)*Vt,'LineWidth',2,'Color','r')
line([w(set_loc) w(set_loc)],[0 .7])
plot(w(set_loc_int),(2-phie)*Et(set_loc_int),'*')
plot(w(set_loc_con),(2-phie)*Vt(set_loc_con),'*')
legend('(2-\phi_e)E_t','(2-\phi_e)V_t')
grid on
xlabel('Grid over w') % x-axis label
ylabel('(2-\phi_e)E_t, (2-\phi_e)V_t') % y-axis label
title('Value of being employed and firm')
axis([0 .6 0 .6])
hold off

