function EUtil = calcExpectedUtil(params,output,phi_cutoff,wStarMax)
  eval(reshape(structvars(params)',1,[]));
  %Calculate expected utility in a given period given the wage contract.
  consumption       = getWage(params,output,phi_cutoff,wStarMax);
  EUtil             = sum(utilFunc(consumption,ssigma,1))/length(consumption);
end