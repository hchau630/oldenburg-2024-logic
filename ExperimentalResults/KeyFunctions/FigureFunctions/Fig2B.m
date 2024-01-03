%%
% Reproduces the plot illustrating effect of ensemble spread (Fig. 2B)
%
% Function inputs:
%   cellTable: structure containing neuron data
%   cellCond: a vector of 1's and 0's that denotes which cells should be
%       included (e.g., only non-offTarget cells)
%
%%
function [ensResp] = Fig2B(cellTable,cellCond)

%% We must average the results over the appropriate cells for each condition
ensDistMetric = cellTable.cellEnsMeaD;
totalNumEns = cellTable.ensNum(end);

ensResp = zeros(totalNumEns,1);
ensSpread = zeros(totalNumEns,1);
for ii = 1:totalNumEns
   cellSelector =  cellTable.ensNum == ii ...
       & cellTable.cellDist>50 & cellTable.cellDist<150 & cellCond;
   ensResp(ii) = nanmean(cellTable.dff(cellSelector));
   ensSpread(ii) = unique(ensDistMetric(cellSelector));
end

%% Create Figure 2B
figure(); hold on;
plot(ensSpread,ensResp,'.','markersize',20,'Color',[134 135 137]/255)
plot([90 350], 0+[0 0],'k--','linewidth',1.5) 
set(gca,'fontsize',16)
fitLM = fit(double(ensSpread),ensResp,'poly1');
plot([90 350],fitLM.p2+fitLM.p1*[90 350],'linewidth',3,'Color',[232,27,37]/255)
xlabel('Spread of Ensemble (μm)')
ylabel('Mean evoked \Delta F/F')
xlim([90 350])

%% Print out the statistics
fprintf('Slope %e\n',fitLM.p1) 
[~,~, pVal] = simplifiedLinearRegression(double(ensSpread),ensResp);
fprintf('p-val: %e \n',pVal(1))

end

