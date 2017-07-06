function preTaxoutput = prodFn(R,phi,alpha,r)
  %Calculate pretax output assuming K = 1
  preTaxoutput = R - alpha*r + phi;
end