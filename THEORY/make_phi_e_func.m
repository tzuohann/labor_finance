function phi_e_func = make_phi_e_func()
  globalDeclaration
  if prod_func_type == 1
    phi_e_func    = @(Aalpha) r*Aalpha - R;
  elseif prod_func_type == 2
    phi_e_func    = @(Aalpha) r*Aalpha/(1+Aalpha) - R;
  else
    error('Only 1 or 2 for now')
  end
end
