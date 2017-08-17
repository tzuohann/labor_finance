function Lambda_vect_ws0 = Lambda_util_type(rra,Lambda_vect,tau,typeu)
  if typeu == 1
    %CRRA
    Lambda_vect_ws0 = (Lambda_vect/(1-tau)).^(1/rra);
  elseif typeu == 2
    %logutility
    Lambda_vect_ws0 = Lambda_vect/(1-tau);
  elseif typeu == 3
    %U = -1./(C+eps)
    Lambda_vect_ws0 = (Lambda_vect/(1-tau)).^(1/2);
  end
end