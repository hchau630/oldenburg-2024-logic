%%
% Reproduces Fig. 5B and 5C in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. Nature Neuroscience (2024)
%
% Written and edited by G Handy, IA Oldenburg, and WD Hendricks
%%
clear; 

% Load the simulation data sets (i.e., kappa = 0, 0.015 and 0.045)
load('./SimData/zeroCrossingData.mat')

%% Plot Fig. 5B
% Note: Some plotting tricks are used for the changing line color
figure(); clf; hold on;

% Plot the experimental data regime
r = rectangle('Position',[27.36 1.65 8 38.02]);
r.FaceColor = [0.75 0.75 0.75];
r.EdgeColor = 'none';

maxIndex = find(data(1).wee0_vec>=0.021,1);

% Loop through the three parameters 
for i = 1:3
    
    plotIndex = min(length(data(i).zeroEst),maxIndex);
    x = data(i).zeroEst(1:plotIndex)';
    y = (data(i).maxVal(1:plotIndex)./abs(data(i).minVal(1:plotIndex)))';

    xseg = [x(1:end-1),x(2:end)];     
    yseg = [y(1:end-1),y(2:end)]; 
     
    h = plot(xseg(1:plotIndex-1,:)',yseg(1:plotIndex-1,:)','-','LineWidth',3,'Visible','Off');
    xlim([min(x) max(x)]);
    ylim([min(y) max(y)]);
    segColors = winter(maxIndex-1); % Choose a colormap
    exColors(i,:) = segColors(31,:); % Save these for the next panel plot

    set(h, {'Color'}, mat2cell(segColors(1:plotIndex-1,:),ones(plotIndex-1,1),3))
    set(h, 'Visible', 'on')

    colormap(winter);
end

colorbar
box off
set(gca,'fontsize',16)
xlabel('Zero Crossing (\mum)')
ylabel('max Act./Max Supp.')
set(gca,'fontsize',16)

ylim([0.0 8])
xticks([25:25:150])
xlim([25 150])

colorbar('YTick',[0.014:0.002:0.02])
caxis([0.014 0.021])

%% Plot Fig. 5C
minDist = data(1).dist_bins(1:end-1)*data(1).dist_scale;

figure(); clf; hold on; 
plot(minDist,data(1).dataTotal(:,31),'linewidth',2,'color',exColors(1,:))
plot(minDist,data(3).dataTotal(:,31),'-.','linewidth',2,'color',exColors(3,:))

plot([0 500],[0 0],'k--')
xlim([0 500])
set(gca,'fontsize',16)
ylabel('\Deltar (Hz)')
legend('\kappa=0','\kappa=0.045')
xlabel('Min Distance to Ensemble (um)')
