%%
% Reproduces the modeling panels in Fig. 4 in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. bioRxiv (2022)
%
% Written and edited by G Handy 10/26/2022
%%
clear; close all; clc;

% Load the simulation data
tunedExcOnly = load('./SimData/tunedExcOnly.mat');
tunedExcAndInh = load('./SimData/tunedExcAndInh.mat');

%%
colorScheme = [[3,37,126]/255; [0.5, 0, 0.5]; [255,0,255]/255];
figure(44); clf;
for gg = 1:3
    subplot(1,3,gg); hold on;
    
    h1 = plot(tunedExcOnly.dist_bins(1:end-1)*1420,tunedExcOnly.binned_delta_r_ave_v2(:,gg),'--',...
        'linewidth',1.5,'markersize',15,'color',colorScheme(gg,:));
    
    h2 = plot(tunedExcAndInh.dist_bins(1:end-1)*1420,tunedExcAndInh.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1,'markersize',15,'color',colorScheme(gg,:),'markerfacecolor',colorScheme(gg,:));
    plot(tunedExcAndInh.dist_bins(1:end-1)*1420,tunedExcAndInh.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',15,'color',colorScheme(gg,:));
    
    plot([0 tunedExcAndInh.dist_bins(end)]*1420,[0 tunedExcAndInh.dist_bins(end)]*0,'k--')
    xlim([0 300])
    set(gca,'fontsize',16)
    ylabel('\Deltar (Hz)')
    xlabel('Min Distance to Target')
    ylim([-2.5 4])
    
    if gg == 2
       legend([h1 h2],{'Tuned Exc','Tuned Exc and Inh'})
    end
end


