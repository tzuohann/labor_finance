function checkFeasibility()
    %Checking the feasibility of the problem
    if phi_lim < phi_e
      error('phi_lim cannot be smaller than phi_e.')
    end
    
    if E2_up + BETA*(1-limitIntegral)*E3_up ...
        + BETA*limitIntegral*utilFunc(b,ssigma,1) <= (1+BETA)*utilFunc(b,ssigma,1)
      error('Worker does not accept the job, the expected utility of being employed is smaller thant the expected utility of being unemployed even if the firm gives everything to the worker. To fix the problem you may either decrease b, increase the mean value of phi, or change the boundary of alpha')
    end
  end
  