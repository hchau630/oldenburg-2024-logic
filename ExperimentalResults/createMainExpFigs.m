%%
% Recreates the key experimental panels (Figs. 2-5) of the paper:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. bioRxiv (2022)
%
% Written and edited by G Handy, IA Oldenburg, and WD Hendricks
%%
clear; close all; clc;

%% Adds all subfolders to the path
restoredefaultpath;
folder = fileparts(which('createMainExpFigs.m')); 
addpath(genpath(folder));
rmpath(folder);

%% Load the compressed data
compressedData  = load('./compressedData/cellTable220817.mat');

% cellTable is a structure containing neuron data (e.g., dff, preferred
% orientation)
cellTable = compressedData.cellTable;
% Uncomment the below line to list the names of all columns of cellTable
% cellTable.Properties.VariableNames

% mouseNames lists all of the mouse names for each ensemble
mouseNames = compressedData.mouseNames;

%% Cell conditions used in the functions
cellCond = cellTable.offTarget==0; 
cellCondTuned = cellTable.offTarget==0 & cellTable.visP<0.05 & cellTable.cellOSI > 0.25;
cellCondNonVis = cellTable.offTarget==0 & cellTable.visP>0.05;

%% Figure 2: min distance plot
fprintf('-------------------------\n')
fprintf('Creating Fig 2: min dist vs. dF/F plot\n')
Fig2(cellTable,cellCond)
fprintf('-------------------------\n')

%% Figure 3: Effect of the spread of ensemble
fprintf('Creating Fig 3: ensemble spread vs. dF/F plot\n')
Fig3(cellTable,cellCond);
fprintf('-------------------------\n')

%% Figure 4: Iso vs. ortho
% Note: the cells used here are tuned 
fprintf('Creating Fig 4: Iso vs. Ortho\n')
Fig4(cellTable,cellCondTuned,mouseNames);
fprintf('-------------------------\n')

%% Figure 5: Tight co-tuned investigation
fprintf('Creating Fig 5: holo-squares\n')
Fig5a(cellTable,cellCond);
Fig5bc(cellTable,cellCondTuned,cellCondNonVis)
fprintf('-------------------------\n')
