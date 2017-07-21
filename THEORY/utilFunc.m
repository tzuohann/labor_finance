function U = utilFunc(C,rra,typeu,aalpha)
    globalDeclaration
    if typeu == 1
        U = (C.^(1-rra))/(1-rra);
    elseif typeu == 2
        U = log(C);
    elseif typeu == 3
        U = -1./(C);
    elseif typeu == 4
        U = (1+aalpha)*R - r*aalpha - 1/12*((1+aalpha)*R*phi_up - r*aalpha - ...
            max(b,((1+aalpha)*R*phi_low - r*aalpha)))^2;
    end
end