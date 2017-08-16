%Clearing and closing
clear all
close all

i_FC = 1;
[params,tech] = param(i_FC);

for i_FC = 1:params.length_FC
    
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
for i_FC = 1:params.length_FC
    
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
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),ratio_p_theta,'LineWidth', 2)
grid on
title('p(\theta^P)/p(\theta^L)')
subplot(2,2,2)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),ratio_q_theta,'LineWidth', 2)
grid on
title('q(\theta^P)/q(\theta^L)')
subplot(2,2,3)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),ratio_V,'LineWidth', 2)
grid on
title('V^L/V^P')
subplot(2,2,4)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),ratio_E,'LineWidth', 2)
grid on
title('E^L/E^P')

figure(2)
subplot(4,2,1)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),[p_theta_per; p_theta_lim],'LineWidth', 2)
grid on
title('p(\theta^P) and p(\theta^L)')
legend('p(\theta^P)','p(\theta^L)')
subplot(4,2,2)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),[q_theta_per; q_theta_lim],'LineWidth', 2)
grid on
title('q(\theta^P) and q(\theta^L)')
legend('q(\theta^P)','q(\theta^L)')
subplot(4,2,3)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),[V_per; V_lim],'LineWidth', 2)
grid on
title('V^P and V^L')
legend('V^P','V^L')
subplot(4,2,4)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),[E_per; E_lim],'LineWidth', 2)
grid on
title('E^P and E^L')
legend('E^P','E^L')
subplot(4,2,5)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),...
    [U_per; U_lim; ones(1,params.length_FC)*...
    params.utilFunc(params.b)*(1+params.BETA+params.BETA^2)],'LineWidth', 2)
grid on
title('U^P and U^L')
legend('U^P','U^L','Umin')
subplot(4,2,6)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),...
    [w_per; w_lim; ones(1,params.length_FC)*params.b; w_max],'LineWidth', 2)
grid on
title('w^P and w^L')
legend('w^P','w^L','min(w)','max(w)')
subplot(4,2,7)
plot(linspace(params.FC_min,params.FC_max ,params.length_FC),...
    [phi_e; phi_lim],'LineWidth', 2)
grid on
title('\phi_e and \phi_l')
legend('\phi_e','phi_l')


