%%
% Reproduces Fig. 6A in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. Nature Neuroscience (2024)
%
% Written and edited by G Handy, IA Oldenburg, and WD Hendricks
%%
clear;

% Load the simulation data
tunedExcOnly = load('./SimData/tunedExcOnly.mat');
tunedExcAndInh = load('./SimData/tunedExcAndInh.mat');

%%
colorScheme = [[3,37,126]/255; [0.5, 0, 0.5]; [195,62,108]/255];
figure('Position',[584 575 1058 340]); clf;
for gg = 1:3
    subplot(1,3,gg); hold on;
    
    h1 = plot(tunedExcOnly.dist_bins(1:end-1)*1420,tunedExcOnly.binned_delta_r_ave_v2(:,gg),'--',...
        'linewidth',1.5,'markersize',15,'color',colorScheme(gg,:));
    
    h2 = plot(tunedExcAndInh.dist_bins(1:end-1)*1420,tunedExcAndInh.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1.5,'markersize',15,'color',colorScheme(gg,:),'markerfacecolor',colorScheme(gg,:));
    plot(tunedExcAndInh.dist_bins(1:end-1)*1420,tunedExcAndInh.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',15,'color',colorScheme(gg,:));
    
    plot([0 tunedExcAndInh.dist_bins(end)]*1420,[0 tunedExcAndInh.dist_bins(end)]*0,...
        '--','linewidth',1.5,'color',[0.5 0.5 0.5])
    xlim([0 300])
    xticks([0:100:300])
    set(gca,'fontsize',16)
    ylabel('\Deltar (Hz)')
    
    ylim([-2.5 4])
    yticks([-2:2:4])
    
    if gg == 2
       legend([h1 h2],{'Tuned Exc','Tuned Exc and Inh'})
       xlabel('Min Distance from Ensemble (μm)')
    end
end


