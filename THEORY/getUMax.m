function [UMax,wStarMax,E2Max] = getUMax(params,aalpha,phi_e,phi_db,output)
  eval(reshape(structvars(params)',1,[]));
  wStarMax  = output(end);
  E3Max     = getE3(params,aalpha,wStarMax);
  if strcmp(whichCommitment,'limited')
    phi_cutoff   = getPhiLim_Discrete(params,aalpha,phi_e,wStarMax);
  elseif strcmp(whichCommitment,'perfect')
    phi_cutoff   = phi_e;
  end
  E2Max     = calcExpectedUtil(params,output,phi_cutoff,wStarMax);
  UMax = utilFunc(b,ssigma,1) + BETA*E2Max + BETA^2*E3Max;
end