%Common features of the figure
lines           = {'k-','k--'};     %{'k-','k--','k-.','k:'};
color           = {'b','r'};        %{'b','r','c','m'};
models          = {'sp','sl'};      %{'sp','sl','wp','wl'};

%Plotting U
subplot(2,4,1)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).U,lines{ii},'LineWidth', 2,'color',color{ii})
end
plot(tech.alpha_vec,ones(1,length(tech.alpha_vec))...
    *params.utilFunc(params.b)*(1+params.BETA+params.BETA^2),'LineWidth',2,'color','k')
for ii = 1:length(models)
    [~,loc(ii)] = max(s.(models{ii}).U);
    plot(tech.alpha_vec(loc(ii)),s.(models{ii}).U(loc(ii)),'ks')
end
title('U','FontSize', 20)
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
grid on

%Plotting wstar
subplot(2,4,5)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).wstar,lines{ii},'LineWidth', 2,'color',color{ii})
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
grid on

%Plotting phi_cutoff
subplot(2,4,2)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).philim,lines{ii},'LineWidth', 2,'color',color{ii})
end
for ii = 1:length(models)
    plot(tech.alpha_vec(loc(ii)),s.(models{ii}).philim(loc(ii)),'ks')
end
title('\phi Cutoff','FontSize', 20)
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
grid on

%Plotting E2
subplot(2,4,6)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).E,lines{ii},'LineWidth', 2,'color',color{ii})
end
for ii = 1:length(models)
    [~,loc_E(ii)] = max(s.(models{ii}).E);
    plot(tech.alpha_vec(loc(ii)),s.(models{ii}).E(loc(ii)),'ks')
    plot(tech.alpha_vec(loc_E(ii)),s.(models{ii}).E(loc_E(ii)),'*')
end
title('E2','FontSize', 20)
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
grid on

%Plotting profits when matched
subplot(2,4,3)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).obj./s.(models{ii}).q,lines{ii},'LineWidth', 2,'color',color{ii})
end
for ii = 1:length(models)
    [~,loc_prof(ii)] = max(s.(models{ii}).obj./s.(models{ii}).q);
    plot(tech.alpha_vec(loc(ii)),s.(models{ii}).obj(loc(ii)) ./ s.(models{ii}).q(loc(ii)),'ks')
    plot(tech.alpha_vec(loc_prof(ii)),s.(models{ii}).obj(loc_prof)./s.(models{ii}).q(loc_prof),'*')
end
title('\pi if matched','FontSize', 20)
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
grid on

%Plotting q(theta)
subplot(2,4,7)
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
grid on

%Plotting theta
subplot(2,4,4)
hold on
for ii = 1:length(models)
    plot(tech.alpha_vec,s.(models{ii}).theta,lines{ii},'LineWidth', 2,'color',color{ii})
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
grid on

%Plotting p(theta)
subplot(2,4,8)
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
grid on

% Construct a Legend with the data from the sub-plots
hL = legend(models);
% Programatically move the Legend
newPosition = [0.2 -0.05 0.6 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
hL.Orientation = 'horizontal';
hL.FontSize = 16;