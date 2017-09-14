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

      %Plotting E
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,E_111,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_112,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E111] = max(E_111);
      [ciccio, loc_E112] = max(E_112);
      [ciccio, loc_E113] = max(E_113);
      plot(tech.alpha_vec(loc_E111),E_111(loc_E111),'ks')
      plot(tech.alpha_vec(loc_E112),E_112(loc_E112),'ks')
      plot(tech.alpha_vec(loc_E113),E_113(loc_E113),'ks')
      title('E for \gamma equal to 1','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,E_121,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_122,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E121] = max(E_121);
      [ciccio, loc_E122] = max(E_122);
      [ciccio, loc_E123] = max(E_123);
      plot(tech.alpha_vec(loc_E121),E_121(loc_E121),'ks')
      plot(tech.alpha_vec(loc_E122),E_122(loc_E122),'ks')
      plot(tech.alpha_vec(loc_E123),E_123(loc_E123),'ks')
      title('E for \gamma equal to 1.3','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,E_131,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_132,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,E_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_E131] = max(E_131);
      [ciccio, loc_E132] = max(E_132);
      [ciccio, loc_E133] = max(E_133);
      plot(tech.alpha_vec(loc_E131),E_131(loc_E131),'ks')
      plot(tech.alpha_vec(loc_E132),E_132(loc_E132),'ks')
      plot(tech.alpha_vec(loc_E133),E_133(loc_E133),'ks')     
      title('E for \gamma equal to 1.6','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      ghjk
%       plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
%             *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
%             'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).E);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).E(loc(ii)),'ks')
      end
      title('E','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%     ylim([0.622 0.715]) %focus
%     ylim([0.09 0.32])  %bzero
%     ylim([0.610 0.858])  %bdot2
      xlabel('\alpha')
      grid on