% ---------------------------------------------------
% job filling probability function
% q=p/x=(1+theta^gamma)^(-1/gamma) concave
% or Cobb-Douglas q=M*theta^(gamma-1)
%
% b0=41.7539
% gamma=0.0164095
function res = q(theta)
  global gamma_matching
  
  
  %global m
  
  %gamma=0.2;%0.016409500000000;
  %m=log(4);%41.7539;
  % I = find(theta == 0);
  % res = p(theta)./theta;
  % res(I) = 1;
  %res=m*theta.^(gamma-1);
  %res = m*(1+theta.^gamma).^(-1/gamma);
  m = 1;
  res = m*(1+theta.^gamma_matching).^(-1/gamma_matching);
  
  %%%%%%%%%%%%Frictionless case!
  %res = min(1,1./theta);
  %%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  
  
  
  %I=find(res>1);
  %res(I)=1;
  
  
