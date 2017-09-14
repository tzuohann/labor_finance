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
            eval(['wstar_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.wstar;'])
            eval(['ptheta_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.p;'])
            eval(['qtheta_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.q;'])
            eval(['E_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.E;'])
            eval(['V_',num2str(i_1),num2str(i_2),num2str(i_3),' = s.sp.V;'])
                    
            eval(['U_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.U;'])
            eval(['wstar_worker',num2str(i_1),num2str(i_2),num2str(i_3),' = s.ws.wmax;'])                      
        end
    end
end

lines           = {'k-','k--','*'}; 

      %Plotting wstar
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,wstar_111,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_112,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_113,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker111,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker112,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker113,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar111] = max(wstar_111);
      [ciccio, loc_wstar112] = max(wstar_112);
      [ciccio, loc_wstar113] = max(wstar_113);
      [ciccio, loc_wstar_worker111] = max(wstar_worker111);
      [ciccio, loc_wstar_worker112] = max(wstar_worker112);
      [ciccio, loc_wstar_worker113] = max(wstar_worker113);
      plot(tech.alpha_vec(loc_wstar111),wstar_111(loc_wstar111),'ks')
      plot(tech.alpha_vec(loc_wstar112),wstar_112(loc_wstar112),'ks')
      plot(tech.alpha_vec(loc_wstar113),wstar_113(loc_wstar113),'ks')
      plot(tech.alpha_vec(loc_wstar_worker111),wstar_worker111(loc_wstar_worker111),'ks')
      plot(tech.alpha_vec(loc_wstar_worker112),wstar_worker112(loc_wstar_worker112),'ks')
      plot(tech.alpha_vec(loc_wstar_worker113),wstar_worker113(loc_wstar_worker113),'ks')
      title('wstar for \gamma equal to 1','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search','Max Output')
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,wstar_121,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_122,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_123,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker121,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker122,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker123,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar121] = max(wstar_121);
      [ciccio, loc_wstar122] = max(wstar_122);
      [ciccio, loc_wstar123] = max(wstar_123);
      [ciccio, loc_wstar_worker121] = max(wstar_worker121);
      [ciccio, loc_wstar_worker122] = max(wstar_worker122);
      [ciccio, loc_wstar_worker123] = max(wstar_worker123);
      plot(tech.alpha_vec(loc_wstar121),wstar_121(loc_wstar121),'ks')
      plot(tech.alpha_vec(loc_wstar122),wstar_122(loc_wstar122),'ks')
      plot(tech.alpha_vec(loc_wstar123),wstar_123(loc_wstar123),'ks')
      plot(tech.alpha_vec(loc_wstar_worker121),wstar_worker121(loc_wstar_worker121),'ks')
      plot(tech.alpha_vec(loc_wstar_worker122),wstar_worker122(loc_wstar_worker122),'ks')
      plot(tech.alpha_vec(loc_wstar_worker123),wstar_worker123(loc_wstar_worker123),'ks')
      title('wstar for \gamma equal to 1.3','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,wstar_131,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_132,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_133,':','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,wstar_worker131,'-','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker132,'--','LineWidth', 1.5,'color','r')
      plot(tech.alpha_vec,wstar_worker133,':','LineWidth', 1.5,'color','r')
      [ciccio, loc_wstar131] = max(wstar_131);
      [ciccio, loc_wstar132] = max(wstar_132);
      [ciccio, loc_wstar133] = max(wstar_133);
      [ciccio, loc_wstar_worker_131] = max(wstar_worker131);
      [ciccio, loc_wstar_worker_132] = max(wstar_worker132);
      [ciccio, loc_wstar_worker_133] = max(wstar_worker133);
      plot(tech.alpha_vec(loc_wstar131),wstar_131(loc_wstar131),'ks')
      plot(tech.alpha_vec(loc_wstar132),wstar_132(loc_wstar132),'ks')
      plot(tech.alpha_vec(loc_wstar133),wstar_133(loc_wstar133),'ks')     
      plot(tech.alpha_vec(loc_wstar_worker_131),wstar_worker131(loc_wstar_worker_131),'ks')
      plot(tech.alpha_vec(loc_wstar_worker_132),wstar_worker132(loc_wstar_worker_132),'ks')
      plot(tech.alpha_vec(loc_wstar_worker_133),wstar_worker133(loc_wstar_worker_133),'ks')
      title('wstar for \gamma equal to 1.6','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      ghjk
%       plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
%             *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
%             'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).wstar);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).wstar(loc(ii)),'ks')
      end
      title('wstar','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%     ylim([0.622 0.715]) %focus
%     ylim([0.09 0.32])  %bzero
%     ylim([0.610 0.858])  %bdot2
      xlabel('\alpha')
      grid on