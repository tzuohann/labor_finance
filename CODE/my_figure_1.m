      
      %Figure 1
      % ------  U  ------  phi   ------  q(theta) 
      % ------  w  ------  theta ------  p(theta) 
      bla = figure(1);
      newPosition = [1 29 1680 955];
      newUnits = 'pixels';
      set(gcf,'Position', newPosition,'Units', newUnits);
      hL.Orientation = 'horizontal';
      hL.FontSize = 16;
      
      %==========================================================================
      
      %Plotting U
      subplot(2,3,1)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).U_D,lines{ii},'LineWidth', 2,'color',color{ii})
      end

      for ii = 1:length(models)
            [~,loc(ii)] = max(dm.(models{ii}).U_D);
            plot(D_grid(loc(ii)),dm.(models{ii}).U_D(loc(ii)),'ks')
      end
      title('U','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting wstar
      subplot(2,3,4)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).EnteringW_D,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
            [~,loc_w(ii)] = max(dm.(models{ii}).EnteringW_D);
            plot(D_grid(loc(ii)),dm.(models{ii}).EnteringW_D(loc(ii)),'ks')
            plot(D_grid(loc_w(ii)),dm.(models{ii}).EnteringW_D(loc_w(ii)),'*')
      end
      title('Exp. W Value Cond. on Match','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      dm.p.firmSepProb = sum(isnan(dm.p.Estar_D))./nPhi;
      dm.l.firmSepProb = sum(isnan(dm.l.Estar_D))./nPhi;
      %Plotting probability of separation
      subplot(2,3,2)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).firmSepProb,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
      end
      title('Firm Sep Prob','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting q(theta)
      subplot(2,3,3)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).Q_D,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_q(ii)] = min(dm.(models{ii}).Q_D);
            plot(D_grid(loc(ii)),dm.(models{ii}).Q_D(loc(ii)),'ks')
            plot(D_grid(loc_q(ii)),dm.(models{ii}).Q_D(loc_q(ii)),'*')
      end
      title('q(\theta)','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      dm.p.workerSepProb = sum(abs(bsxfun(@minus,dm.p.Estar_D,dm.p.U_D)) <= 1e-8)./nPhi;
      dm.l.workerSepProb = sum(abs(bsxfun(@minus,dm.l.Estar_D,dm.l.U_D)) <= 1e-8)./nPhi;
      %Plotting probability of separation
      subplot(2,3,5)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).workerSepProb,lines{ii},'LineWidth', 2,...
                  'color',color{ii})
      end
      title('Worker Sep Prob','FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================
      
      %Plotting p(theta)
      subplot(2,3,6)
      hold on
      for ii = 1:length(models)
            plot(D_grid,dm.(models{ii}).P_D,lines{ii},'LineWidth', 2,'color',color{ii})
      end
      for ii = 1:length(models)
            [~,loc_p(ii)] = max(dm.(models{ii}).P_D);
            plot(D_grid(loc(ii)),dm.(models{ii}).P_D(loc(ii)),'ks')
            plot(D_grid(loc_p(ii)),dm.(models{ii}).P_D(loc_p(ii)),'*')
      end
      title('p(\theta)', 'FontSize', 20)
      hold off
      axis tight
      V = axis;
      axis([min(D_grid),max(D_grid),V(3),V(4)])
      xlabel('\alpha')
      grid on
      
      %==========================================================================