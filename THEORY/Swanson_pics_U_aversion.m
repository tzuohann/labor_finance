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
                  eval(['wstar_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.wstar;'])
                  
                  eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])
                  eval(['wstar_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.wmax;'])
                  
            end
      end
end


h = figure;

subplot(2,1,1)
hold on
plot(tech.alpha_vec,U_111,'-','LineWidth', 1.5,'color','b')
plot(tech.alpha_vec,U_131,':','LineWidth', 1.5,'color','b')
legend('\gamma = 1','\gamma = 1.6')
[ciccio, loc_U111] = max(U_111);
[ciccio, loc_U131] = max(U_131);
[ciccio, loc_U_worker111] = max(U_worker111);
plot(tech.alpha_vec(loc_U111),U_111(loc_U111),'ks')
plot(tech.alpha_vec(loc_U131),U_131(loc_U131),'ks')
y1=get(gca,'ylim');
line([tech.alpha_vec(loc_U_worker111) tech.alpha_vec(loc_U_worker111)],y1)
title('Value of Unemployment (\sigma = 0.5, b = 0)','FontSize', 20)
hold off
xlabel('Debt')
grid on

subplot(2,1,2)
hold on
plot(tech.alpha_vec,wstar_111,'-','LineWidth', 1.5,'color','b')
plot(tech.alpha_vec,wstar_131,':','LineWidth', 1.5,'color','b')
legend('\gamma = 1','\gamma = 1.6')
ylim([0.4 0.52]);
y1 = get(gca,'ylim');
plot(tech.alpha_vec(loc_U111),wstar_111(loc_U111),'ks')
plot(tech.alpha_vec(loc_U131),wstar_131(loc_U131),'ks')
line([tech.alpha_vec(loc_U_worker111) tech.alpha_vec(loc_U_worker111)],y1)
title('Wage (\sigma = 0.5, b = 0)','FontSize', 20)
hold off
xlabel('Debt')
grid on

print(h,'Uw_riskaverse_one','-dpdf','-fillpage')

