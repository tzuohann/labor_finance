function E = getE(params,wageStar,output,phi_cutoff,E2,E3)

E = E2 + params.BETA*(1-phi_cutoff)*E3 + params.BETA*phi_cutoff*params.utilFunc(params.b);

end