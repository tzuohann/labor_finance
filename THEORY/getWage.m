function wage = getWage(phi,phi_dw,phi_db,phi_e,phi_lim,output,period,wageStar)
  globalDeclaration;
  
  %Calculate wages given thresholds, the output and phi.
  %Important that all the inputs are consistent with each other.
  if period == 2
    switch whichCommitment
      case{'perfect'}
        if phi < phi_e
          wage = b;
        elseif ( phi >= phi_e ) && ( phi <= phi_dw )
          wage = output;
        elseif ( phi >= phi_dw )
          wage = wageStar;
        end
      case{'limited'}
        if phi < max(phi_lim,phi_e)
          wage = b;
        elseif ( phi >= max(phi_lim,phi_e) ) && ( phi <= phi_dw )
          wage = output;
        elseif ( phi > phi_dw )
          wage = wageStar;
        end
      otherwise
        error('Get your commitment straight.')
    end
  elseif period == 3
    if phi < phi_db
      wage = b;
    elseif ( phi >= phi_db ) && ( phi <= phi_dw )
      wage = output;
    elseif ( phi > phi_dw )
      wage = wageStar;
    end
  else
    error('Wrong model.')
  end
  
end
