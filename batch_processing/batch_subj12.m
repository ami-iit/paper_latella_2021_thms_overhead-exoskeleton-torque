
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Preliminaries
clc; close all; clear all;

rng(1); % Force the casual generator to be const
format long;

% Add paths
addpath(genpath('external'));
addpath(genpath('src'));
addpath(genpath('scripts'));
addpath(genpath('templates'));
addpath(genpath('dataset'));

%% Batch
subjectID = 12;
task = [0,1]; % Legend: O NE, 1 WE

for taskIdx = 1 : length(task)
    taskID = task(taskIdx);
    
    % NE
    if taskID == 0
        if ~exist(fullfile(pwd,sprintf(('/dataset/S%02d/Task%d/processed/processed_SOTtask2/y_sim_ddq.mat'),subjectID,taskID)), 'file')
            opts.EXO = false;
            configureAndRunMAPest;
        end
    end
    
    % WE
    if taskID == 1
        if ~exist(fullfile(pwd,sprintf(('/dataset/S%02d/Task%d/processed/processed_SOTtask2/y_sim_ddq.mat'),subjectID,taskID)), 'file')
            clearvars -except subjectID taskID
            opts.EXO = true;
            if opts.EXO
                opts.EXO_torqueLevelAnalysis = false;
                opts.EXO_forceLevelAnalysis  = false;
                opts.EXO_insideMAP           = true;
            end
            configureAndRunMAPest;
        end
    end
end
