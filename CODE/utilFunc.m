function U = utilFunc(C,rra,typeu)
  if typeu == 1
  U = (C.^(1-rra))/(1-rra);
  elseif typeu == 2
  U = log(C+0.001);
  elseif typeu == 3
  U = -1./(C+0.001);
  end