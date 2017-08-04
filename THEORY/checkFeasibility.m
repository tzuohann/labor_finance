function checkFeasibility(params,aalpha,phi_e,E2_up,E3_up,output)
  phi_cutoff = getPhiCutoff(params,aalpha,phi_e,max(output));
  %Checking the feasibility of the problem
  if phi_cutoff < phi_e
    error('phi_lim cannot be smaller than phi_e.')
  end
  limitIntegral = getContinuationProb(phi_cutoff,params.phi_vec);
  if E2_up + params.BETA*(1-limitIntegral)*E3_up ...
      + params.BETA*limitIntegral*params.utilFunc(params.b) <= (1+params.BETA)*params.utilFunc(params.b)
    error('Worker does not accept the job, the expected utility of being employed is smaller thant the expected utility of being unemployed even if the firm gives everything to the worker. To fix the problem you may either decrease b, increase the mean value of phi, or change the boundary of alpha')
  end
  if phi_e > params.phi_d_fun(params.b,aalpha)
    error('phi_e cannot be greater than phi_db.')
  end
end
