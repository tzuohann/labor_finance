function wage = getWage(params,output,phi_cutoff,wStar)
  
  wage                                   = output;
  wage( output  >= wStar )               = wStar;
  wage( output  <= 0 )                   = params.b;
  wage( params.phi_vec <= phi_cutoff )   = params.b;
  
end
