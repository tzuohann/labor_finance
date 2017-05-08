function [Enext, Unow] = calcEmpDist(nPhi,pi_Phi,sep_pol,sigma,EnteringP0,init_Prod)
  Unow  = 1;
  Enow  = zeros(nPhi,1);
  Enext  = zeros(nPhi,1);
  while true
    Enext = (pi_Phi'*Enow + Unow.*EnteringP0.*init_Prod).*(1 - max(sep_pol,sigma));
    Unext = 1 - sum(Enext);
    if abs(Unow - Unext) < 0.00000001
      break
    end
    Unow  = Unext;
    Enow  = Enext;
  end
end
