figure(1)
subplot(2,2,1)
[a,h1,h2] = plotyy(D_grid, P_D,D_grid,Q_D);
set(h1,'LineWidth',3);
set(h2,'LineWidth',3);
title('Matching probability')
subplot(2,2,2)
hold on
plot(D_grid, EnteringW_D,'-*','LineWidth',3);
plot(D_grid, U_D,'-*','LineWidth',3);
hold off
legend({'W','U'})
title('W and U')
subplot(2,2,3)
plot(D_grid, EnteringF_D,'-*','LineWidth',3);
title('F (value condition on matching)')
subplot(2,2,4)
plot(D_grid,init_Prod'*TP_D,'-*','LineWidth',3);
title('Expected TP')

figure(2)
subplot(2,2,1)
imagesc(D_grid,Phi_grid,sepPol_D)
xlabel('Debt')
ylabel('Phi')
title('Separations (Yellow)')
subplot(2,2,2)
imagesc(D_grid,Phi_grid,massE_D)
ylabel('Phi')
title('Mass')
subplot(2,2,3)
plotyy(D_grid,massU,D_grid,massEnt)
title('mass U (L), mass entrants (R)')
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

figure(4)
subplot(3,3,1)
plot(D_grid,ROE_D1,'-*')
subplot(3,3,2)
plot(D_grid,ROE_D2,'-*')
subplot(3,3,3)
plot(D_grid,ROE_D3,'-*')
subplot(3,3,4)
plot(D_grid,ROE_D4,'-*')
subplot(3,3,5)
plot(D_grid,ROE_D5,'-*')
subplot(3,3,6)
plot(D_grid,ROE_D6,'-*')
subplot(3,3,7)
plot(D_grid,ROE_D7,'-*')
subplot(3,3,8)
plot(D_grid,ROE_D8,'-*')
subplot(3,3,9)
plot(D_grid,ROE_D9,'-*')






