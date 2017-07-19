function preTaxoutput = prodFn(R,phi,alpha,r,prod_func_type,delta)
  %Calculate pretax output assuming K = 1
  %Right now we have two types of production function. The original one
  if prod_func_type == 1
    preTaxoutput = R - alpha*r + phi;
    %U just decreases as a function of alpha until worker is at Umin
  elseif prod_func_type == 2
    preTaxoutput = (1+alpha)*R - alpha*r + (1+alpha)*phi;
  elseif prod_func_type == 3
    preTaxoutput = (1+alpha)*phi*R - r*alpha;
  elseif prod_func_type == 4
    preTaxoutput = (R - alpha*r + phi)./(1-alpha);
    %This is perunit capital. Worker can scale up production with the one
    %unit of capital he has. Not so sensible because if at alpha = 1. and
    %there is any positive profit, everything breaks down.
  elseif prod_func_type == 5
    preTaxoutput = R - alpha*r + alpha*phi;
  elseif prod_func_type == 6
    preTaxoutput = (1+alpha)*R - alpha*r + phi*(1+alpha)^delta;
  elseif prod_func_type == 7
    preTaxoutput = (1+alpha*phi)*R - alpha*r;  
  end
end


