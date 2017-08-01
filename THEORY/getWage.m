function wage = getWage(params,output,phi_cutoff,wStar)
  
  eval(reshape(structvars(params)',1,[]))
  wage                            = output;
  wage( output  >= wStar )        = wStar;
  wage( output  <= 0 )            = b;
  wage( phi_vec <= phi_cutoff )   = b;
  
end
