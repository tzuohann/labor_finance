function [wstar,firmVal,w_min,w_max] = solveGivenU(U,params,aalpha,phi_e,output,phi_db)
  
  %wmin has to be a function of U while w_max doesn't change
  w_min    = getWMin(params,U,aalpha,phi_e,output,phi_db);
  w_max    = max(output);
  if w_min < 0
    error('w_min cannot be lower than zero.')
  elseif w_max <= w_min
    error('w_max cannot be smaller than w_min.')
  end
    
  %First ensure that for U, there is a solution to the problem
  if getf(params,w_max,phi_e,aalpha,U,output,phi_db) > 1
    firmVal = -666;
    wstar   = NaN;
  else
    gridW = linspace(w_min,w_max,1000);
    obj = @(w) getObjFunc(w,params,aalpha,phi_e,output,U,phi_db); %We max this guy!
    curBest = obj(gridW(end));
    for iw = 999:-1:1
      curCand = obj(gridW(iw));
      if curCand < curBest
        curBest = curCand;
      else
        break
      end
    end
    
    options = optimoptions('fmincon','Display','None','TolX',1e-8,'TolFun',1e-8);
    wstarint = fmincon(obj,gridW(iw),[],[],[],[],w_min,w_max,[],options);
    
    %Consider the interiors as well
    wstar       = wstarint;
    firmVal     = -obj(wstar);
  end
end