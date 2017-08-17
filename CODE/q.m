function res = q(theta,gamma_matching)
  m = 1;
  res = m*(1+theta.^gamma_matching).^(-1/gamma_matching);
end