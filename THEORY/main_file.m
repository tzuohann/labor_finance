%Clearing and closing
clear all
close all

%Parameterization
[params,tech] = param();

params.whichCommitment = 'perfect';
[U_store_p,w_store_p,vacancies_p,p_theta_p,q_theta_p,obj_store_p,phi_e_store_p,phi_lim_store_p] = mainDynamicLoop(params,tech);
params.whichCommitment = 'limited';
[U_store_lc,w_store_lc,vacancies_lc,p_theta_lc,q_theta_lc,obj_store_lc,phi_e_store_lc,phi_lim_store_lc] = mainDynamicLoop(params,tech);
%Storing the optimal U and alpha for sigma varying
[U_maximized , location] = max(U_store_p);
if location == length(tech.alpha_vec)
  warning('Perfect Commitment')
  warning('Corner solution. The maximization problem is constrained by alpha_max.')
elseif location == 1
  warning('Perfect Commitment')
  warning('Corner solution. The maximization problem is constrained by alpha_min.')
end
loc_pc    = location;
max_U_pc  = U_maximized;

[U_maximized , location] = max(U_store_lc);
if location == length(tech.alpha_vec)
  warning('Limited Commitment')
  warning('Corner solution. The maximization problem is constrained by alpha_max.')
elseif location == 1
  warning('Limited Commitment')
  warning('Corner solution. The maximization problem is constrained by alpha_min.')
end
loc_lc    = location;
max_U_lc  = U_maximized;

figure(1)
subplot(2,1,1)
plot(tech.alpha_vec,U_store_p,'.-')
hold on
plot(tech.alpha_vec,U_store_lc,'.-')
legend({'PC','LC'})
plot(tech.alpha_vec(loc_pc),max_U_pc,'o')
plot(tech.alpha_vec(loc_lc),max_U_lc,'o')
title('U')
hold off
subplot(2,1,2)
plot(tech.alpha_vec,phi_lim_store_p,'.-')
hold on
plot(tech.alpha_vec,phi_lim_store_lc,'.-')
legend({'PC','LC'})
title('Phi Cutoff')
hold off

figure(2)
subplot(2,1,1)
plot(tech.alpha_vec,w_store_p,'.-')
hold on
plot(tech.alpha_vec,w_store_lc,'.-')
legend({'PC','LC'})
title('unconstrainted wages')
hold off
subplot(2,1,2)
plot(tech.alpha_vec,vacancies_p,'.-')
hold on
plot(tech.alpha_vec,vacancies_lc,'.-')
legend({'PC','LC'})
title('vacancies')
hold off



figure(3)
subplot(2,1,1)
plot(tech.alpha_vec,obj_store_p./q_theta_p,'.-')
hold on
plot(tech.alpha_vec,obj_store_lc./q_theta_lc,'.-')
legend({'PC','LC'})
title('profits condition on matching')
hold off
subplot(2,1,2)
plot(tech.alpha_vec,q_theta_p,'.-')
hold on
plot(tech.alpha_vec,q_theta_lc,'.-')
legend({'PC','LC'})
title('q theta')
hold off

figure(4)
subplot(2,1,1)
plot(tech.alpha_vec,phi_e_store_p,'.-')
hold on
plot(tech.alpha_vec,phi_e_store_lc,'.-')
legend({'PC','LC'})
title('phi e')
hold off
subplot(2,1,2)
plot(tech.alpha_vec,p_theta_p,'.-')
hold on
plot(tech.alpha_vec,p_theta_lc,'.-')
legend({'PC','LC'})
title('p theta')
hold off



