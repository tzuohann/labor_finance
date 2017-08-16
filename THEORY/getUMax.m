function [UMax,E2Max,E3Max] = getUMax(params,aalpha,phi_e,output,U_min,phi_db)
  wStarMax    = output(end);
  E3Max       = getE3(params,wStarMax,output,aalpha,phi_db);
  phi_cutoff  = getPhiCutoff(params,aalpha,phi_e,wStarMax,output,phi_db);
  E2Max       = calcExpectedUtil(params,output,phi_cutoff,wStarMax);
  UMax        = params.utilFunc(params.b) + params.BETA*E2Max + params.BETA^2*E3Max;
  if U_min >= UMax
    error('U_min cannot be greater than U_max. The problem may be the parameterization.')
  end
end