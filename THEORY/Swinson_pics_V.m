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

      %Plotting V
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,V_111,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_112,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V111] = max(V_111);
      [ciccio, loc_V112] = max(V_112);
      [ciccio, loc_V113] = max(V_113);
      plot(tech.alpha_vec(loc_V111),V_111(loc_V111),'ks')
      plot(tech.alpha_vec(loc_V112),V_112(loc_V112),'ks')
      plot(tech.alpha_vec(loc_V113),V_113(loc_V113),'ks')
      title('V for \gamma equal to 1','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,V_121,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_122,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V121] = max(V_121);
      [ciccio, loc_V122] = max(V_122);
      [ciccio, loc_V123] = max(V_123);
      plot(tech.alpha_vec(loc_V121),V_121(loc_V121),'ks')
      plot(tech.alpha_vec(loc_V122),V_122(loc_V122),'ks')
      plot(tech.alpha_vec(loc_V123),V_123(loc_V123),'ks')
      title('V for \gamma equal to 1.3','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,V_131,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_132,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,V_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_V131] = max(V_131);
      [ciccio, loc_V132] = max(V_132);
      [ciccio, loc_V133] = max(V_133);
      plot(tech.alpha_vec(loc_V131),V_131(loc_V131),'ks')
      plot(tech.alpha_vec(loc_V132),V_132(loc_V132),'ks')
      plot(tech.alpha_vec(loc_V133),V_133(loc_V133),'ks')     
      title('V for \gamma equal to 1.6','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      ghjk
%       plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
%             *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
%             'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).V);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).V(loc(ii)),'ks')
      end
      title('V','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%     ylim([0.622 0.715]) %focus
%     ylim([0.09 0.32])  %bzero
%     ylim([0.610 0.858])  %bdot2
      xlabel('\alpha')
      grid on