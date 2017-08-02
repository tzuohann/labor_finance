function Eprof = calcExpectedProf(wStar,output)
  Eprof                   = output;
  Eprof(output > wStar)   = Eprof(output > wStar) - wStar;
  Eprof(output <= wStar)  = 0;
  Eprof                   = mean(Eprof);
end