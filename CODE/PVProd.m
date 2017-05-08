function V_next = PVProd(nPhi,sepPol,delta,R,K,Phi_grid,r,D,wages,tau,BETA,pi_Phi,CV_tol)
  %Calculates the present value of payments to firm and worker
  V_next = zeros(nPhi,1);
  diff   = 1;
  sp = max(sepPol,delta);
  while diff > CV_tol
    V_prev = V_next;
    for ip = 1:nPhi
      if sepPol(ip) == 1
        V_next(ip,:) = 0; %Psi = 0 assumed for now
      else
        o = (R*K + Phi_grid(ip) - r*D - wages(ip,:))*(1-tau) + wages(ip,:);
        %o = (R*K + Phi_grid(ip) - r*D)*(1-tau);
        if o < 0
          error('Output Less than Zero')
        end
        V_next(ip,1) = o + BETA*pi_Phi(ip,:)*((1-sp).*V_prev);
      end
    end
    diff = max(abs(V_prev - V_next));
  end
end