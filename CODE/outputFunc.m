function output = outputFunc(K,r,tau,phi,D,prodcurve)
  output = phi*D.^prodcurve - D*r;
end