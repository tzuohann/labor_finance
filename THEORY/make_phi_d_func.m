function phi_d_fun = make_phi_d_func(phi_e_func)
  globalDeclaration
  if prod_func_type == 1
    phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w ;
  elseif prod_func_type == 2
    phi_d_fun     = @(w,Aalpha) phi_e_func(Aalpha) + w/(1+Aalpha) ;
  else
    error('Only 1 or 2 for now')
  end
end