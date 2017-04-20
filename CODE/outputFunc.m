function output = outputFunc(K,r,tau,phi,D)
  output = K*r./(1-tau) + phi - D*r;
end