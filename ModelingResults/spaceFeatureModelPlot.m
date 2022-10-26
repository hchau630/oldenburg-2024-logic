%%
% Reproduces the modeling panels in Fig. 6 in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. bioRxiv (2022)
%
% Written and edited by G Handy 10/26/2022
%%
clear; close all; clc;

% Load the simulation data
tightResults = load('./SimData/tightIsoOrtho.mat');
looseResults = load('./SimData/looseIsoOrtho.mat');

%% Diffuse vs. compact panel
dist_scale = 1420;
figure(1); hold on;
h1 = plot(looseResults.dist_bins(1:end-1)*dist_scale,...
    looseResults.binned_delta_r_ave,'-','linewidth',4,...
    'color',[1, 0.75, 0.8]);
plot(looseResults.dist_bins(1:end-1)*dist_scale,...
    looseResults.binned_delta_r_ave,'s','markersize',15,'linewidth',1,...
    'color',[1, 0.75, 0.8],'MarkerFaceColor',[1, 0.75, 0.8])

h2 = plot(tightResults.dist_bins(1:end-1)*dist_scale,...
    tightResults.binned_delta_r_ave,'-','linewidth',4,...
    'color',[0.5, 0, 0.5]);
plot(tightResults.dist_bins(1:end-1)*dist_scale,...
    tightResults.binned_delta_r_ave,'s','markersize',15,'linewidth',1,...
    'color',[0.5, 0, 0.5],'MarkerFaceColor',[0.5, 0, 0.5])

x_temp = tightResults.dist_bins(1:end-1)*dist_scale;
plot([0 500],[0 0],'k--')
set(gca,'fontsize',16)
xlim([0 500])
xlabel('Min Distance to Target')
ylabel('\Deltar (Hz)')
legend([h1 h2],{'Diffuse', 'Compact'})

%% Iso vs. ortho panel
figure(2); clf; hold on;
colorScheme = [[3,37,126]/255; [0.5, 0, 0.5]; [255,0,255]/255];
subtitles = {'Iso','\pm 45','Ortho'};
for gg = 1:3
    subplot(2,3,gg+3); hold on;
    plot(tightResults.dist_bins(1:end-1)*1420,tightResults.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1,'markersize',15,'color',colorScheme(gg,:),'MarkerFaceColor',colorScheme(gg,:));
    plot(tightResults.dist_bins(1:end-1)*1420,tightResults.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',15,'color',colorScheme(gg,:));
    
    plot([0 tightResults.dist_bins(end)]*1420,[0 tightResults.dist_bins(end)]*0,'k--')
    xlim([0 300])
    set(gca,'fontsize',16)
    ylabel('\Deltar (Hz)')
    xlabel('Min Distance to Target')
    ylim([-4 2.5])
    
    subplot(2,3,gg); hold on;
    plot(looseResults.dist_bins(1:end-1)*1420,looseResults.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1.5,'markersize',15,'color',colorScheme(gg,:),'MarkerFaceColor',colorScheme(gg,:));
    plot(looseResults.dist_bins(1:end-1)*1420,looseResults.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',15,'color',colorScheme(gg,:));
    
    plot([0 looseResults.dist_bins(end)]*1420,[0 looseResults.dist_bins(end)]*0,'k--')
    xlim([0 300])
    set(gca,'fontsize',16)
    ylabel('\Deltar (Hz)')
    xlabel('Min Distance to Target')
    ylim([-4 2.5])
    title(subtitles{gg})
end

%% Iso vs. ortho panel (first data point)
figure(3); clf; hold on;
plot([1:3],tightResults.binned_delta_r_ave_v2(1,[1:3]),'s-',...
        'linewidth',1.5,'markersize',15,'color',[0.5, 0, 0.5],'markerfacecolor',[0.5, 0, 0.5]); 
plot([1:3],tightResults.binned_delta_r_ave_v2(1,[1:3]),'-',...
        'linewidth',3,'markersize',15,'color',[0.5, 0, 0.5],'markerfacecolor',[0.5, 0, 0.5]); 
plot([1:3],looseResults.binned_delta_r_ave_v2(1,[1:3]),'s-',...
        'linewidth',1,'markersize',20,'color',[1, 0.75, 0.8],'markerfacecolor',[1, 0.75, 0.8]); 
plot([1:3],looseResults.binned_delta_r_ave_v2(1,[1:3]),'-',...
        'linewidth',3,'markersize',20,'color',[1, 0.75, 0.8]); 
    
plot([0 4],[0 0],'k--','linewidth',1.5)
legend('Compact','Diffuse')    
set(gca,'fontsize',16)
xlim([0.5 3.5])
ylim([-2.5 2.5])
xticks([1 2 3]) 
xticklabels({'Iso','\pm45\circ','Ortho'})
set(gca,'fontsize',16)
ylabel('\Deltar (Hz)')

%% Iso vs. ortho subpanel
figure(4); clf; hold on;
h =[];
plot([1:3],tightResults.binned_delta_r_ee_ave(1,[1:3])-looseResults.binned_delta_r_ee_ave(1,[1:3]),...
    's-','linewidth',1.5,'markersize',15,'color',[0.9 0 0],'markerfacecolor',[0.9 0 0]);
h(1) = plot([1:3],tightResults.binned_delta_r_ee_ave(1,[1:3])-looseResults.binned_delta_r_ee_ave(1,[1:3]),...
    '-','linewidth',3,'markersize',15,'color',[0.9 0 0]);

plot([1:3],abs(tightResults.binned_delta_r_eie_ave(1,[1:3])-looseResults.binned_delta_r_eie_ave(1,[1:3])),...
    's-','linewidth',1.5,'markersize',15,'color',[0.53 0.81 0.92],'markerfacecolor',[0.53 0.81 0.92]);
h(2) =plot([1:3],abs(tightResults.binned_delta_r_eie_ave(1,[1:3])-looseResults.binned_delta_r_eie_ave(1,[1:3])),...
    '-','linewidth',3,'markersize',15,'color',[0.53 0.81 0.92]);
legend(h,{'Exc Path','Inh Path'})
set(gca,'fontsize',16)
xlim([0.5 3.5])
xticks([1 2 3]) 
xticklabels({'Iso','\pm 45','Ortho'})
ylabel('|diffuse - compact|')
set(gca,'fontsize',16)