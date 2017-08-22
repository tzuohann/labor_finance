      
      %Figure 1
      % ------  U  ------  phi   ------  q(theta) 
      % ------  w  ------  theta ------  p(theta) 

      newPosition = [-1919 41 1920 963]; 
      newUnits = 'normalized';
      set(gcf,'Position', newPosition,'Units', newUnits);
      hL.Orientation = 'horizontal';
      hL.FontSize = 16;
      
      %==========================================================================
      
      %Plotting U
      subplot(2,3,1)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).U,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
            *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),...
            'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc(ii)] = max(s.(models{ii}).U);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).U(loc(ii)),'ks')
      end
      title('U','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.622 0.715]) %focus
      ylim([0.09 0.32])  %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting wstar
      subplot(2,3,4)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).wstar,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
      end
      plot(tech.alpha_vec,s.(model).wmax,'LineWidth',2,'color','k')
      for ii = 1:length(models)
            [~,loc_w(ii)] = max(s.(models{ii}).wstar);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).wstar(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_w(ii)),s.(models{ii}).wstar(loc_w(ii)),'*')
      end
      title('w*','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.27 0.5]) %focus
      ylim([0.15 0.57]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting phi_cutoff
      subplot(2,3,2)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).philim,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
      end
      for ii = 1:length(models)
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).philim(loc(ii)),'ks')
      end
      title('\phi Cutoff','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.015 0.315])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting q(theta)
      subplot(2,3,3)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).q,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_q(ii)] = min(s.(models{ii}).q);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).q(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_q(ii)),s.(models{ii}).q(loc_q(ii)),'*')
      end
      title('q(\theta)','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.48 0.71]) %focus
      ylim([0.465 0.6]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting theta
      subplot(2,3,5)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).theta,lines{ii},...
                  'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_theta(ii)] = max(s.(models{ii}).theta);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).theta(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_theta(ii)),s.(models{ii}).theta(loc_theta(ii)),'*')
      end
      title('\theta','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.4 1.07]) %focus
      ylim([0.503 1.6]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting p(theta)
      subplot(2,3,6)
      hold on
      for ii = 1:length(models)
            plot(tech.alpha_vec,s.(models{ii}).p,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_p(ii)] = max(s.(models{ii}).p);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).p(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_p(ii)),s.(models{ii}).p(loc_p(ii)),'*')
      end
      title('p(\theta)', 'FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
%       ylim([0.3 0.52]) %focus
      ylim([0.4 0.54]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================