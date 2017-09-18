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
            eval(['qtheta_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.q;'])
                    
            eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])                      
        end
    end
end

lines           = {'k-','k--','*'}; 

      %Plotting qtheta
      
            h = figure;

      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,qtheta_111,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_112,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_qtheta111] = min(qtheta_111);
%       [ciccio, loc_qtheta112] = min(qtheta_112);
%       [ciccio, loc_qtheta113] = min(qtheta_113);
      plot(tech.alpha_vec(loc_qtheta111),qtheta_111(loc_qtheta111),'ks')
%       plot(tech.alpha_vec(loc_qtheta112),qtheta_112(loc_qtheta112),'ks')
%       plot(tech.alpha_vec(loc_qtheta113),qtheta_113(loc_qtheta113),'ks')
      title('q(\theta) (\sigma = 0.5, \gamma = 1)','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      ylim([0 0.12])
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,qtheta_121,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_122,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_qtheta121] = min(qtheta_121);
%       [ciccio, loc_qtheta122] = min(qtheta_122);
%       [ciccio, loc_qtheta123] = min(qtheta_123);
      plot(tech.alpha_vec(loc_qtheta121),qtheta_121(loc_qtheta121),'ks')
%       plot(tech.alpha_vec(loc_qtheta122),qtheta_122(loc_qtheta122),'ks')
%       plot(tech.alpha_vec(loc_qtheta123),qtheta_123(loc_qtheta123),'ks')
      title('q(\theta) (\sigma = 0.5, \gamma = 1.3)','FontSize', 20)
      ylim([0 0.12])
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,qtheta_131,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_132,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,qtheta_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_qtheta131] = min(qtheta_131);
%       [ciccio, loc_qtheta132] = min(qtheta_132);
%       [ciccio, loc_qtheta133] = min(qtheta_133);
      plot(tech.alpha_vec(loc_qtheta131),qtheta_131(loc_qtheta131),'ks')
%       plot(tech.alpha_vec(loc_qtheta132),qtheta_132(loc_qtheta132),'ks')
%       plot(tech.alpha_vec(loc_qtheta133),qtheta_133(loc_qtheta133),'ks')     
      title('q(\theta) (\sigma = 0.5, \gamma = 1.6)','FontSize', 20)
      ylim([0 0.12])
      hold off
      xlabel('Debt')
      grid on
      
print(h,'qtheta_riskaverse','-dpdf','-fillpage')