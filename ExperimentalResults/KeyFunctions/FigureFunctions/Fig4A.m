%%
% Reproduces Compact vs. Diffuse co-tuned plots (Fig. 4A)
%
% Function inputs:
%   cellTable: structure containing neuron data
%   cellConn: vector of 1's and 0's that denotes which cells should be
%       included (e.g., only non-offTarget cells)
%
%%
function Fig4A(cellTable,cellCond)

%% We must average the results over the appropriate cells for each condition

% Compact vs. Diffuse thresholds
ensDistMetric = cellTable.cellEnsMeaD;
spatialThresh = [-inf 200; 200 inf];

totalNumEns = cellTable.ensNum(end);
distBins = [15:15:150];
plotDist = distBins(1:end-1) + 15/2;

% Ensemble thresholds
ensThreshs = [-inf 0.3; -inf 0.3;  0.7 inf];
meanEnsThreshs = [-inf 0.5; 0.5 inf; 0.5 inf];

% Conditions for this analysis
ensSelectorSpreadTight = ensDistMetric>spatialThresh(1,1) & ensDistMetric<spatialThresh(1,2);
ensSelectorSpreadLoose = ensDistMetric>spatialThresh(2,1) & ensDistMetric<spatialThresh(2,2);

respAveTight = zeros(length(distBins)-1,3); respAveLoose = zeros(length(distBins)-1,3);
respStdErrTight = zeros(length(distBins)-1,3); respStdErrLoose = zeros(length(distBins)-1,3);
numEnsUsedTight = zeros(length(distBins)-1,3); numEnsUsedLoose = zeros(length(distBins)-1,3);

% Preallocation
tightFirst = zeros(3,totalNumEns);
looseFirst = zeros(3,totalNumEns);

temp1 = [];
temp2=[];
count31=1;
count312=1;
% Loop over conditions
for jj = 1:3
    ensSelectorTuning = cellTable.cellEnsOSI>ensThreshs(jj,1) & cellTable.cellEnsOSI<ensThreshs(jj,2)...
        & cellTable.cellMeanEnsOSI>meanEnsThreshs(jj,1) & cellTable.cellMeanEnsOSI<meanEnsThreshs(jj,2);
    
    cellDataAveTight=zeros(length(distBins)-1,totalNumEns);
    cellDataAveLoose=zeros(length(distBins)-1,totalNumEns);
    % Loop over ensembles
    for ii = 1:totalNumEns
        % Loop over distances
        for ll = 1:length(distBins)-1
            cellSelectorDist = cellTable.ensNum == ii & ...
                cellTable.cellDist>distBins(ll) & cellTable.cellDist<distBins(ll+1);
           
            cellSelectorTight = cellSelectorDist & ensSelectorTuning & ensSelectorSpreadTight & cellCond;
            cellSelectorLoose = cellSelectorDist & ensSelectorTuning & ensSelectorSpreadLoose & cellCond;
            
            cellDataAveTight(ll,ii) = nanmean(cellTable.dff(cellSelectorTight));
            cellDataAveLoose(ll,ii) = nanmean(cellTable.dff(cellSelectorLoose));
            
            % Keep track of the number of ensembles used at each distance
            numEnsUsedTight(ll,jj) = numEnsUsedTight(ll,jj) + sign(sum(cellSelectorTight));
            numEnsUsedLoose(ll,jj) = numEnsUsedLoose(ll,jj) + sign(sum(cellSelectorLoose));
            
            if ~isempty(cellTable.expNum(cellSelectorTight))
                temp1(jj,count312) = unique(cellTable.expNum(cellSelectorTight));
                count312 = count312 + 1;
            end
            
            if ~isempty(cellTable.expNum(cellSelectorLoose))
                temp2(jj,count31) = unique(cellTable.expNum(cellSelectorLoose));
                count31=count31+1;
            end
        end
    end
    
    % Averave across ensembles
    respAveTight(:,jj) = nanmean(cellDataAveTight,2);
    respStdErrTight(:,jj) = nanstd(cellDataAveTight,[],2)./sqrt(numEnsUsedTight(:,jj));
    
    respAveLoose(:,jj) = nanmean(cellDataAveLoose,2);
    respStdErrLoose(:,jj) = nanstd(cellDataAveLoose,[],2)./sqrt(numEnsUsedLoose(:,jj));
    
    %%
    tightFirst(jj,:) = cellDataAveTight(1,:);
    looseFirst(jj,:) = cellDataAveLoose(1,:);
end

%% Get the statistics
strOps = {'','*'};
fprintf('----------One-sided Rank sum test---------------\n')
p=ranksum(tightFirst(3,:),looseFirst(3,:),'tail','left'); s = strOps{1+(p<0.05)};
fprintf('Tight co-tuned (N=%d) vs Loose co-tuned (N=%d) p=%.4f%s\n',...
    sum(~isnan(tightFirst(3,:))),sum(~isnan(looseFirst(3,:))),p,s);

%% Plot Fig 4A
colorScheme =[];
colorScheme(1,1,:) = [97 99 101]/255; colorScheme(1,2,:) = [136 138 140]/255;
colorScheme(2,1,:) = [92, 64, 51]/255; colorScheme(2,2,:) = [165, 42, 42]/255;
colorScheme(3,1,:) = [236 78 43]/255; colorScheme(3,2,:) = [244 134 43]/255;

figure('Position',[332   272   812   643]); clf; 
for jj = 1:2:3
    if jj == 1
        subplot(2,2,4); hold on;
    else
        subplot(2,2,3); hold on;
        ylabel(sprintf('Compact\n Evoked ΔF/F'))
    end
    plot(plotDist,respAveTight(:,jj),'-','linewidth',2.5,'markersize',15,'color',colorScheme(jj,1,:))
    errorbar(plotDist,respAveTight(:,jj),respStdErrTight(:,jj),'linewidth',3,'color',colorScheme(jj,1,:),...
        'capsize',0)
    plot([0 250],0*[0 250],'k--')
    set(gca,'fontsize',16)
    xlim([0 150])
    ylim([-0.06 0.11])
    title(sprintf('(n=%d)',min(numEnsUsedTight(:,jj))))
    xlabel(sprintf('Min Dist from Ensemble (μm)'))
    
    if jj == 1
        subplot(2,2,2); hold on;
        temp = sprintf('Untuned');
    else
        subplot(2,2,1); hold on;
        temp = sprintf('Co-Tuned');
        ylabel(sprintf('Diffuse\n Evoked ΔF/F'))
    end
    plot(plotDist,respAveLoose(:,jj),'-','linewidth',2.5,'markersize',15,'color',colorScheme(jj,2,:))
    errorbar(plotDist,respAveLoose(:,jj),respStdErrLoose(:,jj),'linewidth',3,'color',colorScheme(jj,2,:),...
        'capsize',0)
    plot([0 250],0*[0 250],'k--')
    set(gca,'fontsize',16)
    xlim([0 150])
    ylim([-0.06 0.11])
    title(strcat(temp,sprintf(' (n=%d)',min(numEnsUsedLoose(:,jj)))))
end


end

