function output = outputFunc(K,r,tau,phi,D,prodcurve)
  output = r/(1-tau)*phi*D.^prodcurve - D*r;
end