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

      %Plotting ptheta
      
      %gamma = 1
      subplot(3,1,1)
      hold on
      plot(tech.alpha_vec,ptheta_111,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_112,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_113,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_ptheta111] = max(ptheta_111);
      [ciccio, loc_ptheta112] = max(ptheta_112);
      [ciccio, loc_ptheta113] = max(ptheta_113);
      plot(tech.alpha_vec(loc_ptheta111),ptheta_111(loc_ptheta111),'ks')
      plot(tech.alpha_vec(loc_ptheta112),ptheta_112(loc_ptheta112),'ks')
      plot(tech.alpha_vec(loc_ptheta113),ptheta_113(loc_ptheta113),'ks')
      title('ptheta for \gamma equal to 1','FontSize', 20)
      legend('Zero b Search','Low b Search','High b Search')
      hold off
      xlabel('Debt')
      grid on
     
      %gamma = 1.3
      subplot(3,1,2)
      hold on
      plot(tech.alpha_vec,ptheta_121,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_122,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_123,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_ptheta121] = max(ptheta_121);
      [ciccio, loc_ptheta122] = max(ptheta_122);
      [ciccio, loc_ptheta123] = max(ptheta_123);
      plot(tech.alpha_vec(loc_ptheta121),ptheta_121(loc_ptheta121),'ks')
      plot(tech.alpha_vec(loc_ptheta122),ptheta_122(loc_ptheta122),'ks')
      plot(tech.alpha_vec(loc_ptheta123),ptheta_123(loc_ptheta123),'ks')
      title('ptheta for \gamma equal to 1.3','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      %gamma = 1.6
      subplot(3,1,3)
      hold on
      plot(tech.alpha_vec,ptheta_131,'-','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_132,'--','LineWidth', 1.5,'color','b')
      plot(tech.alpha_vec,ptheta_133,':','LineWidth', 1.5,'color','b')
      [ciccio, loc_ptheta131] = max(ptheta_131);
      [ciccio, loc_ptheta132] = max(ptheta_132);
      [ciccio, loc_ptheta133] = max(ptheta_133);
      plot(tech.alpha_vec(loc_ptheta131),ptheta_131(loc_ptheta131),'ks')
      plot(tech.alpha_vec(loc_ptheta132),ptheta_132(loc_ptheta132),'ks')
      plot(tech.alpha_vec(loc_ptheta133),ptheta_133(loc_ptheta133),'ks')     
      title('ptheta for \gamma equal to 1.6','FontSize', 20)
      hold off
      xlabel('Debt')
      grid on
      
      ghjk
%       plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
%             *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
%             'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).ptheta);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).ptheta(loc(ii)),'ks')
      end
      title('ptheta','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%     ylim([0.622 0.715]) %focus
%     ylim([0.09 0.32])  %bzero
%     ylim([0.610 0.858])  %bdot2
      xlabel('\alpha')
      grid on