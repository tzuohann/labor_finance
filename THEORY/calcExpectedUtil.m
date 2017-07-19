function EUtil = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim)
    %Calculate expected utility in a given period given the wage contract.
    globalDeclaration    
    phi_dw            = phi_d_fun(wStar,aalpha);
    output            = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
    consumption       = getWage(phi_vec,phi_dw,phi_db,phi_e,phi_lim,output,period,wStar);
    EUtil             = sum(utilFunc(consumption,ssigma,1))/length(consumption);
end