%Clearing and closing
clear 
% close all

%Parameterization
[params,tech] = param();

%Computations
params.whichCommitment = 'perfect';
model = 'sp';
[s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
 s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
 s.(model).E1] = mainDynamicLoop(params,tech);
params.whichCommitment = 'limited';
model = 'sl';
[s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
 s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
 s.(model).E1] = mainDynamicLoop(params,tech);

%Worker Solution
% params.whichCommitment = 'perfect'; %perfect vs limited commitment
% model = 'wp';
% [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
%  s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
%  s.(model).E1] = mainLoop(params,tech);
% params.whichCommitment = 'limited'; %perfect vs limited commitment
% model = 'wl';
% [s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
%  s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
%  s.(model).E1] = mainLoop(params,tech);

%Plotting one big figure with all the imporant graphs
figure(1)

%Common features of the figure
lines           = {'k-','k--'};     %{'k-','k--','k-.','k:'};
color           = {'b','r'};        %{'b','r','c','m'};
models          = {'sp','sl'};      %{'sp','sl','wp','wl'};

%Plotting U
subplot(2,4,1)
hold on
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).U,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  [~,loc(i1)] = max(s.(models{i1}).U);
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).U(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).wstar,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).wstar(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).philim,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).philim(loc(i1)),'ks')
end
title('\phi Cutoff','FontSize', 20)
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
grid on

%Plotting E2 - that happens in the second period!
subplot(2,4,6)
hold on
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).E1,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).E1(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).obj./s.(models{i1}).q,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).obj(loc(i1)) ./ s.(models{i1}).q(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).q,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).q(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).theta,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).theta(loc(i1)),'ks')
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
for i1 = 1:length(models)
  plot(tech.alpha_vec,s.(models{i1}).p,lines{i1},'LineWidth', 2,'color',color{i1})
end
for i1 = 1:length(models)
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).p(loc(i1)),'ks')
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
