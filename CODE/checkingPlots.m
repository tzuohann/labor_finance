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

figure(3)
subplot(2,2,1)
plot(D_grid, [EnteringW_D;EnteringF_D],'-*','LineWidth',3);
legend({'W','F'})
subplot(2,2,2)
plot(D_grid,EnteringW_D+EnteringF_D,'-*','LineWidth',3);
legend({'W + F '})
subplot(2,2,3)
plot(D_grid,U_D - utilFunc(b,rra),'-*','LineWidth',3);
legend({'U - u(b)'})
subplot(2,2,4)
plot(D_grid,EnteringW_D-U_D,'-*','LineWidth',3);
legend({'W - U'})



hold on
plot(D_grid, EnteringW_D,'-*','LineWidth',3);
plot(D_grid, U_D,'-*','LineWidth',3);
hold off
legend({'W','U'})
title('W and U')
subplot(2,2,2)
plot(D_grid, EnteringF_D,'-*','LineWidth',3);
title('F (value condition on matching)')
subplot(2,2,4)
plot(D_grid,init_Prod'*TP_D,'-*','LineWidth',3);
title('Expected TP')

subplot(2,2,4)
plot(Phi_grid,wages_D,'-*','LineWidth',3)
bla = {};
for i1 = 1:nD
  bla{i1} = num2str(i1);
end
legend(bla)
title('Wages')

figure(3)
subplot(2,2,1)
plot(D_grid, EnteringW_D - U_D,'-*','LineWidth',3);
title('W - U')
subplot(2,2,2)
plot(D_grid, P_D.*EnteringW_D,'-*','LineWidth',3);
title('p(theta)*W')
subplot(2,2,3)
plot(D_grid, P_D.*(EnteringW_D - U_D),'-*','LineWidth',3);
title('p(theta)*(W - U)')
subplot(2,2,4)
plot(D_grid, Q_D.*EnteringF_D,'-*','LineWidth',3);
title('q(theta)*F')


