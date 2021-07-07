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

lines           = {'k-','k--','*'}; 

      %Plotting wstar
      
            h = figure;

      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,wstar_111,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_112,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_113,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker111,'-','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker112,'--','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker113,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar111] = max(wstar_111);
%       [ciccio, loc_wstar112] = max(wstar_112);
%       [ciccio, loc_wstar113] = max(wstar_113);
      [ciccio, loc_wstar_worker111] = max(wstar_worker111);
%       [ciccio, loc_wstar_worker112] = max(wstar_worker112);
%       [ciccio, loc_wstar_worker113] = max(wstar_worker113);
      [ciccio, loc_U111] = max(U_111);
%       [ciccio, loc_U112] = max(U_112);
%       [ciccio, loc_U113] = max(U_113);
      [ciccio, loc_U_worker111] = max(U_worker111);
%       [ciccio, loc_U_worker112] = max(U_worker112);
%       [ciccio, loc_U_worker113] = max(U_worker113);
      plot(tech.alpha_vec(loc_U111),wstar_111(loc_U111),'ks')
%       plot(tech.alpha_vec(loc_U112),wstar_112(loc_U112),'ks')
%       plot(tech.alpha_vec(loc_U113),wstar_113(loc_U113),'ks')
      plot(tech.alpha_vec(loc_U_worker111),wstar_worker111(loc_U_worker111),'ks')
%       plot(tech.alpha_vec(loc_U_worker112),wstar_worker112(loc_U_worker112),'ks')
%       plot(tech.alpha_vec(loc_U_worker113),wstar_worker113(loc_U_worker113),'ks')
      plot(tech.alpha_vec(loc_wstar111),wstar_111(loc_wstar111),'k*')
%       plot(tech.alpha_vec(loc_wstar112),wstar_112(loc_wstar112),'k*')
%       plot(tech.alpha_vec(loc_wstar113),wstar_113(loc_wstar113),'k*')
      plot(tech.alpha_vec(loc_wstar_worker111),wstar_worker111(loc_wstar_worker111),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker112),wstar_worker112(loc_wstar_worker112),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker113),wstar_worker113(loc_wstar_worker113),'k*')
      title('Optimal Wage (\sigma = 0.5, \gamma = 1)','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search','Max Output')
      ylim([0.4 0.69])
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,wstar_121,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_122,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_123,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker121,'-','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker122,'--','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker123,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar121] = max(wstar_121);
%       [ciccio, loc_wstar122] = max(wstar_122);
%       [ciccio, loc_wstar123] = max(wstar_123);
      [ciccio, loc_wstar_worker121] = max(wstar_worker121);
%       [ciccio, loc_wstar_worker122] = max(wstar_worker122);
%       [ciccio, loc_wstar_worker123] = max(wstar_worker123);
      [ciccio, loc_U121] = max(U_121);
%       [ciccio, loc_U122] = max(U_122);
%       [ciccio, loc_U123] = max(U_123);
      [ciccio, loc_U_worker121] = max(U_worker121);
%       [ciccio, loc_U_worker122] = max(U_worker122);
%       [ciccio, loc_U_worker123] = max(U_worker123);
      plot(tech.alpha_vec(loc_U121),wstar_121(loc_U121),'ks')
%       plot(tech.alpha_vec(loc_U122),wstar_122(loc_U122),'ks')
%       plot(tech.alpha_vec(loc_U123),wstar_123(loc_U123),'ks')
      plot(tech.alpha_vec(loc_U_worker121),wstar_worker121(loc_U_worker121),'ks')
%       plot(tech.alpha_vec(loc_U_worker122),wstar_worker122(loc_U_worker122),'ks')
%       plot(tech.alpha_vec(loc_U_worker123),wstar_worker123(loc_U_worker123),'ks')
      plot(tech.alpha_vec(loc_wstar121),wstar_121(loc_wstar121),'k*')
%       plot(tech.alpha_vec(loc_wstar122),wstar_122(loc_wstar122),'k*')
%       plot(tech.alpha_vec(loc_wstar123),wstar_123(loc_wstar123),'k*')
      plot(tech.alpha_vec(loc_wstar_worker121),wstar_worker121(loc_wstar_worker121),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker122),wstar_worker122(loc_wstar_worker122),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker123),wstar_worker123(loc_wstar_worker123),'k*')
      title('Optimal Wage (\sigma = 0.5, \gamma = 1.3)','FontSize', 20)
      ylim([0.4 0.69])
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,wstar_131,'-','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_132,'--','LineWidth', 1.5,'color','b')
%       plot(tech.alpha_vec,wstar_133,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker131,'-','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker132,'--','LineWidth', 1.5,'color','r')
%       plot(tech.alpha_vec,wstar_worker133,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar131] = max(wstar_131);
%       [ciccio, loc_wstar132] = max(wstar_132);
%       [ciccio, loc_wstar133] = max(wstar_133);
      [ciccio, loc_wstar_worker_131] = max(wstar_worker131);
%       [ciccio, loc_wstar_worker_132] = max(wstar_worker132);
%       [ciccio, loc_wstar_worker_133] = max(wstar_worker133);
      [ciccio, loc_U131] = max(U_131);
%       [ciccio, loc_U132] = max(U_132);
%       [ciccio, loc_U133] = max(U_133);
      [ciccio, loc_U_worker131] = max(U_worker131);
%       [ciccio, loc_U_worker132] = max(U_worker132);
%       [ciccio, loc_U_worker133] = max(U_worker133);
      plot(tech.alpha_vec(loc_U131),wstar_131(loc_U131),'ks')
%       plot(tech.alpha_vec(loc_U132),wstar_132(loc_U132),'ks')
%       plot(tech.alpha_vec(loc_U133),wstar_133(loc_U133),'ks')
      plot(tech.alpha_vec(loc_U_worker131),wstar_worker131(loc_U_worker131),'ks')
%       plot(tech.alpha_vec(loc_U_worker132),wstar_worker132(loc_U_worker132),'ks')
%       plot(tech.alpha_vec(loc_U_worker133),wstar_worker133(loc_U_worker133),'ks')
      plot(tech.alpha_vec(loc_wstar131),wstar_131(loc_wstar131),'k*')
%       plot(tech.alpha_vec(loc_wstar132),wstar_132(loc_wstar132),'k*')
%       plot(tech.alpha_vec(loc_wstar133),wstar_133(loc_wstar133),'k*')     
      plot(tech.alpha_vec(loc_wstar_worker_131),wstar_worker131(loc_wstar_worker_131),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker_132),wstar_worker132(loc_wstar_worker_132),'k*')
%       plot(tech.alpha_vec(loc_wstar_worker_133),wstar_worker133(loc_wstar_worker_133),'k*')
      title('Optimal Wage (\sigma = 0.5, \gamma = 1.6)','FontSize', 20)
      ylim([0.4 0.69])
      hold off
      xlabel('Debt')
      grid on
      
print(h,'w_riskaverse','-dpdf','-fillpage')