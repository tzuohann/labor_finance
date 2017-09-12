clear all
close all

r = 1;
b = 0.1;
sig = 0.5;
alp = 1/3;
W = 0.01;
D = linspace(0,1-W,100);
phie  = r*D./((W + D).^(alp));
phidb = phie + b./((W + D).^(alp));



pD = - b^(1 - sig)/(1 - sig)*alp*b*(W + D).^(-alp-1) ...
      + b^(1-sig)/(1-sig) ...
      *(-alp*b*(W + D).^(-alp-1) + r*(W + D).^(-alp) - alp*r*D.*(W + D).^(-alp-1)) ...
      + (phidb.^2 - phie.^2)/2.*((W + D).^(alp-1))*alp - (phidb - phie)*r;

plot(D,pD,'LineWidth',2);

diff(pD)