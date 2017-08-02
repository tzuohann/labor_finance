function phi_cutoff = getPhiCutoff(params,aalpha,phi_e,wStarMax)
  if strcmp(params.whichCommitment,'limited')
    phi_cutoff   = getPhiLim_Discrete(params,aalpha,phi_e,wStarMax);
  elseif strcmp(params.whichCommitment,'perfect')
    phi_cutoff   = phi_e;
  end
end