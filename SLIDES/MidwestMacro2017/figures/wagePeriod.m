phiGrid = linspace(0,1,1000);
D       = 10;
W       = 0.1;
COE     = 0.15;
B       = 0.5;
r       = 0.08;
wstar   = 2;
output  = phiGrid*(W - COE + D)^0.6 - r*D;
wages   = output;
wages(wages < 0) = B;
wages(wages > wstar) = wstar;
dividends = output - wages;
dividends(dividends < 0) = 0;
X1 = phiGrid;
YMatrix1 = [wages;output;dividends];

createfigureWagePeriod1(X1, YMatrix1)
export_fig(['WagePeriod1.pdf'])

wages(wages < B) = B;
YMatrix1 = [wages;output;dividends];
createfigureWagePeriod2(X1, YMatrix1)
export_fig(['WagePeriod2.pdf'])
