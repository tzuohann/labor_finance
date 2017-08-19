%==========================================================================
%==========================================================================
%==========================================================================
close all

i_FC = 1;
[params,tech] = param(i_FC);

for i_FC = 1:length(params.fix_cost_grid)
      
      BaseName            = 'File_focus';
      FileName            = [BaseName, '_i_FC',num2str(i_FC)];
      load(FileName)
      
      %Common features of the figures
      lines           = {'k-'};%{'k-','k--'};     %{'k-','k--','k-.','k:'};  {'k-'};%
      color           = {'b'}; % {'b','r'};        %{'b','r','c','m'};        {'b-'}; % 
      models          = {'sp'};%{'sp','sl'};      %{'sp','sl','wp','wl'};     {'sp-'};%
      
      %==========================================================================
      %==========================================================================
      %==========================================================================
      % i_FC = i_FC*2;
      % Figure 1
      % ------ U  ----------- phi_cutoff  ------  q(theta)
      % ------ wstar  ------   theta   ---------  p(theta)
      figure(i_FC)
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
      ylim([0.622 0.715]) %focus
%       ylim([0.09 0.32])  %bzero
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
      ylim([0.27 0.7]) %focus
%       ylim([0.15 0.57]) %bzero
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
      ylim([0.48 0.69]) %focus
%       ylim([0.465 0.6]) %bzero
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
      ylim([0.44 1.07]) %focus
%       ylim([0.503 1.6]) %bzero
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
      ylim([0.315 0.52]) %focus
%       ylim([0.4 0.54]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      % Construct a Legend with the data from the sub-plots
      % hL = legend(models);
      % Programatically move the Legend
      % newPosition = [-1919          41        1920         963];
      % newUnits = 'normalized';
      % set(hL,'Position', newPosition,'Units', newUnits);
      hL.Orientation = 'horizontal';
      hL.FontSize = 16;
      
      %==========================================================================
      %==========================================================================
      %==========================================================================
      
      %Figure 2
      % ------  V  ------  V2 ------  V3
      % ------  E  ------  E2 ------  E3
      figure(46+i_FC) %length(params.fix_cost_grid)
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
            %       plot(tech.alpha_vec,s.(models{ii}).V,lines{ii},'*')
            plot(tech.alpha_vec,s.(models{ii}).obj./s.(models{ii}).q,lines{ii},...
                  'LineWidth', 2,'color',color{ii})
            [~,loc_prof(ii)] = max(s.(models{ii}).obj./s.(models{ii}).q);
            plot(tech.alpha_vec(loc(ii)),s.(models{ii}).obj(loc(ii)) ...
                  ./ s.(models{ii}).q(loc(ii)),'ks')
            plot(tech.alpha_vec(loc_prof(ii)),...
                  [s.(models{ii}).obj(loc_prof(ii))./s.(models{ii}).q(loc_prof(ii))],'*')
      end
      title('V','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
      ylim([0.052 0.182]) %focus
%       ylim([0.0201 0.356]) %bzero
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
      ylim([0.026 0.101]) %focus
%       ylim([0.0101 0.183]) %bzero
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
      ylim([0.026 0.101]) %focus
%       ylim([0.0101 0.183]) %bzero
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
      ylim([0.025 0.088]) %focus
%       ylim([0.009999 0.176]) %bzero
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
      ylim([0.48 0.635]) %focus
%       ylim([0.23 0.62]) %bzero
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
      ylim([0.225 0.32]) %focus
%       ylim([0.123 0.314]) %bzero
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
      ylim([0.246 0.335]) %focus
%       ylim([0.123 0.314]) %bzero
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
      ylim([0.235 0.33]) %focus
%       ylim([0.105 0.3]) %bzero
      xlabel('\alpha')
      grid on
      
      %==========================================================================
end

while 1 == 1
      figure(1)
      figure(46) %length(params.fix_cost_grid))
      pause(3)
      for i1 = 1:46 %length(params.fix_cost_grid)
            figure(i1)
            figure(i1 + 46)% length(params.fix_cost_grid))
            pause(1)
      end
end
