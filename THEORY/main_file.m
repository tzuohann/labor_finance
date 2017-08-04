%Clearing and closing
clear all
close all

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
params.whichCommitment = 'perfect'; %perfect vs limited commitment
model = 'wp';
[s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
 s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
 s.(model).E1] = mainLoop(params,tech);
params.whichCommitment = 'limited'; %perfect vs limited commitment
model = 'wl';
[s.(model).U,s.(model).wstar,s.(model).theta,s.(model).p,s.(model).q,...
 s.(model).obj,s.(model).phie,s.(model).philim,s.(model).wmax,s.(model).wmin,...
 s.(model).E1] = mainLoop(params,tech);

lines       = {'k-','k--','k-.','k:'};
models = {'sp','sl','wp','wl'};

aaa = 1;
figure(aaa*4+1)

subplot(2,1,1)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).U,lines{i1})
end
legend(models)
for i1 = 1:4
  [~,loc(i1)] = max(s.(models{i1}).U);
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).U(loc(i1)),'ks')
end
title('U')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])

subplot(2,1,2)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).wstar,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).wstar(loc(i1)),'ks')
end
title('wstar')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])


figure(aaa*4+2)
subplot(2,1,1)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).philim,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).philim(loc(i1)),'ks')
end
title('Phi Cutoff')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])

subplot(2,1,2)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).E1,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).E1(loc(i1)),'ks')
end
title('E1')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])

figure(aaa*4+3)
subplot(2,1,1)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).obj./s.(models{i1}).q,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).obj(loc(i1)) ./ s.(models{i1}).q(loc(i1)),'ks')
end
title('Profits When Matched')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])

subplot(2,1,2)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).q,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).q(loc(i1)),'ks')
end
title('qtheta')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])



figure(aaa*4+4)
subplot(2,1,1)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).theta,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).theta(loc(i1)),'ks')
end
title('theta')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])

subplot(2,1,2)
hold on
for i1 = 1:4
  plot(tech.alpha_vec,s.(models{i1}).p,lines{i1})
end
legend(models)
for i1 = 1:4
  plot(tech.alpha_vec(loc(i1)),s.(models{i1}).p(loc(i1)),'ks')
end
title('ptheta')
hold off
axis tight
V = axis;
axis([min(tech.alpha_vec),max(tech.alpha_vec),V(3),V(4)])
