%%
% Recreates the key experimental panels (Figs. 2-4) of the paper:
%   IA Oldenburg, WD Hendricks, G Handy, K Shamardani, HA Bounds, B Doiron, 
%   H Adesnik. The logic of recurrent circuits in the primary visual 
%   cortex. Nature Neuroscience (2024)
%
% Written and edited by G Handy, IA Oldenburg, and WD Hendricks
%%
clear; close all; clc;

%% Adds all subfolders to the path
restoredefaultpath;
folder = fileparts(which('createMainExpFigs_reproduce.m')); 
addpath(genpath(folder));
rmpath(folder);

%% Load the compressed data
compressedData  = load('./compressedData/cellTable250622.mat');

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

%% Figure 2A: min distance plot
fprintf('-------------------------\n')
fprintf('Creating Fig 2A: min dist vs. dF/F plot\n')
Fig2A(cellTable,cellCond)
fprintf('-------------------------\n')

%% Figure 2B: Effect of the spread of ensemble
fprintf('Creating Fig 2B: ensemble spread vs. dF/F plot\n')
Fig2B(cellTable,cellCond);
fprintf('-------------------------\n')

%% Figure 3C: Iso vs. 45 vs. Ortho
% Note: the cells used here are tuned 
fprintf('Creating Fig 3C: Iso vs. Ortho\n')
Fig3C(cellTable,cellCondTuned,mouseNames);
fprintf('-------------------------\n')

%% Figure 4A: Space & Feature Min Dist Figure
fprintf('Creating Fig 4A: Space & Feature Min Dist Figure\n')
Fig4A(cellTable,cellCond);
fprintf('-------------------------\n')

%% Figure 4BC: Space & Feature Iso vs. Orthor Figure
fprintf('Creating Fig 4BC: Space & Feature Iso vs. Ortho Figure\n')
Fig4BC(cellTable,cellCondTuned,cellCondNonVis)

