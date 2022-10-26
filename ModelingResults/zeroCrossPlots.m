%%
% Reproduces the modeling panels in Fig. 2 in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. bioRxiv (2022)
%
% Written and edited by G Handy 10/25/2022
%%
clear; close all; clc;

% Load the simulation data sets (i.e., kappa = 0, 0.015 and 0.045)
load('./SimData/zeroCrossingData.mat')

%%
figure(1); clf; hold on;

% Plot the experimental data regime
r = rectangle('Position',[27.36 1.65 8 38.02]);
r.FaceColor = [0.75 0.75 0.75];
r.EdgeColor = 'none';

% Loop through the three parameters 
for i = 1:3
    x = data(i).zeroEst';
    y = (data(i).maxVal./abs(data(i).minVal))';

    xseg = [x(1:end-1),x(2:end)];     
    yseg = [y(1:end-1),y(2:end)]; 

    h = plot(xseg',yseg','-','LineWidth',2,'Visible','Off');
    xlim([min(x) max(x)]);
    ylim([min(y) max(y)]);
    segColors = winter(size(xseg,1)); % Choose a colormap
    exColors(i,:) = segColors(31,:); % Safe these for the next panel plot
    
    set(h, {'Color'}, mat2cell(segColors,ones(size(xseg,1),1),3))
    set(h, 'Visible', 'on')

    colormap(winter);
    scatter(x,y,1,data(i).wee0_vec(1:length(x)),'filled')
end

colorbar
box off
set(gca,'fontsize',16)
xlabel('Zero Crossing (\mum)')
ylabel('max(\Deltar) /|min(\Deltar)|')
set(gca,'fontsize',16)

ylim([0.0 8])
xticks([25:25:150])
xlim([25 150])

colorbar('YTick',[0.014:0.002:0.02])
caxis([0.014 0.02])

%%
minDist = data(1).dist_bins(1:end-1)*data(1).dist_scale;

figure(2); clf; hold on; 
plot(minDist,data(1).dataTotal(:,31),'linewidth',1.5,'color',exColors(1,:))
plot(minDist,data(3).dataTotal(:,31),'linewidth',1.5,'color',exColors(3,:))

plot([0 500],[0 0],'k--')
xlim([0 500])
set(gca,'fontsize',16)
ylabel('\Deltar (Hz)')
legend('\kappa=0','\kappa=0.045')
xlabel('Min Distance to Target')
