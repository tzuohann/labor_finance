function E3 = getE3(params,wageStar,output,aalpha,phi_db)
switch params.whichE3
    case{'endogenous'}
        E3               = calcExpectedUtil(params,output,phi_db,wageStar);
    case{'exogenous'}
        E3               = params.E3_fix;
    otherwise
        error('Get your E3 straight.')
end
end