
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Preliminaries
covTun.opts.plot = false;
nrOfDoFs = double(humanModel.getNrOfDOFs);
close all;
bucket.pathToCovarianceTuningData   = fullfile(bucket.pathToTask,'covarianceTuning');

% Load y_sim_linAcc
covTun.y_sim_linAcc_power1 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power1/y_sim_linAcc.mat'),'y_sim_linAcc');
covTun.y_sim_linAcc_power2 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power2/y_sim_linAcc.mat'),'y_sim_linAcc');
covTun.y_sim_linAcc_power3 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power3/y_sim_linAcc.mat'),'y_sim_linAcc');
covTun.y_sim_linAcc_power4 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power4/y_sim_linAcc.mat'),'y_sim_linAcc');

% Load y_sim_fext
covTun.y_sim_fext_power1 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power1/y_sim_fext.mat'),'y_sim_fext');
covTun.y_sim_fext_power2 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power2/y_sim_fext.mat'),'y_sim_fext');
covTun.y_sim_fext_power3 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power3/y_sim_fext.mat'),'y_sim_fext');
covTun.y_sim_fext_power4 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power4/y_sim_fext.mat'),'y_sim_fext');

% Load data
covTun.data_power3 = load(fullfile(bucket.pathToCovarianceTuningData,'processed_SOTtask2_power3/data.mat'),'data');

% Define new legend colors
covTun.meas_col   = [0.466666666666667 0.674509803921569 0.188235294117647];
covTun.power1_col = [1 0 1];
covTun.power2_col = [1 0 0];
covTun.power3_col = [0 0 1];
covTun.power4_col = [0 0 0];

%% Measurements
covTun.total_variables_meas = [];
% Filling with the linear acceleration
for linAccIdx = 1  : nrOfLinAccelerometer
    covTun.total_variables_meas = [covTun.total_variables_meas; covTun.data_power3.data(blockIdx).data(linAccIdx).meas];
end
% Filling with the 6D wrenches
tmp.fextIndex = []; % Define range in data (only for block 1) for forces
for fextInDataIdx = 1 : length(data(1).data)
    if data(1).data(fextInDataIdx).type == 1002
        tmp.fextIndex = [tmp.fextIndex; fextInDataIdx];
        continue;
    end
end
for vectOrderIdx = 1 : length(dVectorOrder)
    for dataFextIdx = tmp.fextIndex(1) : tmp.fextIndex(end)
        if strcmp(covTun.data_power3.data(blockIdx).data(dataFextIdx).id,dVectorOrder{vectOrderIdx})
            covTun.total_variables_meas = [covTun.total_variables_meas; covTun.data_power3.data(blockIdx).data(dataFextIdx).meas];
            break;
        end
    end
end

% Norm
covTun.len = length(covTun.total_variables_meas);
for lenIdx = 1 : covTun.len
    covTun.totalnorm_meas(1,lenIdx) = norm(covTun.total_variables_meas(:,lenIdx));
end

%% Estimations
covTun.total_variables_estim_power1 = [];
covTun.total_variables_estim_power2 = [];
covTun.total_variables_estim_power3 = [];
covTun.total_variables_estim_power4 = [];
% filling with the linear acceleration
for linAccIdx = 1  : nrOfLinAccelerometer
    covTun.total_variables_estim_power1 = [covTun.total_variables_estim_power1; covTun.y_sim_linAcc_power1.y_sim_linAcc(blockIdx).meas{linAccIdx,1}];
    covTun.total_variables_estim_power2 = [covTun.total_variables_estim_power2; covTun.y_sim_linAcc_power2.y_sim_linAcc(blockIdx).meas{linAccIdx,1}];
    covTun.total_variables_estim_power3 = [covTun.total_variables_estim_power3; covTun.y_sim_linAcc_power3.y_sim_linAcc(blockIdx).meas{linAccIdx,1}];
    covTun.total_variables_estim_power4 = [covTun.total_variables_estim_power4; covTun.y_sim_linAcc_power4.y_sim_linAcc(blockIdx).meas{linAccIdx,1}];
end
% filling with the 6D wrenches
for vectOrderIdx = 1 : length(dVectorOrder)
    covTun.total_variables_estim_power1 = [covTun.total_variables_estim_power1; covTun.y_sim_fext_power1.y_sim_fext.meas{vectOrderIdx,1}];
    covTun.total_variables_estim_power2 = [covTun.total_variables_estim_power2; covTun.y_sim_fext_power2.y_sim_fext.meas{vectOrderIdx,1}];
    covTun.total_variables_estim_power3 = [covTun.total_variables_estim_power3; covTun.y_sim_fext_power3.y_sim_fext.meas{vectOrderIdx,1}];
    covTun.total_variables_estim_power4 = [covTun.total_variables_estim_power4; covTun.y_sim_fext_power4.y_sim_fext.meas{vectOrderIdx,1}];
end

% ------------------------ Difference -------------------------------
covTun.total_variables_power1_diff = (covTun.total_variables_meas - covTun.total_variables_estim_power1);
covTun.total_variables_power2_diff = (covTun.total_variables_meas - covTun.total_variables_estim_power2);
covTun.total_variables_power3_diff = (covTun.total_variables_meas - covTun.total_variables_estim_power3);
covTun.total_variables_power4_diff = (covTun.total_variables_meas - covTun.total_variables_estim_power4);

% ------------------------ Absolute error ---------------------------
% ------------------------ |meas - estim| ---------------------------
for lenIdx = 1 : covTun.len
    covTun.absErr_power1(1,lenIdx) = norm(covTun.total_variables_power1_diff(:,lenIdx));
    covTun.absErr_power2(1,lenIdx) = norm(covTun.total_variables_power2_diff(:,lenIdx));
    covTun.absErr_power3(1,lenIdx) = norm(covTun.total_variables_power3_diff(:,lenIdx));
    covTun.absErr_power4(1,lenIdx) = norm(covTun.total_variables_power4_diff(:,lenIdx));
end

% ------------------------ Relative error ---------------------------
% --------------------- |meas - estim|/|meas| -----------------------
for lenIdx = 1 : covTun.len
    covTun.relErr_power1(1,lenIdx) = (covTun.absErr_power1(:,lenIdx)/covTun.totalnorm_meas(1,lenIdx));
    covTun.relErr_power2(1,lenIdx) = (covTun.absErr_power2(:,lenIdx)/covTun.totalnorm_meas(1,lenIdx));
    covTun.relErr_power3(1,lenIdx) = (covTun.absErr_power3(:,lenIdx)/covTun.totalnorm_meas(1,lenIdx));
    covTun.relErr_power4(1,lenIdx) = (covTun.absErr_power4(:,lenIdx)/covTun.totalnorm_meas(1,lenIdx));
end
% Percentage definition
covTun.mean = [mean(covTun.relErr_power1), mean(covTun.relErr_power2), mean(covTun.relErr_power3), mean(covTun.relErr_power4)];
covarianceTuning.relError_min = min(covTun.mean);
covarianceTuning.relError_percentage = round(covarianceTuning.relError_min * 100,1);
for i = 1 : length(covTun.mean)
    if covarianceTuning.relError_min == covTun.mean(i)
        covarianceTuning.chosenSelectedValue = i;
    end
end
% Plot
if covTun.opts.plot
    for blockIdx = blockID
        fig = figure('Name', strcat('Relative error - MEAS vs. ESTIM - Block ',num2str(blockIdx))','NumberTitle','off');
        axes1 = axes('Parent',fig,'FontSize',16);
        box(axes1,'on');
        hold(axes1,'on');
        
        plot_power1 = plot(covTun.relErr_power1,'color',covTun.power1_col,'lineWidth',4);
        hold on;
        plot_power2 = plot(covTun.relErr_power2,'color',covTun.power2_col,'lineWidth',4);
        hold on;
        plot_power3 = plot(covTun.relErr_power3,'color',covTun.power3_col,'lineWidth',4);
        hold on;
        plot_power4 = plot(covTun.relErr_power4,'color',covTun.power4_col,'lineWidth',4);
        grid on;
        title(sprintf('Relative error, Block %d',blockIdx),'FontSize',20);
        ylabel('$\epsilon_{rel}$','Interpreter','latex');
        xlabel('samples');
        leg = legend([plot_power1,plot_power2,plot_power3,plot_power4],{'estim n=1','estim n=2','estim n=3','estim n=4'});
        set(leg,'Interpreter','latex', ...
            'Orientation','vertical');
        set(leg,'FontSize',30);
    end
end
% Save
save(fullfile(bucket.pathToProcessedData,'covarianceTuning.mat'),'covarianceTuning');
