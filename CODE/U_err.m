function output = U_err(b,rra,BETA,P_D,EnteringW_D,U_D,typeu)
  %This also verifies code and doesn't use an external equation
  U_test = utilFunc(b,rra,typeu) + BETA*(P_D.*EnteringW_D + (1 - P_D).*U_D);
  output = abs(U_test - U_D);
end