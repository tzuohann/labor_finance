function limitIntegral = getContinuationProb(phi_cutoff,phi_vec)

      limitIntegral = phi_cutoff; %it is correct if phi_up = 1 and phi_low = 0.
      %Otherwise use: limitIntegral = sum(phi_vec < phi_cutoff)./numel(phi_vec);
end