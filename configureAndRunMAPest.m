
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Preliminaries
% Set JAVA path
setupJAVAPath();
% Option for MAP computation (false by default to save computational time)
opts.Sigma_dgiveny = false;

% Create a structure 'bucket' where storing different stuff generating by
% running the code
bucket = struct;

%% Configure
% Root folder of the dataset
bucket.datasetRoot = fullfile(pwd, 'dataset');

%% Tuning covariance
disp(' ');
disp('======================== COVARIANCE TUNING ==========================');
opts.tuneCovariance = false;

if ~exist(fullfile(pwd,sprintf(('/dataset/S%02d/Task%d/processed/covarianceTuning.mat'),subjectID,taskID)), 'file')
    opts.tuneCovariance = true;
    
    covTun.rangePowerForPolarizedTuning = [1, 2, 3, 4];
    for powerIdx = 1 : length(covTun.rangePowerForPolarizedTuning)
        disp('=====================================================================');
        fprintf('[Start] Covariance tuning SUBJECT_%02d, TRIAL_%02d. Test with power %01d\n',subjectID,taskID, powerIdx);
        covarianceSelectedValue = covTun.rangePowerForPolarizedTuning(powerIdx);
        config;    
        
        % Move folders
        path_destination  = bucket.pathToCovarianceTuningData;
        path_source_task1 = bucket.pathToProcessedData_SOTtask1;
        movefile(path_source_task1,path_destination);
        path_source_task2 = bucket.pathToProcessedData_SOTtask2;
        movefile(path_source_task2,path_destination);
        
        % Rename folders by adding the power
        oldFolder_SOTtask1 = fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask1');
        newFolder_SOTtask1 = fullfile(bucket.pathToCovarianceTuningData,sprintf('processed_SOTtask1_power%d', priors.absPowerValue));
        mkdir(oldFolder_SOTtask1);
        movefile(oldFolder_SOTtask1,newFolder_SOTtask1);
        oldFolder_SOTtask2 = fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2');
        newFolder_SOTtask2 = fullfile(bucket.pathToCovarianceTuningData,sprintf('processed_SOTtask2_power%d', priors.absPowerValue));
        mkdir(oldFolder_SOTtask2);
        movefile(oldFolder_SOTtask2,newFolder_SOTtask2);
    end
    % Define chosen covarianceChosenSelectedValue
    tuningCovariance_measVSestim;
    covarianceSelectedValue = covarianceTuning.chosenSelectedValue;
    
    % Remove file/folders related to the covariance tuning analysis
    clearvars covTun;
else
    load(fullfile(pwd,sprintf(('/dataset/S%02d/Task%d/processed/covarianceTuning.mat'),subjectID,taskID)), 'covarianceTuning')
    covarianceSelectedValue = covarianceTuning.chosenSelectedValue;
end
opts.tuneCovariance = false;
fprintf('[End] Covariance tuning SUBJECT_%02d, TRIAL_%02d\n',subjectID,taskID);

%% Launch the analysis script
clearvars -except bucket opts subjectID task taskID covarianceSelectedValue powerIdx;

disp(' ');
disp('===================== FLOATING-BASE ANALYSIS ========================');
fprintf('[Start] Analysis SUBJECT_%02d, TRIAL_%02d\n',subjectID,taskID);
fprintf('[Info] Trusted covariance Sigma_trusted = 1e-%01d\n',covarianceSelectedValue);
fprintf('[Info] Trusted covariance Sigma_notrusted = 1e%01d\n',covarianceSelectedValue);
config;
fprintf('[End] Analysis SUBJECT_%02d, TRIAL_%02d\n',subjectID,taskID);
disp('===================================================================');
