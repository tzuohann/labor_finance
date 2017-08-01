function E3 = getE3(params,aalpha,wageStar)
  eval(reshape(structvars(params)',1,[]))
  switch whichE3
    case{'endogenous'}
      wage                  = prodFn(R,phi_vec,aalpha,r,prod_func_type,delta);
      wage(wage > wageStar) = wageStar;
      wage(wage < b)        = b;
      E3                    = mean(utilFunc(wage,ssigma,1));
    case{'exogenous'}
      E3                    = E3_fix;
    otherwise
      error('Get your E3 straight.')
  end
end