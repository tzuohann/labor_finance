%Clearing and closing
clear all
close all

i_sigma = 1;
i_FC = 1;
i_b = 1;
[params,tech] = param(i_sigma,i_FC,i_b,0);

for i_1 = 1:length(params.ssigma_grid)
      for i_2 = 1:length(params.gamma_grid)
            for i_3 = 1:length(params.b_grid)
                  
                  %Parameterization
                  WS = NaN;
                  [params,tech] = param(i_sigma,i_FC,i_b,WS);
                  
                  disp(['sigma = ',num2str(i_1)])
                  disp(['gamma = ',num2str(i_2)])
                  disp(['b = ',num2str(i_3)])
                  
                  %Computations
                  params.whichCommitment = 'perfect';
                  model = 'sp';
                  WS = 0;
                  [params,tech] = param(i_sigma,i_FC,i_b,WS);
                  [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
                        s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
                        s.(model).E2,s.(model).E3,s.(model).E,s.(model).V_max,s.(model).V_min,...
                        s.(model).V2,s.(model).V3,s.(model).V] = ...
                        mainDynamicLoop(params,tech);
                  
                  %Worker Solution
                  params.whichCommitment = 'perfect';
                  model = 'ws'
                  WS = 1;
                  [params,tech] = param(i_sigma,i_FC,i_b,WS);
                  [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q, ...
                        s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,...
                        s.(model).wmin,s.(model).E2,s.(model).E3,s.(model).E,s.(model).V_max,s.(model).V_min,...
                        s.(model).V2,s.(model).V3,s.(model).V] = ...
                        mainLoop(params,tech);
                  
                  %params.whichCommitment = 'limited';
                  %model = 'sl';
                  %[s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
                  %s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
                  %s.(model).E2,s.(model).E3,s.(model).E,s.(model).V_max,s.(model).V_min,...
                  %s.(model).V2,s.(model).V3,s.(model).V] = ...
                  %mainDynamicLoop(params,tech);
                  
                  %Saving results
                  BaseName = 'File_riskneutral';
                  %FileName = [BaseName,'_FC_',num2str(i_FC)]
                  FileName = [BaseName,'_sigma',num2str(i_1),...
                        '_gamma',num2str(i_2),'_b',num2str(i_3)]
                  save(FileName)
            end
      end
end


hjkl

%%
i_FC = 1;
[params,tech] = param(i_FC);

for i_FC = 1:46
    
    BaseName            = 'File_focus';
    FileName            = [BaseName, '_i_FC',num2str(i_FC)];
    load(FileName)
    
    models              = {'sp','sl'};
    
    i_alpha = 18;
    
    p_theta_per(i_FC)   = s.(models{1}).p(i_alpha);
    p_theta_lim(i_FC)   = s.(models{2}).p(i_alpha);
    q_theta_per(i_FC)   = s.(models{1}).q(i_alpha);
    q_theta_lim(i_FC)   = s.(models{2}).q(i_alpha);
    V_per(i_FC)         = s.(models{1}).obj(i_alpha)./s.(models{1}).q(i_alpha);
    V_lim(i_FC)         = s.(models{2}).obj(i_alpha)./s.(models{2}).q(i_alpha);
    E_per(i_FC)         = s.(models{1}).E(i_alpha);
    E_lim(i_FC)         = s.(models{2}).E(i_alpha);
    E2_per(i_FC)        = s.(models{1}).E2(i_alpha);
    E2_lim(i_FC)        = s.(models{2}).E2(i_alpha);
    E3_per(i_FC)        = s.(models{1}).E3(i_alpha);
    E3_lim(i_FC)        = s.(models{2}).E3(i_alpha);
    U_per(i_FC)         = s.(models{1}).U(i_alpha);
    U_lim(i_FC)         = s.(models{2}).U(i_alpha);
    w_per(i_FC)         = s.(models{1}).wstar(i_alpha);
    w_lim(i_FC)         = s.(models{2}).wstar(i_alpha);
    w_max(i_FC)         = s.(models{1}).wmax(i_alpha);
    phi_e(i_FC)         = s.(models{1}).phie(i_alpha);
    phi_lim(i_FC)       = s.(models{2}).philim(i_alpha);
    E3_net_per(i_FC)    = (1-phi_e(i_FC))*E3_per(i_FC) + ...
          phi_e(i_FC)*params.utilFunc(params.b);
    E3_net_lim(i_FC)    = (1-phi_lim(i_FC))*E3_lim(i_FC) + ...
          phi_lim(i_FC)*params.utilFunc(params.b);
    V2_per(i_FC)        = s.(models{1}).V2(i_alpha);
    V2_lim(i_FC)        = s.(models{2}).V2(i_alpha);
    V3_per(i_FC)        = s.(models{1}).V2(i_alpha);
    V3_lim(i_FC)        = s.(models{2}).V2(i_alpha);
    V3_net_per(i_FC)    = s.(models{1}).V3(i_alpha);
    V3_net_lim(i_FC)    = s.(models{2}).V3(i_alpha);
    
end

% figure(1)
% subplot(2,2,1)
% plot(params.fix_cost_grid,ratio_p_theta,'LineWidth', 2)
% grid on
% title('p(\theta^P)/p(\theta^L)')
% subplot(2,2,2)
% plot(params.fix_cost_grid,ratio_q_theta,'LineWidth', 2)
% grid on
% title('q(\theta^P)/q(\theta^L)')
% subplot(2,2,3)
% plot(params.fix_cost_grid,ratio_V,'LineWidth', 2)
% grid on
% title('V^L/V^P')
% subplot(2,2,4)
% plot(params.fix_cost_grid,ratio_E,'LineWidth', 2)
% grid on
% title('E^L/E^P')

% figure(2)
% subplot(4,2,1)
% plot(params.fix_cost_grid,[p_theta_per; p_theta_lim],'LineWidth', 2)
% grid on
% title('p(\theta^P) and p(\theta^L)')
% legend('p(\theta^P)','p(\theta^L)')
% subplot(4,2,2)
% plot(params.fix_cost_grid,[q_theta_per; q_theta_lim],'LineWidth', 2)
% grid on
% title('q(\theta^P) and q(\theta^L)')
% legend('q(\theta^P)','q(\theta^L)')
% subplot(4,2,3)
% plot(params.fix_cost_grid,[V_per; V_lim],'LineWidth', 2)
% grid on
% title('V^P and V^L')
% legend('V^P','V^L')
% subplot(4,2,4)
% plot(params.fix_cost_grid,[E_per; E_lim],'LineWidth', 2)
% grid on
% title('E^P and E^L')
% legend('E^P','E^L')
% subplot(4,2,5)
% plot(params.fix_cost_grid,...
%     [U_per; U_lim],'LineWidth', 2)
% grid on
% title('U^P and U^L')
% legend('U^P','U^L')
% subplot(4,2,6)
% plot(params.fix_cost_grid,...
%     [w_per; w_lim; ones(1,params.length_FC)*params.b; w_max],'LineWidth', 2)
% grid on
% title('w^P and w^L')
% legend('w^P','w^L','min(w)','max(w)')
% subplot(4,2,7)
% plot(params.fix_cost_grid,...
%     [phi_e; phi_lim],'LineWidth', 2)
% grid on
% title('\phi_e and \phi_l')
% legend('\phi_e','phi_l')
% subplot(4,2,8)
% plot(params.fix_cost_grid,...
%     [phi_e; phi_lim],'LineWidth', 2)
% grid on
% title('E3_p and E3_l')
% legend('E3_p','E3_l')
% 
% figure(3)
% loc_zero = find((U_per - U_lim) > 0, 1);
% subplot(4,2,1)
% hold on
% plot(params.fix_cost_grid,[p_theta_per - p_theta_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[p_theta_per(loc_zero) - p_theta_lim(loc_zero)],'*')
% grid on
% title('p(\theta^P) - p(\theta^L)')
% hold off
% subplot(4,2,2)
% hold on
% plot(params.fix_cost_grid,[q_theta_per - q_theta_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[q_theta_per(loc_zero) - q_theta_lim(loc_zero)],'*')
% grid on
% title('q(\theta^P) and q(\theta^L)')
% hold off
% subplot(4,2,3)
% hold on
% plot(params.fix_cost_grid,[V_per - V_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[V_per(loc_zero) - V_lim(loc_zero)],'*')
% grid on
% title('V^P - V^L')
% hold off
% subplot(4,2,4)
% hold on
% plot(params.fix_cost_grid,[E_per - E_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[E_per(loc_zero) - E_lim(loc_zero)],'*')
% grid on
% title('E^P - E^L')
% hold off
% subplot(4,2,5)
% hold on
% plot(params.fix_cost_grid,[U_per - U_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[U_per(loc_zero) - U_lim(loc_zero)],'*')
% grid on
% title('U^P - U^L')
% hold off
% subplot(4,2,6)
% hold on
% plot(params.fix_cost_grid,[w_per - w_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[w_per(loc_zero) - w_lim(loc_zero)],'*')
% grid on
% title('w^P - w^L')
% subplot(4,2,7)
% hold on
% plot(params.fix_cost_grid,[phi_e - phi_lim],'LineWidth', 2)
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% plot(params.fix_cost_grid(loc_zero),[phi_e(loc_zero) - phi_lim(loc_zero)],'*')
% grid on
% title('\phi_e - \phi_l')
% hold off
% 
% 
% figure(4)
% subplot(2,1,1)
% hold on
% plot(params.fix_cost_grid,...
%     [U_per - U_lim],'LineWidth', 2)
% [Umax_diff, loc_diff] = max(U_per - U_lim);
% loc_zero = find((U_per - U_lim) > 0, 1);
% plot(params.fix_cost_grid(loc_zero),zeros(1,1),'*')
% plot(params.fix_cost_grid(loc_diff),U_per(loc_diff) - U_lim(loc_diff),'*')
% plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
% grid on
% title('U_p - U_l')
% hold off
% subplot(2,1,2)
% hold on
% plot(params.fix_cost_grid,...
%     [U_per./U_lim],'LineWidth', 2)
% [Umax_ratio, loc_ratio] = max(U_per./U_lim);
% loc_one = find((U_per./U_lim) > 1, 1);
% plot(params.fix_cost_grid(loc_one),ones(1,1),'*')
% plot(params.fix_cost_grid(loc_ratio),U_per(loc_ratio)/U_lim(loc_ratio),'*')
% plot(params.fix_cost_grid,ones(1,length(params.fix_cost_grid)))
% grid on
% title('U_p/U_l')
% hold off



