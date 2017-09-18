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
            eval(['E_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.E;'])

            eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])
                     
        end
    end
end

      h = figure;


      %Plotting E
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,E_111,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_112,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E111] = max(E_111);
%       [ciccio, loc_E112] = max(E_112);
%       [ciccio, loc_E113] = max(E_113);
      [ciccio, loc_U111] = max(U_111);
%       [ciccio, loc_U112] = max(U_112);
%       [ciccio, loc_U113] = max(U_113);
      plot(tech.alpha_vec(loc_U111),E_111(loc_U111),'ks')
%       plot(tech.alpha_vec(loc_U112),E_112(loc_U112),'ks')
%       plot(tech.alpha_vec(loc_U113),E_113(loc_U113),'ks')
      plot(tech.alpha_vec(loc_E111),E_111(loc_E111),'k*')
%       plot(tech.alpha_vec(loc_E112),E_112(loc_E112),'k*')
%       plot(tech.alpha_vec(loc_E113),E_113(loc_E113),'k*')   
      title('Value of Employment (\sigma = 0.5, \gamma = 1)','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      ylim([1.955 2.038])
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,E_121,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_122,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E121] = max(E_121);
%       [ciccio, loc_E122] = max(E_122);
%       [ciccio, loc_E123] = max(E_123);
      [ciccio, loc_U121] = max(U_121);
%       [ciccio, loc_U122] = max(U_122);
%       [ciccio, loc_U123] = max(U_123);
      plot(tech.alpha_vec(loc_U121),E_121(loc_U121),'ks')
%       plot(tech.alpha_vec(loc_U122),E_122(loc_U122),'ks')
%       plot(tech.alpha_vec(loc_U123),E_123(loc_U123),'ks')
      plot(tech.alpha_vec(loc_E121),E_121(loc_E121),'k*')
%       plot(tech.alpha_vec(loc_E122),E_122(loc_E122),'k*')
%       plot(tech.alpha_vec(loc_E123),E_123(loc_E123),'k*')   
      title('Value of Employment (\sigma = 0.5, \gamma = 1.3)','FontSize', 20)
      ylim([1.955 2.038])
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,E_131,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_132,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,E_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E131] = max(E_131);
%       [ciccio, loc_E132] = max(E_132);
%       [ciccio, loc_E133] = max(E_133);
      [ciccio, loc_U131] = max(U_131);
%       [ciccio, loc_U132] = max(U_132);
%       [ciccio, loc_U133] = max(U_133);
      plot(tech.alpha_vec(loc_U131),E_131(loc_U131),'ks')
%       plot(tech.alpha_vec(loc_U132),E_132(loc_U132),'ks')
%       plot(tech.alpha_vec(loc_U133),E_133(loc_U133),'ks')
      plot(tech.alpha_vec(loc_E131),E_131(loc_E131),'k*')
%       plot(tech.alpha_vec(loc_E132),E_132(loc_E132),'k*')
%       plot(tech.alpha_vec(loc_E133),E_133(loc_E133),'k*')     
      title('Value of Employment (\sigma = 0.5, \gamma = 1.6)','FontSize', 20)
      ylim([1.955 2.038])
      hold off
      xlabel('Debt')
      grid on
      
print(h,'E_riskaverse','-dpdf','-fillpage')