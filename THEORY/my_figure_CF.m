%==========================================================================
%==========================================================================
%==========================================================================

i_FC = 1;
[params,tech] = param(i_FC);

BaseName            = 'File_focus';
FileName            = [BaseName, '_i_FC',num2str(i_FC)];
load(FileName)

%==========================================================================
%==========================================================================
%==========================================================================

% i_FC = i_FC*2;
% Figure 1
% ------ U  ----------- phi_cutoff  ------  q(theta)
% ------ wstar  ------   theta   ---------  p(theta)
figure(5)

%==========================================================================

%Plotting U
subplot(2,3,1)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),U_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),U_lim,'--','LineWidth', 2,'color','r')
loc_one = find((U_per - U_lim) > 0, 1);
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(U_per - U_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('U','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off


%==========================================================================

%Plotting wstar
subplot(2,3,4)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),w_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),w_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(w_per - w_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('w','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting phi_cutoff
subplot(2,3,2)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),phi_e,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),phi_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(phi_e - phi_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('\phi_c','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting q(theta)
subplot(2,3,3)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),q_theta_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),q_theta_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(q_theta_per - q_theta_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('q(\theta)','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting theta
subplot(2,3,5)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),p_theta_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),p_theta_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(p_theta_per - p_theta_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('p(\theta)','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting p(theta)
subplot(2,3,6)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),p_theta_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),p_theta_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(p_theta_per - p_theta_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('p(\theta)','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

% Construct a Legend with the data from the sub-plots
% hL = legend(models);
% Programatically move the Legend
% newPosition = [-1919          41        1920         963];
% newUnits = 'normalized';
% set(hL,'Position', newPosition,'Units', newUnits);
hL.Orientation = 'horizontal';
hL.FontSize = 16;

%==========================================================================
%==========================================================================
%==========================================================================

%Figure 2
% ------  V  ------  V2 ------  V3
% ------  E  ------  E2 ------  E3
figure(6)

newPosition = [1 41 1920 963]; %[1          41        1920        963];
newUnits = 'normalized';
set(gcf,'Position', newPosition,'Units', newUnits);
hL.Orientation = 'horizontal';
hL.FontSize = 16;

%==========================================================================

%Plotting V
subplot(2,4,1)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),V_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),V_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(V_per - V_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('V','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting V2
subplot(2,4,2)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),V2_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),V2_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(V2_per - V2_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('V2','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting V3
subplot(2,4,3)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),V3_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),V3_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(V3_per - V3_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('V3','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting (1 - phi_cutoff)*V3
subplot(2,4,4)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),V3_net_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),V3_net_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(V3_net_per - V3_net_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('(1-\phi_c)V3','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting E
subplot(2,4,5)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),E_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),E_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(E_per - E_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('E','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting E2
subplot(2,4,6)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),E2_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),E2_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(E2_per - E2_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('E2','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting E3
subplot(2,4,7)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),E3_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),E3_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(E3_per - E3_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('E3','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

%==========================================================================

%Plotting (1 - phicutoff)*E3 + phicutoff*u(b)
subplot(2,4,8)
hold on
yyaxis left
plot(params.fix_cost_grid(1:46),E3_net_per,'LineWidth', 2,'color','b')
plot(params.fix_cost_grid(1:46),E3_net_lim,'--','LineWidth', 2,'color','r')
y1=get(gca,'ylim');
plot([params.fix_cost_grid(loc_one) params.fix_cost_grid(loc_one)],y1,'LineWidth',1)
yyaxis right
plot(params.fix_cost_grid(1:46),(E3_net_per - E3_net_lim),'--','LineWidth', 1,'color','k')
plot(params.fix_cost_grid(1:46),zeros(1,46),':','LineWidth', 1,'color','k')
title('(1-\phi_c)E3 + \phi_c u(b)','FontSize', 20)
hold off
axis tight
xlabel('Cost of Entry')
grid on
hold off

hjkl

%==========================================================================

while 1 == 1
      figure(1)
      figure(2)
      pause(3)
      for i1 = 1:3
            ib = i1*2
            figure(ib-1)
            figure(ib)
            pause(1)
      end
end

