function preTaxoutput = prodFn(R,phi,alpha,r,prod_func_type,delta)
    %Calculate pretax output assuming K = 1
    %Right now we have two types of production function. The original one
    %1. (1-tau)(R - alpha*r + phi - w) and the new one
    %2. (1-tau)((1-alpha)R - alpha*r + (1+alpha)phi - w)
    if prod_func_type == 1
        preTaxoutput = R - alpha*r + phi;
    elseif prod_func_type == 2
        preTaxoutput = (1+alpha)*R - alpha*r + (1+alpha)*phi;
    elseif prod_func_type == 3
        preTaxoutput = (1+alpha)*phi*R - r*alpha;
    end
end