
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Preliminaries
close all;
clc; clear all;

% Root folder of the dataset
bucket = struct;
bucket.datasetRoot    = fullfile(pwd, 'dataset');
bucket.pathToAnalysis = fullfile(pwd, 'analysis');

addpath(genpath('external'));

% Subjects
tmp.subjects = {
    'subj01'; ...
    'subj02'; ...
    'subj03'; ...
    'subj04'; ...
    'subj05'; ...
    'subj06'; ...
    'subj07'; ...
    'subj08'; ...
    'subj09'; ...
    'subj10'; ...
    'subj11'; ...
    'subj12' ...
    };

% Blocks
block.labels = {
    'block1'; ...
    'block2'; ...
    'block3'; ...
    'block4'; ...
    'block5' ...
    };
block.nrOfBlocks = size(block.labels,1);

%% Plot preliminaries
% NE color
orangeAnDycolor = [0.952941176470588   0.592156862745098   0.172549019607843];
% WE color
greenAnDycolor  = [0.282352941176471   0.486274509803922   0.427450980392157];
% Effect colors
benefit_color_green = [0.4660 0.6740 0.1880];
noBenefit_color_red = [1 0 0];

% EXO forces colors
color.exoForce_block1 = [0.8000    0.8000    0.8000];
color.exoForce_block2 = [0.2627    0.7647    0.9804];
color.exoForce_block3 = [0.2588    0.4275    0.7608];
color.exoForce_block4 = [1.0000    0.3843    0.1608];
color.exoForce_block5 = [0.1490    0.1490    0.1490];

color.exoBlocks = {
    color.exoForce_block1,...
    color.exoForce_block2, ...
    color.exoForce_block3, ...
    color.exoForce_block4, ...
    color.exoForce_block5 ...
    };

% Plot folder
bucket.pathToPlots = fullfile(bucket.pathToAnalysis,'/plots');
if ~exist(bucket.pathToPlots)
    mkdir (bucket.pathToPlots)
end
saveON = false;

%% Analysis
disp(' ');
disp('================= START PAPER RESULTS ANALYSIS ====================');
%% Extraction data
disp('-------------------------------------------------------------------');
disp('[Start] Extraction data ...');
subjectID = [1,2];
% subjectID = [1,2,3,4,5,6,7,8,9,10,11,12];
nrOfSubject = length(subjectID);
taskID = [0,1];


for subjIdx = 1 : nrOfSubject
    intraSubj(subjIdx).subjects = tmp.subjects(subjIdx);
    exoData(subjIdx).subjects   = tmp.subjects(subjIdx);
    bucket.pathToSubject = fullfile(bucket.datasetRoot, sprintf('S%02d',subjectID(subjIdx)));
    
    if floor(subjIdx/2) == subjIdx/2 % GROUP 2 --> subjectID = [2,4,6,8,10,12];
        % 0 --> NE
        bucket.pathToTask                = fullfile(bucket.pathToSubject,sprintf('task%d',taskID(1)));
        bucket.pathToProcessedData       = fullfile(bucket.pathToTask,'processed');
        intraSubj(subjIdx).NE_synchroKin = load(fullfile(bucket.pathToTask,'/processed/synchroKin.mat'));
        intraSubj(subjIdx).NE            = load(fullfile(bucket.pathToProcessedData,'processed_SOTtask2/estimatedVariables.mat'));
        intraSubj(subjIdx).NE_errRel     = load(fullfile(bucket.pathToProcessedData,'covarianceTuning.mat'));
        % 1 --> WE
        bucket.pathToTask                = fullfile(bucket.pathToSubject,sprintf('task%d',taskID(2)));
        bucket.pathToProcessedData       = fullfile(bucket.pathToTask,'processed');
        intraSubj(subjIdx).WE_synchroKin = load(fullfile(bucket.pathToTask,'/processed/synchroKin.mat'));
        intraSubj(subjIdx).WE            = load(fullfile(bucket.pathToProcessedData,'processed_SOTtask2/estimatedVariables.mat'));
        intraSubj(subjIdx).WE_errRel     = load(fullfile(bucket.pathToProcessedData,'covarianceTuning.mat'));
    else % GROUP 1--> subjectID = [1,3,5,7,9,11]
        % 1 --> NE
        bucket.pathToTask                = fullfile(bucket.pathToSubject,sprintf('task%d',taskID(2)));
        bucket.pathToProcessedData       = fullfile(bucket.pathToTask,'processed');
        intraSubj(subjIdx).NE_synchroKin = load(fullfile(bucket.pathToTask,'/processed/synchroKin.mat'));
        intraSubj(subjIdx).NE            = load(fullfile(bucket.pathToProcessedData,'processed_SOTtask2/estimatedVariables.mat'));
        intraSubj(subjIdx).NE_errRel     = load(fullfile(bucket.pathToProcessedData,'covarianceTuning.mat'));
        % 0 --> WE
        bucket.pathToTask                = fullfile(bucket.pathToSubject,sprintf('task%d',taskID(1)));
        bucket.pathToProcessedData       = fullfile(bucket.pathToTask,'processed');
        intraSubj(subjIdx).WE_synchroKin = load(fullfile(bucket.pathToTask,'/processed/synchroKin.mat'));
        intraSubj(subjIdx).WE            = load(fullfile(bucket.pathToProcessedData,'processed_SOTtask2/estimatedVariables.mat'));
        intraSubj(subjIdx).WE_errRel     = load(fullfile(bucket.pathToProcessedData,'covarianceTuning.mat'));
    end
end
selectedJoints = load(fullfile(bucket.pathToProcessedData,'selectedJoints.mat'));
disp('[End] Extraction data');

%% ========================================================================
%%                     Inter-subject torques plots
%% ========================================================================
% This section produces the plot:
% - in Figure 7
% - in Figure 10
% - in Figure 11
disp('-------------------------------------------------------------------');
disp('[Start] Analysis of joint torques ...');
interSubjectAnalysis_torque;
disp('[End] Analysis of joint torques');

%% ========================================================================
%%                Inter-subject support exo forces plots 
%% ========================================================================
% This section produces the plot in Figure 5.
disp('-------------------------------------------------------------------');
disp('[Start] Analysis of support exo forces ...');
interSubjectAnalysis_EXOfext;
disp('[End] Analysis of support exo forces');

disp('=================== END PAPER PLOT ANALYSIS =======================');
