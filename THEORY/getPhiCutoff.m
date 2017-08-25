function phi_cutoff = getPhiCutoff(params,aalpha,phi_e,wStar,output,phi_db)

  if strcmp(params.whichCommitment,'limited')
    phi_cutoff      = getPhiLim_Discrete(params,aalpha,phi_e,wStar,phi_db,output);
  elseif strcmp(params.whichCommitment,'perfect')
    phi_cutoff      = phi_e;
  end
end

