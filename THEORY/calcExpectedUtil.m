function EUtil = calcExpectedUtil(params,output,phi_cutoff,wStarMax)
  %Calculate expected utility in a given period given the wage contract.
  consumption       = getWage(params,output,phi_cutoff,wStarMax);
  EUtil             = sum(params.utilFunc(consumption))/length(consumption);
end