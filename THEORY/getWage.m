function wage = getWage(phi,phi_dw,phi_db,phi_e,phi_lim,output,period,wageStar)
    globalDeclaration;
    
    wage = zeros(size(phi));
    
    %Calculate wages given thresholds, the output and phi.
    %Important that all the inputs are consistent with each other.
    if period == 2
        switch whichCommitment
            case{'perfect'}
                
                wage( phi <= phi_e ) = b;
                wage(( phi > phi_e ) & ( phi <= phi_dw )) = output(( phi > phi_e ) & ( phi <= phi_dw ));
                wage( phi > phi_dw ) = wageStar;
                if wage < 0
                    error('Wages cannot be less than zero. Check getWage.m')
                end
                
            case{'limited'}
                
                wage( phi <= max(phi_lim,phi_e) ) = b;
                wage(( phi > max(phi_lim,phi_e) ) & ( phi <= phi_dw )) = output(( phi > max(phi_lim,phi_e) ) & ( phi <= phi_dw ));
                wage( phi > phi_dw ) = wageStar;
                if wage < 0
                    error('Wages cannot be less than zero. Check getWage.m')
                end
                
            otherwise
                error('Get your commitment straight.')
        end
    elseif period == 3
        
        wage( phi < phi_db ) = b;
        wage(( phi >= phi_db ) & ( phi <= phi_dw )) = output(( phi >= phi_db ) & ( phi <= phi_dw ));
        wage( phi > phi_dw ) = wageStar;
        if wage < 0
            error('Wages cannot be less than zero. Check getWage.m')
        end
        
    else
        error('Wrong model.')
    end
    
end
