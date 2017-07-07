%4-Period Model. In the third period worker gets b in any case and firm
%gets V_3 = (1-tau)*(R-r*alpha+phi-b) if and only if V_2 > 0.
%Here perfect commitment since to be alive it is enough that
%phi > r*alpha - R

%Clearing and closing
clear
close all

%Parameterization
param

%Auxiliary functions
phi_e_func = @(Aalpha) r*Aalpha - R; %boundary, alpha-varying must be inside the loop

%Evaluate optimal w, U, vacancies given alpha
for ia = 1:length(alpha_vec) %loop over alpha, we do for all the possible alphas
  disp(num2str(ia))
  %Technical parameters
  err_U = 1; %initial value for err_U
  k = 0; %initial value for counting the iterations of the loops
  alpha = alpha_vec(ia);
  
  phi_e = phi_e_func(alpha);
  phi_d_fun = @(w) phi_e + w ; %boundary, alpha-varying must be inside the loop
  phi_db    = phi_d_fun(b);
  
  %Phi_lim calculated analytically
  phi_lim_fun = @(wStar) max(phi_e,...
    ((1-ssigma)*((1 + BETA - BETA*((phi_db - phi_low)/(phi_up - phi_low)))*utilFunc(b,ssigma,1)...
    - BETA*(wStar.^(2-ssigma) - b^(2-ssigma))/((phi_up - phi_low)*(2-ssigma)*(1-ssigma))...
    - BETA*((phi_up - phi_d_fun(wStar))...
    ./(phi_up - phi_low).*utilFunc(wStar,ssigma,1)))).^(1/(1-ssigma)) + r*alpha - R);
  
  %     %Phi_lim calculated discrete
  %     phi_lim_fun = @(wStar) max(phi_e,getPhiLim_Discrete(phi_d_fun,phi_db,wStar,phi_e,alpha));
  
  
  %Boundaries of U
  
  U_min = (1+BETA+BETA^2)*utilFunc(b,ssigma,1); % minimum value of unemployment
  
  %     %Calculate Expected U in second period given WStar = Output at Phi Max.
  wStarMax = prodFn(R,max(phi_vec),alpha,r);
      period   = 2;
      E2Max    = calcExpectedUtil(period,wStarMax,phi_db,phi_e,phi_d_fun,...
                 alpha,phi_lim_fun(wStarMax));
      period   = 3;
      E3Max    = calcExpectedUtil(period,wStarMax,phi_db,phi_e,phi_d_fun,...
                 alpha,phi_lim_fun(wStarMax));
      U_max     = utilFunc(b,ssigma,1) + BETA*E2Max + BETA^2*E3Max;
  
  U_max     = utilFunc(b,ssigma,1) ...
    + BETA*((phi_e - phi_low)/(phi_up - phi_low)*utilFunc(b,ssigma,1) ...
    + (wStarMax^(2-ssigma) - b^(2-ssigma))...
    /((2-ssigma)*(1-ssigma)*(phi_up - phi_low)) ...
    + (phi_up - phi_d_fun(wStarMax))/(phi_up - phi_low)*utilFunc(wStarMax,ssigma,1))...
    +   BETA^2*((phi_d_fun(b) - phi_low)/(phi_up - phi_low)*utilFunc(b,ssigma,1) ...
    + (wStarMax^(2-ssigma) - b^(2-ssigma))/((2-ssigma)*(1-ssigma)*(phi_up - phi_low)) ...
    + (phi_up - phi_d_fun(wStarMax))/(phi_up - phi_low)*utilFunc(wStarMax,ssigma,1));
  
  %Missed taxes in the upper bound of w
  w_min = b;
  w_max = R + phi_up - r*alpha;
  
  gridW = linspace(w_min,w_max,10000);
  
  while err_U > tol && k < max_iter
    k = k + 1; %Iteration
    
    U = (U_min + U_max)/2;
    
    %Objective function
    %This is the firms maximization problem
    %Probability of matching for the worker
    if strcmp(whichCommitment,'perfect')
      E2 = @(w) (((phi_e - phi_low)/(phi_up - phi_low))*utilFunc(b,ssigma,1)...
        + w.^(2-ssigma)./((phi_up - phi_low)*(2-ssigma)*(1-ssigma))...
        + ((phi_up - phi_d_fun(w))./(phi_up - phi_low)).*utilFunc(w,ssigma,1));
      E3 = @(w) (((phi_d_fun(b) - phi_low)/(phi_up - phi_low))*utilFunc(b,ssigma,1)...
        +  (w.^(2-ssigma) - b.^(2-ssigma))./((phi_up - phi_low)*(2-ssigma)*(1-ssigma))...
        + ((phi_up - phi_d_fun(w))./(phi_up - phi_low)).*utilFunc(w,ssigma,1));
      
      f = @(w) (U - (1+BETA+BETA^2)*utilFunc(b,ssigma,1))...
        ./(BETA*(E2(w) + BETA*(phi_up - phi_e)/(phi_up - phi_low).*E3(w)...
        - utilFunc(b,ssigma,1)*(1 + BETA*(phi_up - phi_e)/(phi_up - phi_low))));
    elseif strcmp(whichCommitment,'limited')
      E2 = @(w) (((phi_lim_fun(w) - phi_low)/(phi_up - phi_low))*utilFunc(b,ssigma,1)...
        + (w.^(2-ssigma) - (R + phi_lim_fun(w) - r*alpha).^(2-ssigma))...
        ./((phi_up - phi_low)*(2-ssigma)*(1-ssigma))...
        + ((phi_up - phi_d_fun(w))./(phi_up - phi_low)).*utilFunc(w,ssigma,1));
      E3 = @(w) (((phi_d_fun(b) - phi_low)/(phi_up - phi_low))*utilFunc(b,ssigma,1)...
        +  (w.^(2-ssigma) - b.^(2-ssigma))./((phi_up - phi_low)*(2-ssigma)*(1-ssigma))...
        + ((phi_up - phi_d_fun(w))./(phi_up - phi_low)).*utilFunc(w,ssigma,1));
      f = @(w) (U - (1+BETA+BETA^2)*utilFunc(b,ssigma,1))...
        ./(BETA*(E2(w) + BETA*(phi_up - phi_lim_fun(w))/(phi_up - phi_low).*E3(w)...
        - utilFunc(b,ssigma,1)*(1 + BETA*(phi_up - phi_lim_fun(w))/(phi_up - phi_low))));
    else error('can only choose between perfect or limited')
    end
    
    allf = f(gridW);
    
    %         pause(0.05)
    %         figure(1)
    %         clf
    
    %First ensure that for U, there is a solution to the problem
    if f(w_max) > 1
      disp('U is too large, lower U')
      U_max = U; %Bisection U, we decrease it
      err_U = abs(U_max - U_min);
    else
      %Running the kalman function given the above inputs
      if strcmp(whichCommitment,'perfect')
        g = @(w) BETA*(1-tau).*((R - r*alpha - w)...
          .*(phi_up - phi_d_fun(w))./(phi_up - phi_low)...
          + 1./(2*(phi_up - phi_low)).*(phi_up^2 - phi_d_fun(w).^2))...
          .*(1 + BETA*(phi_up - phi_e)/(phi_up - phi_low));
      elseif strcmp(whichCommitment,'limited')
        g = @(w) BETA*(1-tau).*((R - r*alpha - w).*(phi_up - phi_d_fun(w))...
          ./(phi_up - phi_low) + 1./(2*(phi_up - phi_low))...
          .*(phi_up^2 - phi_d_fun(w).^2)) + BETA^2*...
          (phi_up-phi_d_fun(b))/(phi_up - phi_low)*...
          (1-tau).*((R - r*alpha - w).*(phi_up - phi_d_fun(w))./(phi_up - phi_low)...
          + 1./(2*(phi_up - phi_low)).*(phi_up^2 - phi_d_fun(w).^2));
      else error('can only choose between perfect or limited')
      end
      obj = @(w) -((1 - f(w).^gamma).^(1/gamma).*g(w)); %We max this guy!
      
      startPoints = obj(gridW);
      
      startPoint  = mean(gridW(allf < 1 & allf > 0)); %Take an average
      
      %             plot(obj(gridW(allf < 1 & allf > 0)))
      
      options = optimoptions('fmincon','Display','None');
      wstar = fmincon(obj,startPoint,[],[],[],[],min(gridW(allf < 1 & allf > 0))...
        ,max(gridW(allf < 1 & allf > 0)),[],options);
      
      if -obj(wstar) > (1 - alpha)
        U_min = U;
      else
        U_max = U;
      end
      err_alpha = abs(1 - alpha + obj(wstar));
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

for i = 1:length(alpha_vec)
  alpha = alpha_vec(i);
  zer(i) = (phi_d_fun(w_store(i)-phi_e)/(phi_up-phi_low)*(1-tau)*(r*alpha - R)...
    + (1-tau)*(1/(phi_up - phi_low)*(1/2*(phi_up^2 - phi_d_fun(w_store(i))^2) - w_store(i)))...
    + alpha*r*tau);
end


%Figure
% plot(alpha,vacancies,'LineWidth',2)
% hold on
figure(1)
plot(alpha_vec,U_store,'LineWidth',2)
hold on
plot(alpha_vec,w_store,'LineWidth',2)
hold on
plot(alpha_vec,p_theta,'LineWidth',2)
hold on
plot(alpha_vec,q_theta,'LineWidth',2)
legend('U','w','p(\theta)','q(\theta)','location','northwest') %'Vacancies',
grid on
xlabel('\alpha') % x-axis label

figure(2)
plot(alpha_vec, phi_lim_fun(w_store),'LineWidth',2)
hold on
plot(alpha_vec, obj_store,'LineWidth',2)
legend('\phi_l','Objective')
grid on
xlabel('\alpha') % x-axis label

