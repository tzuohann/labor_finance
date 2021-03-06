function f_discrete = getFdiscrete(limitIntegral,phi_vec,BETA,...
    E2_discrete,b,E3_discrete,U_given,utilFunc)

  den_discrete(phi_vec < limitIntegral)   = (BETA*(E2_discrete + BETA*utilFunc(b) ...
      - (1+BETA)*utilFunc(b)));
  den_discrete(phi_vec >= limitIntegral)  = (BETA*(E2_discrete + BETA*E3_discrete ...
      - (1+BETA)*utilFunc(b)));
  den_discrete                            = mean(den_discrete);
  f_discrete                              = (U_given - (1+BETA+BETA^2)*utilFunc(b))/den_discrete;
end