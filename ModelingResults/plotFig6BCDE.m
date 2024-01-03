%%
% Reproduces the modeling panels in Fig. 6 in:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. Nature Neuroscience (2024)
%
% Written and edited by G Handy, IA Oldenburg, and WD Hendricks
%%
clear;

% Load the simulation data
tightResults = load('./SimData/tightIsoOrtho.mat');
looseResults = load('./SimData/looseIsoOrtho.mat');

%% Fig. 6B: Diffuse vs. Compact panel
dist_scale = 1420;
figure('Position',[584 505 532 410]); clf; hold on;
h1 = plot(looseResults.dist_bins(1:end-1)*dist_scale,...
    looseResults.binned_delta_r_ave,'-','linewidth',4,...
    'color',[244 134 43]/255);
plot(looseResults.dist_bins(1:end-1)*dist_scale,...
    looseResults.binned_delta_r_ave,'s','markersize',15,'linewidth',1,...
    'color',[244 134 43]/255,'MarkerFaceColor',[244 134 43]/255)

h2 = plot(tightResults.dist_bins(1:end-1)*dist_scale,...
    tightResults.binned_delta_r_ave,'-','linewidth',4,...
    'color',[236 78 43]/255);
plot(tightResults.dist_bins(1:end-1)*dist_scale,...
    tightResults.binned_delta_r_ave,'s','markersize',15,'linewidth',1,...
    'color',[236 78 43]/255,'MarkerFaceColor',[236 78 43]/255)

x_temp = tightResults.dist_bins(1:end-1)*dist_scale;
plot([0 500],[0 0],'--','color',[0.5 0.5 0.5],'linewidth',1.5)
set(gca,'fontsize',16)
xlim([0 500])
xlabel('Min Distance from Ensemble (μm)')
ylabel('\Deltar (Hz)')
legend([h1 h2],{'Diffuse, co-tuned', 'Compact, co-tuned'})

%% Fig. 6C: Exc/Inh paths for min distance plot
figure('Position',[628   522   483   405]); clf; hold on;
h =[];
excPathC = plot(tightResults.dist_bins(1:end-1)*1420,nanmean(tightResults.binned_delta_r_ee_ave(:,[1:3]),2),...
    's-','linewidth',1.5,'color',[180 27 41]/255,'MarkerFaceColor',[180 27 41]/255);
excPathD = plot(tightResults.dist_bins(1:end-1)*1420,nanmean(looseResults.binned_delta_r_ee_ave(:,[1:3]),2),...
    's-','linewidth',1.5,'color',[218 141 148]/255,'MarkerFaceColor',[218 141 148]/255);

inhPathC = plot(tightResults.dist_bins(1:end-1)*1420,nanmean(tightResults.binned_delta_r_eie_ave(:,[1:3]),2),...
    's-','linewidth',1.5,'color',[0 165 232]/255,'MarkerFaceColor',[0 165 232]/255);
inhPathD = plot(tightResults.dist_bins(1:end-1)*1420,nanmean(looseResults.binned_delta_r_eie_ave(:,[1:3]),2),...
    's-','linewidth',1.5,'color',[128 210 244]/255,'MarkerFaceColor',[128 210 244]/255);

plot([0 300],[0 0],'--','color',[0.5 0.5 0.5],'LineWidth',1.5)

legend([excPathD,excPathC,inhPathD,inhPathC],{'Exc (Diffuse)','Exc (Compact)',...
    'Inh (Diffuse)','Inh (Compact)'})
set(gca,'fontsize',16)
xlim([0 300])
xlabel('Min. Distance from Ensemble (μm)')
ylabel('Input Currents')
ylim([-20 20])
yticks([-20:5:20])
set(gca,'fontsize',16)

%% Fig. 6C (inset): Exc/Inh paths for min distance plot
figure('Position',[628   522   483   405]); clf; hold on;
h =[];
excPath = plot(tightResults.dist_bins(1:end-1)*1420,nanmean(tightResults.binned_delta_r_ee_ave(:,[1:3]),2)-nanmean(looseResults.binned_delta_r_ee_ave(:,[1:3]),2),...
    '-','linewidth',2,'color',[180 27 41]/255);
inhPath = plot(tightResults.dist_bins(1:end-1)*1420,abs(nanmean(tightResults.binned_delta_r_eie_ave(:,[1:3]),2)-nanmean(looseResults.binned_delta_r_eie_ave(:,[1:3]),2)),...
    '-','linewidth',2,'color',[0 165 232]/255);
legend([excPath, inhPath],{'Exc Path','Inh Path'})
set(gca,'fontsize',16)

xlim([0 300])
xlabel('Min. Distance from Ensemble (μm)')
ylabel('|diffuse - compact|')
ylim([0 10])
yticks([0 5 10])
set(gca,'fontsize',16)


%% Fig. 6D: Iso vs. Ortho panel
figure('Position', [584 391 758 524]); clf; hold on;
colorScheme = [[3,37,126]/255; [0.5, 0, 0.5]; [195,62,108]/255];
subtitles = {'Iso','\pm 45','Ortho'};
for gg = 1:3
    subplot(2,3,gg+3); hold on;
    plot(tightResults.dist_bins(1:end-1)*1420,tightResults.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1,'markersize',10,'color',colorScheme(gg,:),'MarkerFaceColor',colorScheme(gg,:));
    plot(tightResults.dist_bins(1:end-1)*1420,tightResults.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',10,'color',colorScheme(gg,:));
    
    plot([0 tightResults.dist_bins(end)]*1420,[0 tightResults.dist_bins(end)]*0,...
        '--','color',[0.5 0.5 0.5],'linewidth',1.5)
    xlim([0 300])
    set(gca,'fontsize',16)
    ylim([-4 2.5])
    if gg == 1
        ylabel(sprintf('Compact \n Δr (Hz)'))
    elseif gg == 2
       xlabel('Min Distance from Ensemble (μm)')
    end
    
    subplot(2,3,gg); hold on;
    plot(looseResults.dist_bins(1:end-1)*1420,looseResults.binned_delta_r_ave_v2(:,gg),'s-',...
        'linewidth',1.5,'markersize',10,'color',colorScheme(gg,:),'MarkerFaceColor',colorScheme(gg,:));
    plot(looseResults.dist_bins(1:end-1)*1420,looseResults.binned_delta_r_ave_v2(:,gg),'-',...
        'linewidth',3,'markersize',10,'color',colorScheme(gg,:));
    
    plot([0 looseResults.dist_bins(end)]*1420,[0 looseResults.dist_bins(end)]*0,...
        '--','color',[0.5 0.5 0.5],'linewidth',1.5)
    xlim([0 300])
    set(gca,'fontsize',16)
    ylabel('\Deltar (Hz)')
    ylim([-4 2.5])
    title(subtitles{gg})
    if gg == 1
        ylabel(sprintf('Diffuse \n Δr (Hz)'))
    end
end

%% Fig. 6E: Iso vs. ortho panel (first data point)
figure('Position',[175   530   430   420]); clf; hold on;
compactLine = plot([1:3],tightResults.binned_delta_r_ave_v2(1,[1:3]),'s-',...
        'linewidth',1.5,'markersize',15,'color',[236 78 43]/255,'markerfacecolor',[236 78 43]/255); 
plot([1:3],tightResults.binned_delta_r_ave_v2(1,[1:3]),'-',...
        'linewidth',3,'markersize',15,'color',[236 78 43]/255,'markerfacecolor',[236 78 43]/255); 
diffuseLine = plot([1:3],looseResults.binned_delta_r_ave_v2(1,[1:3]),'s-',...
        'linewidth',1,'markersize',20,'color',[244 134 43]/255,'markerfacecolor',[244 134 43]/255); 
plot([1:3],looseResults.binned_delta_r_ave_v2(1,[1:3]),'-',...
        'linewidth',3,'markersize',20,'color',[244 134 43]/255); 
    
plot([0 4],[0 0],'k--','linewidth',1.5)
legend([diffuseLine,compactLine],{'Diffuse, Co-Tuned','Compact, Co-Tuned'})    
set(gca,'fontsize',16)
xlim([0.5 3.5])
ylim([-2.5 2.5])
yticks([-2: 1: 2])
xticks([1 2 3]) 
xticklabels({'Iso','\pm45\circ','Ortho'})
set(gca,'fontsize',16)
ylabel('\Deltar (Hz)')

%% Fig. 6E (inset): Exc/Inh paths for Iso vs. ortho
figure('Position',[628   522   483   405]); clf; hold on;
h =[];
plot([1:3],tightResults.binned_delta_r_ee_ave(1,[1:3])-looseResults.binned_delta_r_ee_ave(1,[1:3]),...
    's-','linewidth',1.5,'markersize',15,'color',[180 27 41]/255,'markerfacecolor',[180 27 41]/255);
h(1) = plot([1:3],tightResults.binned_delta_r_ee_ave(1,[1:3])-looseResults.binned_delta_r_ee_ave(1,[1:3]),...
    '-','linewidth',3,'markersize',15,'color',[180 27 41]/255);

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