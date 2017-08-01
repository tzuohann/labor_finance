function limitIntegral = getContinuationProb(whichCommitment,)
  switch whichCommitment
    case {'perfect'}
      limitIntegral = sum(phi_vec < phi_e)./numel(phi_vec);
    case{'limited'}
      limitIntegral = sum(phi_vec < phi_lim)./numel(phi_vec);
    otherwise
      error('Perfect or Limited for now')
  end
end