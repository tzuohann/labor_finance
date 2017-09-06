function utilFunc = makeUtilFunc(rra,typeu)
    if typeu == 1
        utilFunc = @(C) (C.^(1-rra))/(1-rra);
    elseif typeu == 2
        utilFunc = @(C) log(C);
    elseif typeu == 3
        utilFunc = @(C) -1./(C);
    end
end