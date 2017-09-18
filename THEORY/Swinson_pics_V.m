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
                    
            eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])
                    
        end
    end
end

lines           = {'k-','k--','*'}; 

      %Plotting V
      
      h = figure;
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,V_111,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_112,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V111] = max(V_111);
%       [ciccio, loc_V112] = max(V_112);
%       [ciccio, loc_V113] = max(V_113);
      [ciccio, loc_U111] = max(U_111);
%       [ciccio, loc_U112] = max(U_112);
%       [ciccio, loc_U113] = max(U_113);
      plot(tech.alpha_vec(loc_U111),V_111(loc_U111),'ks')
%       plot(tech.alpha_vec(loc_U112),V_112(loc_U112),'ks')
%       plot(tech.alpha_vec(loc_U113),V_113(loc_U113),'ks')
      plot(tech.alpha_vec(loc_V111),V_111(loc_V111),'k*')
%       plot(tech.alpha_vec(loc_V112),V_112(loc_V112),'k*')
%       plot(tech.alpha_vec(loc_V113),V_113(loc_V113),'k*')  
      title('Firm Value after matching (sigma = 0.5, \gamma = 1)','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      ylim([0.042 0.085])
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,V_121,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_122,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V121] = max(V_121);
%       [ciccio, loc_V122] = max(V_122);
%       [ciccio, loc_V123] = max(V_123);
      [ciccio, loc_U121] = max(U_121);
%       [ciccio, loc_U122] = max(U_122);
%       [ciccio, loc_U123] = max(U_123);
      plot(tech.alpha_vec(loc_U121),V_121(loc_U121),'ks')
%       plot(tech.alpha_vec(loc_U122),V_122(loc_U122),'ks')
%       plot(tech.alpha_vec(loc_U123),V_123(loc_U123),'ks')
      plot(tech.alpha_vec(loc_V121),V_121(loc_V121),'k*')
%       plot(tech.alpha_vec(loc_V122),V_122(loc_V122),'k*')
%       plot(tech.alpha_vec(loc_V123),V_123(loc_V123),'k*')   
      title('Firm Value after matching (sigma = 0.5, \gamma = 1.3)','FontSize', 20)
      ylim([0.042 0.085])
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,V_131,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_132,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,V_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V131] = max(V_131);
%       [ciccio, loc_V132] = max(V_132);
%       [ciccio, loc_V133] = max(V_133);
      [ciccio, loc_U131] = max(U_131);
%       [ciccio, loc_U132] = max(U_132);
%       [ciccio, loc_U133] = max(U_133);
      plot(tech.alpha_vec(loc_U131),V_131(loc_U131),'ks')
%       plot(tech.alpha_vec(loc_U132),V_132(loc_U132),'ks')
%       plot(tech.alpha_vec(loc_U133),V_133(loc_U133),'ks')
      plot(tech.alpha_vec(loc_V131),V_131(loc_V131),'k*')
%       plot(tech.alpha_vec(loc_V132),V_132(loc_V132),'k*')
%       plot(tech.alpha_vec(loc_V133),V_133(loc_V133),'k*')         
      title('Firm Value after matching (sigma = 0.5, \gamma = 1.6)','FontSize', 20)
      ylim([0.042 0.085])
      xlabel('Debt')
      grid on
      hold off
      
print(h,'V_riskaverse','-dpdf','-fillpage')