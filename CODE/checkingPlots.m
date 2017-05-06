figure(2)
subplot(2,2,1)
plot(D_grid, [P_D;Q_D],'-*','LineWidth',3);
legend({'p(theta)','q(theta)'})
title('Matching probability')
subplot(2,2,2)
[~,h1,h2] = plotyy(D_grid,massU,D_grid,massEnt);
legend({'mass U','mass V (Entrants)'})
set(h1,'LineWidth',3,'LineStyle','-','Marker','*');
set(h2,'LineWidth',3,'LineStyle','-','Marker','*');
title('Vacancies and Unemployment')
subplot(2,2,3)
bla = massE_D;
bla(bla == 0) = -0.01;
pcolor(D_grid,Phi_grid,bla)
title('Employment Mass')
figureFullScreen(2)
subplot(2,2,4)
plot(D_grid,[Estar_err;Vstar_err],'-*','LineWidth',3);
legend({'E error','V error'})
title('Eqbm Errors')
figureFullScreen(2)

figure(3)
subplot(2,2,1)
plot(D_grid, [EnteringW_D;EnteringF_D;EnteringW_D+EnteringF_D],'-*','LineWidth',3);
legend({'W','F','W+F'})
title('W and F')
subplot(2,2,2)
plot(D_grid,U_D - utilFunc(b,rra),'-*','LineWidth',3);
hold on
plot(D_grid,EnteringW_D-U_D,'-*','LineWidth',3);
legend({'U - u(b)','W - U'})
title('W - U and U - u(b)')
subplot(2,2,3)
plot(D_grid,init_Prod'*((1 - sepPol_D).*TP_D + bsxfun(@times,sepPol_D,EnteringLam.*U_D)),'-*','LineWidth',3);
title('Expected TP* less LambdaU')
subplot(2,2,4)
title('PV Output')
figureFullScreen(3)

figure(4)
subplot(2,2,1)
plot(D_grid, Q_D.*(EnteringF_D + EnteringW_D)./(K-D),'-*','LineWidth',3);
title('q(theta)*(F+W)/(K-D)')
subplot(2,2,2)
plot(D_grid, (Q_D.*(EnteringF_D + EnteringW_D) + (1-Q_D).*U_D)./(K-D),'-*','LineWidth',3);
title('[q*(F+W) + (1-q)U]/(K-D)')
subplot(2,2,3)
plot(D_grid, Q_D.*(EnteringF_D + EnteringW_D),'-*','LineWidth',3);
title('[q*(F+W)]')
subplot(2,2,4)
plot(D_grid, (Q_D.*(EnteringF_D + EnteringW_D) + (1-Q_D).*U_D)./(K-D),'-*','LineWidth',3);
title('[q*(F+W) + (1-q)U]')
figureFullScreen(4)