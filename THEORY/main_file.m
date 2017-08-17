%Clearing and closing
clear all
close all

i_FC = 1;
[params,tech] = param(i_FC);

for i_FC = 1:length(params.fix_cost_grid)
    
    %Parameterization
    [params,tech] = param(i_FC);
    
    %Computations
    params.whichCommitment = 'perfect';
    model = 'sp';
    [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
        s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
        s.(model).E2,s.(model).E3,s.(model).E] = mainDynamicLoop(params,tech);
    params.whichCommitment = 'limited';
    model = 'sl';
    [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
        s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
        s.(model).E2,s.(model).E3,s.(model).E] = mainDynamicLoop(params,tech);
    
    BaseName = 'File';
    FileName = [BaseName, '_i_FC',num2str(i_FC)]
    save(FileName)
    
end



%%
i_FC = 1;
[params,tech] = param(i_FC);
for i_FC = 1:length(params.fix_cost_grid)
    
    BaseName            = 'File';
    FileName            = [BaseName, '_i_FC',num2str(i_FC)];
    load(FileName)
    
    models              = {'sp','sl'};
    
    p_theta_per(i_FC)   = s.(models{1}).p;
    p_theta_lim(i_FC)   = s.(models{2}).p;
    q_theta_per(i_FC)   = s.(models{1}).q;
    q_theta_lim(i_FC)   = s.(models{2}).q;
    V_per(i_FC)         = s.(models{1}).obj./s.(models{1}).q;
    V_lim(i_FC)         = s.(models{2}).obj./s.(models{2}).q;
    E_per(i_FC)         = s.(models{1}).E;
    E_lim(i_FC)         = s.(models{2}).E;
    E3_per(i_FC)        = s.(models{1}).E3;
    E3_lim(i_FC)        = s.(models{2}).E3;
    U_per(i_FC)         = s.(models{1}).U;
    U_lim(i_FC)         = s.(models{2}).U;
    w_per(i_FC)         = s.(models{1}).wstar;
    w_lim(i_FC)         = s.(models{2}).wstar;
    w_max(i_FC)         = s.(models{1}).wmax;
    if s.(models{1}).wmax > s.(models{2}).wmax | s.(models{1}).wmax < s.(models{2}).wmax
        error('wmax_per cannot be different than wmax_lim.')
    end
    phi_e(i_FC)         = s.(models{1}).phie;
    phi_lim(i_FC)       = s.(models{2}).philim;
    ratio_p_theta(i_FC) = s.(models{1}).p/s.(models{2}).p;
    ratio_q_theta(i_FC) = s.(models{1}).q/s.(models{2}).q;
    ratio_V(i_FC)       = (s.(models{2}).obj./s.(models{2}).q)/(s.(models{1}).obj./s.(models{1}).q);
    ratio_E(i_FC)       = s.(models{2}).E/s.(models{1}).E;
    ratio_U(i_FC)       = s.(models{1}).U/s.(models{2}).U;
end

figure(1)
subplot(2,2,1)
plot(params.fix_cost_grid,ratio_p_theta,'LineWidth', 2)
grid on
title('p(\theta^P)/p(\theta^L)')
subplot(2,2,2)
plot(params.fix_cost_grid,ratio_q_theta,'LineWidth', 2)
grid on
title('q(\theta^P)/q(\theta^L)')
subplot(2,2,3)
plot(params.fix_cost_grid,ratio_V,'LineWidth', 2)
grid on
title('V^L/V^P')
subplot(2,2,4)
plot(params.fix_cost_grid,ratio_E,'LineWidth', 2)
grid on
title('E^L/E^P')

figure(2)
subplot(4,2,1)
plot(params.fix_cost_grid,[p_theta_per; p_theta_lim],'LineWidth', 2)
grid on
title('p(\theta^P) and p(\theta^L)')
legend('p(\theta^P)','p(\theta^L)')
subplot(4,2,2)
plot(params.fix_cost_grid,[q_theta_per; q_theta_lim],'LineWidth', 2)
grid on
title('q(\theta^P) and q(\theta^L)')
legend('q(\theta^P)','q(\theta^L)')
subplot(4,2,3)
plot(params.fix_cost_grid,[V_per; V_lim],'LineWidth', 2)
grid on
title('V^P and V^L')
legend('V^P','V^L')
subplot(4,2,4)
plot(params.fix_cost_grid,[E_per; E_lim],'LineWidth', 2)
grid on
title('E^P and E^L')
legend('E^P','E^L')
subplot(4,2,5)
plot(params.fix_cost_grid,...
    [U_per; U_lim; ones(1,params.length_FC)*...
    params.utilFunc(params.b)*(1+params.BETA+params.BETA^2)],'LineWidth', 2)
grid on
title('U^P and U^L')
legend('U^P','U^L','Umin')
subplot(4,2,6)
plot(params.fix_cost_grid,...
    [w_per; w_lim; ones(1,params.length_FC)*params.b; w_max],'LineWidth', 2)
grid on
title('w^P and w^L')
legend('w^P','w^L','min(w)','max(w)')
subplot(4,2,7)
plot(params.fix_cost_grid,...
    [phi_e; phi_lim],'LineWidth', 2)
grid on
title('\phi_e and \phi_l')
legend('\phi_e','phi_l')
subplot(4,2,8)
plot(params.fix_cost_grid,...
    [phi_e; phi_lim],'LineWidth', 2)
grid on
title('E3_p and E3_l')
legend('E3_p','E3_l')

figure(3)
subplot(2,1,1)
hold on
plot(params.fix_cost_grid,...
    [U_per - U_lim],'LineWidth', 2)
[Umax_diff, loc_diff] = max(U_per - U_lim);
loc_zero = find((U_per - U_lim) > 0, 1);
plot(params.fix_cost_grid(loc_zero),zeros(1,1),'*')
plot(params.fix_cost_grid(loc_diff),U_per(loc_diff) - U_lim(loc_diff),'*')
plot(params.fix_cost_grid,zeros(1,length(params.fix_cost_grid)))
grid on
title('U_p - U_l')
hold off
subplot(2,1,2)
hold on
plot(params.fix_cost_grid,...
    [U_per./U_lim],'LineWidth', 2)
[Umax_ratio, loc_ratio] = max(U_per./U_lim);
loc_one = find((U_per./U_lim) > 1, 1);
plot(params.fix_cost_grid(loc_one),ones(1,1),'*')
plot(params.fix_cost_grid(loc_ratio),U_per(loc_ratio)/U_lim(loc_ratio),'*')
plot(params.fix_cost_grid,ones(1,length(params.fix_cost_grid)))
grid on
title('U_p/U_l')
hold off



