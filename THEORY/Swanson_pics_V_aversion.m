clear all
close all

for i_1 = 1:1
      for i_2 = 1:3
            for i_3 = 1:3
                  
                  BaseName = 'File_riskaversion';
                  FileName = [BaseName,'_sigma',num2str(i_1),...
                        '_gamma',num2str(i_2),'_b',num2str(i_3)];
                  load(FileName);
                  
                  eval(['U_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.U;'])
                  eval(['V_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.V;'])
                  eval(['E_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.E;'])
                  
                  eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])

                  
            end
      end
end
[ciccio, loc_U111] = max(U_111);
[ciccio, loc_U131] = max(U_131);
[ciccio, loc_U_worker111] = max(U_worker111);

h = figure

subplot(2,1,1)
hold on
plot(tech.alpha_vec,V_111,'-','LineWidth', 1.5,'color','b')
plot(tech.alpha_vec,V_131,':','LineWidth', 1.5,'color','b')
legend('\gamma = 1','\gamma = 1.6')
ylim([0.04 0.09]);
y1 = get(gca,'ylim');
plot(tech.alpha_vec(loc_U111),V_111(loc_U111),'ks')
plot(tech.alpha_vec(loc_U131),V_131(loc_U131),'ks')
line([tech.alpha_vec(loc_U_worker111) tech.alpha_vec(loc_U_worker111)],y1)
title('Firm Value after marching (\sigma = 0.5, b = 0)','FontSize', 20)
hold off
xlabel('Debt')
grid on


subplot(2,1,2)
hold on
plot(tech.alpha_vec,E_111,'-','LineWidth', 1.5,'color','b')
plot(tech.alpha_vec,E_131,':','LineWidth', 1.5,'color','b')
legend('\gamma = 1','\gamma = 1.6')
ylim([1.95 2.05]);
y1 = get(gca,'ylim');
plot(tech.alpha_vec(loc_U111),E_111(loc_U111),'ks')
plot(tech.alpha_vec(loc_U131),E_131(loc_U131),'ks')
line([tech.alpha_vec(loc_U_worker111) tech.alpha_vec(loc_U_worker111)],y1)
title('Value of Employment (\sigma = 0.5, b = 0)','FontSize', 20)
hold off
xlabel('Debt')
grid on

print(h,'VE_riskaverse_one','-dpdf','-fillpage')