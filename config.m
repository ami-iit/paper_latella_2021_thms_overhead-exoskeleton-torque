
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Priors setting
priors.absPowerValue = covarianceSelectedValue;
priors.trusted       = str2double(strcat('1e-',num2str(priors.absPowerValue))); % magnitude for trusted values
priors.no_trusted    = str2double(strcat('1e' ,num2str(priors.absPowerValue))); % magnitude for non trusted values
prior;

%% Run MAPest stack of tasks (SOT)
% =========================================================================
%  RUN TASK1
disp('=====================================================================');
disp('=====================================================================');
disp('[Start] Run SOT Task1...');
opts.task1_SOT      = true;
opts.stackOfTaskMAP = true; % argument value for berdy functions Task1
main;
disp('[End] Run SOT Task1.');

% =========================================================================
%  RUN TASK2
disp('=====================================================================');
disp('=====================================================================');
disp('[Start] Run SOT Task2...');
opts.task1_SOT      = false;
opts.stackOfTaskMAP = false; % argument value for berdy functions Task2
main;
disp('[End] Run SOT Task2.');
