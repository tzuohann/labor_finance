function output = U_D_err(b,rra,BETA,P_D,EnteringW_D,U_D)
  U_test = utilFunc(b,rra) + BETA*(P_D.*EnteringW_D + (1 - P_D).*U_D);
  output = abs(U_test - U_D);
end