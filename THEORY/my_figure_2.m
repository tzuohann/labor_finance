
      %Figure 2
      % ------  V  ------  V2 ------  V3 ------ (1-phi_c)V3
      % ------  E  ------  E2 ------  E3 ------ (1-phi_c)E3 + phi_c u(b)
      
      newPosition = [1 41 1920 963]; %[1          41        1920        963];
      newUnits = 'normalized';
      set(gcf,'Position', newPosition,'Units', newUnits);
      hL.Orientation = 'horizontal';
      hL.FontSize = 16;
      
      %==========================================================================
      
      %Plotting V
      subplot(2,4,1)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).V,lines{ii},...
                  'LineWidth', 2,'color',color{ii})
%             plot(tech.alpha_vec,s.(models{ii}).V_max,lines{ii},'LineWidth', 2,'color','k')
            [~,loc_prof(ii)] = max(s.(models{ii}).obj./s.(models{ii}).q);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).V(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_prof(ii)),s.(models{ii}).V(loc_prof(ii)),'*')
      end
      title('V','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.052 0.19]) %focus
%       ylim([0.0201 0.356]) %bzero
%       ylim([0.0157 0.208])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting V2
      subplot(2,4,2)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).V2,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
            [~,loc_V2(ii)] = max(s.(models{ii}).V2);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).V2(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_V2(ii)),...
                  [s.(models{ii}).V2(loc_V2(ii))],'*')
      end
      title('V2','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.026 0.11]) %focus
%       ylim([0.0101 0.183]) %bzero
%       ylim([0.0079 0.118])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting V3
      subplot(2,4,3)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).V3,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
            [~,loc_V2(ii)] = max(s.(models{ii}).V3);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).V3(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_V2(ii)),...
                  [s.(models{ii}).V3(loc_V2(ii))],'*')
      end
      title('V3','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%        ylim([0.026 0.11]) %focus
%       ylim([0.0101 0.183]) %bzero
%       ylim([0.0079 0.118])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting (1 - phi_cutoff)*V3
      subplot(2,4,4)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,(1-s.(models{ii}).philim).*s.(models{ii}).V3,...
                  lines{ii},'LineWidth', 2,'color',color{ii})
            [~,loc_V3(ii)] = max((1-s.(models{ii}).philim).*s.(models{ii}).V3);
            plot(tech.alpha_vec(loc(ii)),...
                  (1-s.(models{ii}).philim(loc(ii))).*s.(models{ii}).V3(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_V3(ii)),...
                  [(1-s.(models{ii}).philim(loc_V3(ii))).*s.(models{ii}).V3(loc_V3(ii))],'*')
      end
      title('(1-\phi_c)V3','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.025 0.1]) %focus
% %       ylim([0.009999 0.176]) %bzero
%       ylim([0.00725 0.11])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting E
      subplot(2,4,5)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).E,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_E(ii)] = max(s.(models{ii}).E);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).E(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_E(ii)),s.(models{ii}).E(loc_E(ii)),'*')
      end
      title('E','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.48 0.635]) %focus
%       ylim([0.23 0.62]) %bzero
%       ylim([0.45 0.675])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting E2
      subplot(2,4,6)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).E2,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_E2(ii)] = max(s.(models{ii}).E2);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).E2(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_E2(ii)),s.(models{ii}).E2(loc_E2(ii)),'*')
      end
      title('E2','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.22 0.32]) %focus
%       ylim([0.123 0.314]) %bzero
%       ylim([0.21 0.34])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting E3
      subplot(2,4,7)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).E3,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_E3(ii)] = max(s.(models{ii}).E3);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).E3(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_E3(ii)),s.(models{ii}).E3(loc_E3(ii)),'*')
      end
      title('E3','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.24 0.335]) %focus
%       ylim([0.123 0.314]) %bzero
%       ylim([0.230 0.36])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting (1 - phicutoff)*E3 + phicutoff*u(b)
      subplot(2,4,8)
      hold on
      for ii = 1:length(models)
            guy{ii} = (1 - s.(models{ii}).philim).*s.(models{ii}).E3 + ...
                  s.(models{ii}).philim.*params.utilFunc(params.b);
            plot(tech.alpha_vec,guy{ii},lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_guy(ii)] = max(guy{ii});
            plot(tech.alpha_vec(loc(ii)),guy{ii}(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_guy(ii)),guy{ii}(loc_guy(ii)),'*')
      end
      title('\phi_c u(b) + (1-\phi_c)E3','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.23 0.33]) %focus
%     ylim([0.105 0.3]) %bzero
%       ylim([0.222 0.345])  %bdot2
      xlabel('\alpha')
      grid on
      
      %==========================================================================