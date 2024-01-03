%%
% Reproduces Iso vs. Ortho plot for Compact vs. Diffuse 
% co-tuned condition (Fig. 4B and 4C)
%
% Function inputs:
%   cellTable: structure containing neuron data
%   cellCondTuned: vector of 1's and 0's that denotes which cells should be
%       included (e.g., only tuned cells)
%   cellCondNonVis: vector of 1's and 0's that denotes which cells should be
%       included (e.g., only non-visually responsive cells)
%
%%
function Fig4BC(cellTable,cellCondTuned,cellCondNonVis)

%% We must average the results over the appropriate cells for each condition

% Compact vs. Diffuse thresholds
ensDistMetric = cellTable.cellEnsMeaD;
spatialThresh = [-inf 200; 200 inf];

totalNumEns = cellTable.ensNum(end);
distBins = [15:15:150];
plotDist = distBins(1:end-1) + diff(distBins(1:2))/2;

% Ensemble thresholds
ensThreshs = [0.7 inf];
meanEnsThreshs = [0.5 inf];

% Conditions for this analysis
ensSelectorTuning = cellTable.cellEnsOSI>ensThreshs(1,1) & cellTable.cellEnsOSI<ensThreshs(1,2)...
    & cellTable.cellMeanEnsOSI>meanEnsThreshs(1,1) & cellTable.cellMeanEnsOSI<meanEnsThreshs(1,2);

cellSelectorOri = [cellTable.cellOrisDiff==0 cellTable.cellOrisDiff==45 ...
    cellTable.cellOrisDiff==90];

% Iso, 45, Ortho
num_conds = 4;
respAve = zeros(length(distBins)-1,2,num_conds); 
respStdErr = zeros(length(distBins)-1,2,num_conds); 
numEnsUsed = zeros(length(distBins)-1,2,num_conds); 
temp=[];
count312=1;
% Loop over the ensemble spread conditions
for jj = 1:2
    ensSelectorSpread = ensDistMetric>spatialThresh(jj,1) & ensDistMetric<spatialThresh(jj,2);
    cellDataAve = zeros(length(distBins)-1,totalNumEns,num_conds);

    % Loop over ensembles
    for ii = 1:totalNumEns
        % Loop over distances
        for ll = 1:length(distBins)-1
            cellSelectorDist = cellTable.ensNum == ii & ...
                cellTable.cellDist>distBins(ll) & cellTable.cellDist<distBins(ll+1);

            for gg = 1:num_conds

                if gg < 4
                    cellSelector = cellSelectorDist & ensSelectorTuning & ensSelectorSpread ...
                        & cellSelectorOri(:,gg) & cellCondTuned;
                else
                    cellSelector = cellSelectorDist & ensSelectorTuning & ensSelectorSpread ...
                        & cellCondNonVis;
                end

                cellDataAve(ll,ii,gg) = nanmean(cellTable.dff(cellSelector));
                % Keep track of the number of ensembles used at each distance
                numEnsUsed(ll,jj,gg) = numEnsUsed(ll,jj,gg)+sign(sum(cellSelector));
                
                if ~isempty(cellTable.expNum(cellSelector))
                    temp(jj,count312) = unique(cellTable.expNum(cellSelector));
                    count312 = count312 + 1;
                end
            end
        end
    end
    
    % Averave across ensembles
    for gg = 1:num_conds
        respAve(:,jj,gg) = nanmean(cellDataAve(:,:,gg),2);
        respStdErr(:,jj,gg) = nanstd(cellDataAve(:,:,gg),[],2)./sqrt(numEnsUsed(:,jj,gg));
        
        % Save first bin
        resp{jj,gg} = cellDataAve(1,~isnan(cellDataAve(1,:,gg)),gg);
    end    
end

%% Plot Figure 4B
colorScheme =[];
colorScheme(1,:) = [37 41 108]/255;
colorScheme(2,:) = [108 47 132]/255;
colorScheme(3,:) = [195 62 108]/255;
titles={'Iso','\pm45\circ','Ortho'};
indicesToPlot = [1 2 3];
numToPlot = length(indicesToPlot);

figure('Position',[33   207   971   688]); clf; 
for jj = 1:2
    for gg = 1:numToPlot
        if jj == 1
            subplot(2,numToPlot,gg+numToPlot*(jj)); hold on;
            if gg == 1
                ylabel(sprintf('Co-Tuned \n Compact \n Evoked ΔF/F'))
            elseif gg == 2
                xlabel('Min Distance from Ensemble (μm)')
            end
        else
            subplot(2,numToPlot,gg+numToPlot*(jj-2)); hold on;
            
            if gg == 1
                ylabel(sprintf('Co-Tuned \n Diffuse \n Evoked ΔF/F'))
            end
        end
        errorbar(plotDist,respAve(:,jj,indicesToPlot(gg)),respStdErr(:,jj,indicesToPlot(gg)),...
            'linewidth',3,'color',colorScheme(gg,:),'capsize',0);
        xlim([0 150])
        plot([0 250],0*[0 250],'k--','linewidth',1.5)
        ylim([-0.15 0.15])
        title(titles{gg})
        set(gca,'fontsize',16)
    end
end

%% Plot Figure 4C

figure('Position', [1062 460 404 420]); clf; hold on

compactLine = errorbar(1:3,squeeze(respAve(1,1,1:3)),squeeze(respStdErr(1,1,1:3)),...
    'linewidth',3,'color',[236 78 43]/255,'capsize',0);
diffuseLine = errorbar(1:3,squeeze(respAve(1,2,1:3)),squeeze(respStdErr(1,2,1:3)),...
    'linewidth',3,'color',[244 134 43]/255,'capsize',0);
plot([1 4],0+[0 0],'k--','linewidth',1.5)

% These lines are disconnected from the others
errorbar(4,squeeze(respAve(1,1,4)),squeeze(respStdErr(1,1,4)),...
    'linewidth',3,'color',[236 78 43]/255,'capsize',0)
errorbar(4,squeeze(respAve(1,2,4)),squeeze(respStdErr(1,2,4)),...
    'linewidth',3,'color',[244 134 43]/255,'capsize',0)

set(gca,'fontsize',16)
xticks([1 2 3 4])
xticklabels({'Iso', '\pm45\circ', 'Ortho','Non-vis'})
ylabel('Mean Evoked \DeltaF/F')
xlim([0.75 4.25])
legend([compactLine diffuseLine],{'Compact, Co-Tuned','Diffuse, Co-Tuned'})

end

