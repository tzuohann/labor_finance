%3-Period Model. In the third period worker gets b in any case and firm
%gets V_3 = (1-tau)*(R-r*alpha+phi-b) if and only if V_2 > 0.
%Here perfect commitment since to be alive it is enough that
%phi > r*alpha - R

%Clearing and closing
clear all
close all

%Parameterization
param

%alpha grid. Given parameters we start with lowest alpha and go almost to 1
alpha = linspace(0.75,0.9999,20);

%phi grid. Useful to compute integrals
phi_vec = linspace(phi_low,phi_up,40000);

%Initial w, we need to max over it
w = 0.5;

for ia = 1:length(alpha) %loop over alpha, we do for all the possible alphas
    disp(num2str(ia))
    %Technical parameters
    err_U = 1; %initial value for err_U
    k = 0; %initial value for counting the iterations of the loops
    
    %Dividends and wages
    div_w = R - r*alpha(ia) + phi_vec - w; %No distress period
    div_b = R - r*alpha(ia) + phi_vec - b; %Maybe useful later on
    w_dist = R - r*alpha(ia) + phi_vec; %wage when the firm is distress. Profits are zero
    w_dist = max(0,w_dist); %No negative value, they do not make sense, already bankruptcy
    
    %Critical values of phi
    phi_e = phi_vec(find(w_dist > 0,1,'first')); %Bankruptcy threshold
    phi_dw = phi_vec(find(div_w > 0,1,'first')); %Distress threshold
    phi_db = phi_vec(find(div_b > 0,1,'first')); %Outside option threshold
    
    %Value of employment in the third period
    for ip = 1:length(phi_vec)
        if phi_vec(ip) < phi_db
            E3_vec(ip) = utilFunc(b,ssigma,1);
        else if phi_vec(ip) >= phi_db && phi_vec(ip) <= phi_dw
                E3_vec(ip) = utilFunc((R - r*alpha(ia) + phi_vec(ip)),ssigma,1);
            else if phi_vec(ip) > phi_dw
                    E3_vec(ip) = utilFunc(w,ssigma,1);
                end
            end
        end
    end
    E3 = sum(E3_vec)/length(phi_vec);
    
    %Limited commitment threshold. Below phi_lim workers prefers to break the match
    phi_lim = max(phi_e,phi_vec(find((utilFunc(w_dist,ssigma,1) + BETA*E3 ...
        - (1+BETA)*utilFunc(b,ssigma,1)) > 0,1,'first')));
    
    %Boundaries for the value of Unemplyment in period 1
    U_min = (1+BETA+BETA^2)*utilFunc(b,ssigma,1);
    U_max = utilFunc(b,ssigma,1) ...
        + BETA*utilFunc(phi_up,ssigma,1) + BETA^2*utilFunc(phi_up,ssigma,1);
    
    %Value of emplyment (just) in period 2. It does not account for E3!
    for ip = 1:length(phi_vec)
        if phi_vec(ip) < phi_e
            E2_vec(ip) = utilFunc(b,ssigma,1);
        else if phi_vec(ip) >= phi_e && phi_vec(ip) <= phi_dw
                E2_vec(ip) = utilFunc((R - r*alpha(ia) + phi_vec(ip)),ssigma,1);
            else if phi_vec(ip) > phi_dw
                    E2_vec(ip) = utilFunc(w,ssigma,1);
                end
            end
        end
    end
    E2 = sum(E2_vec)/length(phi_vec);
    
    %Values of Unemployment in period 2 and 3
    U2 = (1+BETA)*utilFunc(b,ssigma,1);
    U3 = utilFunc(b,ssigma,1);
    
    %Value of running a business (just) in period 2. It does not account for V3!
    for ip = 1:length(phi_vec)
        if phi_vec(ip) < phi_dw
            V2_vec(ip) = 0;
        else if phi_vec(ip) >= phi_dw
                V2_vec(ip) = (1-tau)*(R - r*alpha(ia) - w + phi_vec(ip));
            end
        end
    end
    V2 = sum(V2_vec)/length(phi_vec);
    
    %Value of running a business (just) in period 3
    for ip = 1:length(phi_vec)
        if phi_vec(ip) < phi_dw
            V3_vec(ip) = 0;
        else if phi_vec(ip) >= phi_dw
                V3_vec(ip) = (1-tau)*(R - r*alpha(ia) - w + phi_vec(ip));
            end
        end
    end
    V3 = sum(V3_vec)/length(phi_vec);
    
    %Loop to find the optimal U given w
    while err_U > tol && k < max_iter
        k = k + 1; %Iteration
        
        %Bisectional U - standard procedure
        U = (U_min + U_max)/2;
        
        %Probability of finding a match for a worker
        num_p_theta = U - (1+BETA+BETA^2)*utilFunc(b,ssigma,1); %numerator
        for ip = 1:length(phi_vec)
            if phi_vec(ip) < phi_e
                den_p_theta_vec(ip) = BETA*(E2 + BETA*U3 - U2);
            else if phi_vec(ip) >= phi_e
                    den_p_theta_vec(ip) = BETA*(E2 + BETA*E3 - U2);
                end
            end
        end
        den_p_theta = sum(den_p_theta_vec)/length(phi_vec); %denominator
        p_theta = num_p_theta/den_p_theta;
        
        if p_theta > 1 
            disp('U is too large, lower U')
            U_max = U; 
            err_U = abs(U_max - U_min);
            else
                %Expected value of running a business in period 2.
                for ip = 1:length(phi_vec)
                    if phi_vec(ip) < phi_e
                        g_vec(ip) = BETA*V2;
                    else if phi_vec(ip) >= phi_e
                            g_vec(ip) = BETA*(V2 + BETA*V3);
                        end
                    end
                end
                g = sum(g_vec)/length(phi_vec);
                
                obj = ((1 - p_theta^gamma).^(1/gamma)*g);
                if obj > 1 - alpha(ia)
                    U_min = U;
                else
                    U_max = U;
                end
                err_alpha = abs(1 - alpha(ia) + obj);
                err_U = abs(U_max - U_min);
                err_U = err_U + err_alpha;
        end
    end
    if k == max_iter
        error('No Feasible Solution')
    end
end


