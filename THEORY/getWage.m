function wage = getWage(phi,phi_dw,phi_db,phi_e,phi_lim,output,period,wageStar)
    globalDeclaration;
    
    wage = zeros(size(phi));
    
    %Calculate wages given thresholds, the output and phi.
    %Important that all the inputs are consistent with each other.
    if period == 2
        switch whichCommitment
            case{'perfect'}
                wage( phi >= phi_dw ) = wageStar;
                wage(( phi > phi_e ) & ( phi < phi_dw )) = output(( phi > phi_e ) & ( phi < phi_dw ));
                wage( phi <= phi_e ) = b;
                if wage < 0
                    error('Wages cannot be less than zero. Check getWage.m')
                end
                
            case{'limited'}
                wage( phi >= phi_dw ) = wageStar;
                wage(( phi > max(phi_lim,phi_e) ) & ( phi < phi_dw )) = output(( phi > max(phi_lim,phi_e) ) & ( phi < phi_dw ));
                wage( phi <= max(phi_lim,phi_e) ) = b;
                if wage < 0
                    error('Wages cannot be less than zero. Check getWage.m')
                end
                
            otherwise
                error('Get your commitment straight.')
        end
    elseif period == 3
        switch whichE3
            case{'endogenous'}
                wage                  = output;
                wage(wage > wageStar) = wageStar;
                wage(wage < b)        = b;
            case{'exogenous'}
                wage                  = E3_fix;
            otherwise
                error('Get your E3 straight.')
        end
        
        if wage < 0
            error('Wages cannot be less than zero. Check getWage.m')
        end
        
    else
        error('Wrong model.')
    end
    
end
