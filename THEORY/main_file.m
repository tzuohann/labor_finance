%3-Period Model. The production function is (1-t)((1+alpha)R - alpha r + (1+alpha)phi - w)

%Clearing and closing
clear
close all

%Parameterization
param

%Select functions for phi_e and phi_d depending on model type.
phi_e_func  = make_phi_e_func();
phi_d_fun   = make_phi_d_func(phi_e_func);

%Make this a function of different parameter values
for is = 1:length(sigma_vec)  %Loop for the sigma varying
  disp(num2str(is))
  
  %Evaluate optimal w, U, vacancies given alpha
  for ia = 1:length(alpha_vec) %loop over alpha, we do for all the possible alphas
    
    %Technical parameters
    err_U     = 1; %initial value for err_U
    k         = 0; %initial value for counting the iterations of the loops
    aalpha    = alpha_vec(ia);
    ssigma    = sigma_vec(is); %sigma varying
    
    phi_e     = phi_e_func(aalpha);
    phi_db    = phi_d_fun(b,aalpha);
    
    %Boundaries of U
    U_min     = (1+BETA+BETA^2)*utilFunc(b,ssigma,1); % minimum value of unemployment
    U_max     = getUMax(aalpha,phi_e,phi_db,phi_d_fun);
    
    while err_U > tol && k < max_iter
      k       = k + 1; %Iteration
      U       = (U_min + U_max)/2;
      
      %wmin has to be a function of U while w_max doesn't change
      w_min   = getWMin(U,phi_d_fun,phi_db,phi_e,aalpha);
      w_max   = prodFn(R,max(phi_vec),aalpha,r,prod_func_type);
      gridW   = linspace(w_min,w_max,100);
      phi_lim = getPhiLim_Discrete(phi_d_fun,phi_db,gridW(end),phi_e,aalpha);
      
      %First ensure that for U, there is a solution to the problem
      if getf(gridW(end),phi_db,phi_e,phi_d_fun,aalpha,U) > 1
        disp('U is too large, lower U')
        U_max = U; %Bisection U, we decrease it
        err_U = abs(U_max - U_min);
      else
          
        f =@(w) getf(w,phi_db,phi_e,phi_d_fun,aalpha,U);
        g =@(w) getg(w,aalpha,phi_d_fun,phi_lim,phi_e);
        
        obj = @(w) -((1 - f(w).^gamma).^(1/gamma).*g(w)); %We max this guy!
        
        options = optimoptions('fmincon','Display','None');
        wstar = fmincon(obj,(w_min + w_max)/2,[],[],[],[],w_min,w_max,[],options);
        
        if -obj(wstar) > fix_cost;
          U_min = U;
        else
          U_max = U;
        end
        err_alpha = abs(fix_cost + obj(wstar));
        err_U = abs(U_max - U_min);
        err_U = err_U + err_alpha;
      end
      
      if k == max_iter
        error('No Feasible Solution')
      end
    end
    
    U_store(ia) = U;
    w_store(ia) = wstar;
    vacancies(ia) = (f(wstar)^(-gamma) - 1)^(-1/gamma);
    p_theta(ia) = f(wstar);
    q_theta(ia) = p_theta(ia)/vacancies(ia);
    obj_store(ia) = -obj(wstar);
  end
  
  
  %Storing the optimal U and alpha for sigma varying
  [U_maximized location] = max(U_store);
  alpha_maximand = alpha_vec(location);
  w_star_maximand = w_store(location);
  vacancies_maximand = vacancies(location);
  p_theta_maximand = p_theta(location);
  q_theta_maximand = q_theta(location);
  U_maximized_store(is) = U_maximized;
  alpha_maximand_store(is) = alpha_maximand;
  w_maximand_store(is) = w_star_maximand;
  vacancies_maximand_store(is) = vacancies_maximand;
  p_maximand_store(is) = p_theta_maximand;
  q_maximand_store(is) = q_theta_maximand;
end  

%Figure
% plot(alpha,vacancies,'LineWidth',2)
% hold on
% figure(1)
% plot(alpha_vec,U_store,'LineWidth',2)
% hold on
% plot(alpha_vec,w_store,'LineWidth',2)
% hold on
% plot(alpha_vec,p_theta,'LineWidth',2)
% hold on
% plot(alpha_vec,q_theta,'LineWidth',2)
% legend('U','w','p(\theta)','q(\theta)','location','northwest') %'Vacancies',
% grid on
% xlabel('\alpha') % x-axis label


% figure(2)
% plot(alpha_vec, phi_lim_fun(w_store),'LineWidth',2)
% hold on
% plot(alpha_vec, obj_store,'LineWidth',2)
% legend('\phi_l','Objective')
% grid on
% xlabel('\alpha') % x-axis label
% 
% figure(3)
% plot(sigma_vec,alpha_maximand_store,'LineWidth',2)
% hold on
% plot(sigma_vec,U_maximized_store,'LineWidth',2)
% hold on
% plot(sigma_vec,w_maximand_store,'LineWidth',2)
% hold on
% plot(sigma_vec,vacancies_maximand_store,'LineWidth',2)
% hold on
% plot(sigma_vec,p_maximand_store,'LineWidth',2)
% hold on
% plot(sigma_vec,q_maximand_store,'LineWidth',2)
% legend('Optimal \alpha','Optimal U','Optimal w','Optimal vacancies',...
%   'Optimal p(\theta)','Optimal q(\theta)','location','northwest') %'Vacancies',
% grid on
% xlabel('\sigma') % x-axis label
% title('Perfect Commitment, \phi = 0.5, fix cost = 0.01, b = 0.1')
% 
% save('limited_b01_phi05_f001')
