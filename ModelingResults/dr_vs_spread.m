%%
% Reproduces the modeling panels in Fig. 3 in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. bioRxiv (2022)
%
% Written and edited by G Handy 10/14/2022
%%

clear; close all; clc;

load('./SimData/spreadSimData.mat','actDist','aveSupp','total_fit','aveExc',...
    'exc_fit','inh_fit','aveInh')

%%
xstart = 100; xend = 350;
figure(1); clf; subplot(1,2,1); hold on;

plot(actDist(actDist>0 & actDist<350),aveSupp(actDist>0 & actDist<350),'.',...
    'markersize',16,'color',[.6 .6 .6])
plot([xstart:0.1:xend],total_fit.predict([xstart:0.1:xend]'),'-','color',[0.85 0.325 0.098],...
    'linewidth',1.5)
set(gca,'fontsize',16)
xlabel('Spread of Ensemble (um)')
ylabel('Average \Deltar (Hz) of subpopulation')
xlim([100 350])


subplot(1,2,2); hold on;
hleg(1) = plot(actDist,aveExc,'.','markersize',16,'color',[0.85 0.325 0.098]);
plot([xstart:0.1:xend],exc_fit.predict([xstart:0.1:xend]'),'-','color',[0.85 0.325 0.098],'linewidth',1.5)
hleg(2) = plot(actDist,aveInh,'.','markersize',16,'color',[0 0.447 0.741]);
plot([xstart:0.1:xend],inh_fit.predict([xstart:0.1:xend]'),'-','color',[0 0.447 0.741],'linewidth',1.5)
set(gca,'fontsize',16)
xlabel('Spread of Ensemble (um)')
ylabel('Input')
xlim([100 350])
legend(hleg,{'Excitatory Pathway','Inhibitory Pathway'})

exc_fit.Coefficients.Estimate(2)
inh_fit.Coefficients.Estimate(2)

perDiff = (inh_fit.Coefficients.Estimate(2)-abs(exc_fit.Coefficients.Estimate(2)))/...
    ((inh_fit.Coefficients.Estimate(2)+abs(exc_fit.Coefficients.Estimate(2)))/2)*100;
fprintf('Percent difference in slope: %.2f \n',perDiff)