clear all
close all

for i_1 = 1:1
    for i_2 = 1:3
        for i_3 = 1:3
            
            BaseName = 'File_riskneutral';
            FileName = [BaseName,'_sigma',num2str(i_1),...
                '_gamma',num2str(i_2),'_b',num2str(i_3)];
            load(FileName);
            
            eval(['U_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.U;'])
            eval(['w_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.wstar;'])
            eval(['ptheta_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.p;'])
            eval(['qtheta_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.q;'])
            eval(['E_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.E;'])
            eval(['V_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.V;'])
                    
            eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])
            eval(['wmax_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.wmax;'])                      
        end
    end
end

lines           = {'k-','k--','*'}; 

      %Plotting U
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,U_111,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_112,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_113,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_worker111,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker112,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker113,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_U111] = max(U_111);
      [ciccio, loc_U112] = max(U_112);
      [ciccio, loc_U113] = max(U_113);
      [ciccio, loc_U_worker111] = max(U_worker111);
      [ciccio, loc_U_worker112] = max(U_worker112);
      [ciccio, loc_U_worker113] = max(U_worker113);
      plot(tech.alpha_vec(loc_U111),U_111(loc_U111),'ks')
      plot(tech.alpha_vec(loc_U112),U_112(loc_U112),'ks')
      plot(tech.alpha_vec(loc_U113),U_113(loc_U113),'ks')
      plot(tech.alpha_vec(loc_U_worker111),U_worker111(loc_U_worker111),'ks')
      plot(tech.alpha_vec(loc_U_worker112),U_worker112(loc_U_worker112),'ks')
      plot(tech.alpha_vec(loc_U_worker113),U_worker113(loc_U_worker113),'ks')
      title('U for \gamma equal to 1','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search','Zero b Firm','Low b Firm','High b Firm')
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,U_121,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_122,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_123,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_worker121,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker122,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker123,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_U121] = max(U_121);
      [ciccio, loc_U122] = max(U_122);
      [ciccio, loc_U123] = max(U_123);
      [ciccio, loc_U_worker121] = max(U_worker121);
      [ciccio, loc_U_worker122] = max(U_worker122);
      [ciccio, loc_U_worker123] = max(U_worker123);
      plot(tech.alpha_vec(loc_U121),U_121(loc_U121),'ks')
      plot(tech.alpha_vec(loc_U122),U_122(loc_U122),'ks')
      plot(tech.alpha_vec(loc_U123),U_123(loc_U123),'ks')
      plot(tech.alpha_vec(loc_U_worker121),U_worker121(loc_U_worker121),'ks')
      plot(tech.alpha_vec(loc_U_worker122),U_worker122(loc_U_worker122),'ks')
      plot(tech.alpha_vec(loc_U_worker123),U_worker123(loc_U_worker123),'ks')
      title('U for \gamma equal to 1.3','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,U_131,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_132,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_133,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,U_worker131,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker132,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,U_worker133,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_U131] = max(U_131);
      [ciccio, loc_U132] = max(U_132);
      [ciccio, loc_U133] = max(U_133);
      [ciccio, loc_U_worker_131] = max(U_worker131);
      [ciccio, loc_U_worker_132] = max(U_worker132);
      [ciccio, loc_U_worker_133] = max(U_worker133);
      plot(tech.alpha_vec(loc_U131),U_131(loc_U131),'ks')
      plot(tech.alpha_vec(loc_U132),U_132(loc_U132),'ks')
      plot(tech.alpha_vec(loc_U133),U_133(loc_U133),'ks')     
      plot(tech.alpha_vec(loc_U_worker_131),U_worker131(loc_U_worker_131),'ks')
      plot(tech.alpha_vec(loc_U_worker_132),U_worker132(loc_U_worker_132),'ks')
      plot(tech.alpha_vec(loc_U_worker_133),U_worker133(loc_U_worker_133),'ks')
      title('U for \gamma equal to 1.6','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      ghjk
%       plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
%             *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
%             'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).U);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).U(loc(ii)),'ks')
      end
      title('U','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%     ylim([0.622 0.715]) %focus
%     ylim([0.09 0.32])  %bzero
%     ylim([0.610 0.858])  %bdot2
      xlabel('\alpha')
      grid on