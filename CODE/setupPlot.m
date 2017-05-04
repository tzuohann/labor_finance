figure(9987)
for iD = 1:nD
  D                 = D_grid(iD);
  preTaxOutput      = outputFunc(K,r,tau,Phi_grid,D);
  sepPol_D(:,iD)     = preTaxOutput*(1-tau) <= 0;
end
subplot(2,2,2)
pcolor(D_grid,Phi_grid,double(sepPol_D))
title('Separations (Yellow)')
subplot(2,2,3)
pcolor(Phi_grid,Phi_grid,pi_Phi)
title('Transition Matrix')
subplot(2,2,4)
bar(Phi_grid,init_Prod)
title('Initial Productivity Distrib')
figureFullScreen(9987)