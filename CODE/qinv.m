% ---------------------------------------------------
% job filling probability function
% p is convex, q=p/x is concave
%
function res = qinv(A0)
  global gamma_matching
  
  %global m
  %gamma=1.59929;
  m = 1;
  %res = m*theta.*(1+theta.^gamma_matching).^(-1/gamma_matching);
  res = ((A0/m).^(-gamma_matching)-1).^(1/gamma_matching);
  %%%%%%%%%%%%Frictionless case!
  %res = min(1,theta);
  %%%%%%%%%%%%%%%%%%%%%%%%%%
  %res=m*theta.^gamma;
  %I=find(res>1);
  %res(I)=1;
end