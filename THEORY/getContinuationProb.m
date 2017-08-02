function limitIntegral = getContinuationProb(phi_cutoff,phi_vec)
      limitIntegral = sum(phi_vec < phi_cutoff)./numel(phi_vec);
end