%Clearing and closing
clear all
close all

%Parameterization
[params,tech] = param();

paramswhichCommitment = 'perfect';
[U_store_p,w_store_p,vacancies_p,p_theta_p,q_theta_p,obj_store_p,phi_e_store_p,phi_lim_store_p] = mainDynamicLoop(params,tech);
whichCommitment = 'limited';
[U_store_lc,w_store_lc,vacancies_lc,p_theta_lc,q_theta_lc,obj_store_lc,phi_e_store_lc,phi_lim_store_lc] = mainDynamicLoop(params,tech);

%Storing the optimal U and alpha for sigma varying
[U_maximized location] = max(U_store);
if location == length(alpha_vec)
  error('Corner solution. Most likely alpha_max is too small. The maximization problem is constrained by alpha_max.')
elseif location == 1
  error('Corner solution. Most likely alpha_min is too large. The maximization problem is constrained by alpha_min.')
end

figure(1)
plot(alpha_vec,U_store,'LineWidth',2)
