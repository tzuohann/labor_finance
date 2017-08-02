function E3 = getE3(params,wageStar,output)
  switch params.whichE3
    case{'endogenous'}
      wage                  = output;
      wage(wage > wageStar) = wageStar;
      wage(wage < b)        = params.b;
      E3                    = mean(params.utilFunc(wage));
    case{'exogenous'}
      E3                    = params.E3_fix;
    otherwise
      error('Get your E3 straight.')
  end
end