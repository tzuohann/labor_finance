function EUtil = calcExpectedUtil(period,wStar,phi_db,phi_e,phi_d_fun,aalpha,phi_lim)
    %Calculate expected utility in a given period given the wage contract.
    globalDeclaration
    
    phi_dw            = phi_d_fun(wStar);
    
    EUtil             = 0;
    for ip = 1:length(phi_vec)
        phi           = phi_vec(ip);
        output        = prodFn(R,phi,aalpha,r);
        consumption   = getWage(phi,phi_dw,phi_db,phi_e,phi_lim,output,period,wStar);
        EUtil         = EUtil + utilFunc(consumption,ssigma,1);
    end
    EUtil = EUtil/length(phi_vec);
end