
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Create the vector for the choice of the trustfull power n
tmp.trustfullPower_NE = [];
tmp.trustfullPower_WE = [];
for subjIdx = 1 : nrOfSubject
    tmp.trustfullPower_NE = [tmp.trustfullPower_NE, intraSubj(subjIdx).NE_errRel.covarianceTuning.chosenSelectedValue];
    tmp.trustfullPower_WE = [tmp.trustfullPower_WE, intraSubj(subjIdx).WE_errRel.covarianceTuning.chosenSelectedValue];
end

% Collect the percentage for the relative error |meas - estim|/|meas|
tmp.relErrPercentage_NE = [];
tmp.relErrPercentage_WE = [];
for subjIdx = 1 : nrOfSubject
    tmp.relErrPercentage_NE = [tmp.relErrPercentage_NE, intraSubj(subjIdx).NE_errRel.covarianceTuning.relError_percentage];
    tmp.relErrPercentage_WE = [tmp.relErrPercentage_WE, intraSubj(subjIdx).WE_errRel.covarianceTuning.relError_percentage];
end
relErrPercentage_NE_mean = mean(tmp.relErrPercentage_NE);
relErrPercentage_WE_mean = mean(tmp.relErrPercentage_WE);

%% Check if NaN in loaded raw data
for subjIdx = 1 : nrOfSubject
    for blockIdx = 1 : block.nrOfBlocks
        for i = 1 : length(selectedJoints.selectedJoints)
            % NE
            if ~isempty(find(isnan(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(i,:)) == 1))
                nanVal = find(isnan(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(i,:)) == 1);
                intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(i,nanVal) = ...
                    (intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(i,nanVal-1)+ ...
                    intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(i,nanVal+1))/2;
            end
            % WE
            if ~isempty(find(isnan(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(i,:)) == 1))
                nanVal = find(isnan(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(i,:)) == 1);
                intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(i,nanVal) = ...
                    (intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(i,nanVal-1)+ ...
                    intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(i,nanVal+1))/2;
            end
        end
    end
end

%% ========================================================================
%%                         INTRA-SUBJECT COMPUTATIONS
%% ========================================================================
% -------- Intra-subject overall torque norm
for subjIdx = 1 : nrOfSubject
    for blockIdx = 1 : block.nrOfBlocks
        intraSubj(subjIdx).torqueNormNE(blockIdx).block = block.labels(blockIdx);
        intraSubj(subjIdx).torqueNormWE(blockIdx).block = block.labels(blockIdx);
        lenNE = length(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values);
        lenWE = length(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values);
        for i = 1 : lenNE
            intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm(1,i) = ...
                norm(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(:,i));
        end
        for i = 1 : lenWE
            intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm(1,i) = ...
                norm(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(:,i));
        end
    end
end
% Normalization
for subjIdx = 1 : nrOfSubject
    for blockIdx = 1 : block.nrOfBlocks
        % ---- normalized norm NE
        intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm_normalized = ...
            (intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm - ...
            min(intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm))/ ...
            (max(intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm) - ...
            min(intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm));
        % ---- normalized norm WE
        intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm_normalized = ...
            (intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm - ...
            min(intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm))/ ...
            (max(intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm) - ...
            min(intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm));
    end
end

% -------- Intra-subject overall torque MEAN
for subjIdx = 1 : nrOfSubject
    for blockIdx = 1 : block.nrOfBlocks
        lenNE = length(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values);
        lenWE = length(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values);
        for i = 1 : lenNE
            intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean(1,i) = ...
                mean(intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(:,i));
        end
        for i = 1 : lenWE
            intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean(1,i) = ...
                mean(intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(:,i));
        end
    end
end
% Normalization
for subjIdx = 1 : nrOfSubject
    for blockIdx = 1 : block.nrOfBlocks
        % ---- normalized mean NE
        intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean_normalized = ...
            (intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean - ...
            min(intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean))/ ...
            (max(intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean) - ...
            min(intraSubj(subjIdx).torqueMeanNE(blockIdx).torqueMean));
        % ---- normalized mean WE
        intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean_normalized = ...
            (intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean - ...
            min(intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean))/ ...
            (max(intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean) - ...
            min(intraSubj(subjIdx).torqueMeanWE(blockIdx).torqueMean));
    end
end

%% ========================================================================
%%                         WHOLE-BODY NORM
%% ========================================================================
% -------- Inter-subject overall torque norm
% Uniform the range of signals per block
for blockIdx = 1 : block.nrOfBlocks
    interSubj(blockIdx).block = block.labels(blockIdx);
    tmp.interSubj(blockIdx).rangeNE = [];
    tmp.interSubj(blockIdx).rangeWE = [];
    for subjIdx = 1 : nrOfSubject
        tmp.interSubj(blockIdx).rangeNE = [tmp.interSubj(blockIdx).rangeNE; ...
            size(intraSubj(subjIdx).torqueNormNE(blockIdx).torqueNorm,2)];
        tmp.interSubj(blockIdx).rangeWE = [tmp.interSubj(blockIdx).rangeWE; ...
            size(intraSubj(subjIdx).torqueNormWE(blockIdx).torqueNorm,2)];
    end
    interSubj(blockIdx).lenghtOfIntersubjNormNE = min(tmp.interSubj(blockIdx).rangeNE);
    interSubj(blockIdx).lenghtOfIntersubjNormWE = min(tmp.interSubj(blockIdx).rangeWE);
end

% Create vector for all the subjects divided in blocks
for blockIdx = 1 : block.nrOfBlocks
    tmp.interSubj(blockIdx).overallTorqueListNE = [];
    tmp.interSubj(blockIdx).overallTorqueListWE = [];
    for subjIdx = 1 : nrOfSubject
        tmp.interSubj(blockIdx).overallTorqueListNE  = [tmp.interSubj(blockIdx).overallTorqueListNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(:, 1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.interSubj(blockIdx).overallTorqueListWE  = [tmp.interSubj(blockIdx).overallTorqueListWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(:, 1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
end

% -------- Inter-subject overall torque norm
for blockIdx = 1 : block.nrOfBlocks
    lenNE = interSubj(blockIdx).lenghtOfIntersubjNormNE;
    lenWE = interSubj(blockIdx).lenghtOfIntersubjNormWE;
    for i = 1 : lenNE
        interSubj(blockIdx).torqueNormNE(1,i) = norm(tmp.interSubj(blockIdx).overallTorqueListNE(:,i));
    end
    for i = 1 : lenWE
        interSubj(blockIdx).torqueNormWE(1,i) = norm(tmp.interSubj(blockIdx).overallTorqueListWE(:,i));
    end
end

%% ========================================================================
%%                           STATISTICS
%% ========================================================================
stats_tauNorm_wb_anova2;

%% ========================================================================
%%                         WHOLE-BODY MEAN
%% ========================================================================
% -------- Inter-subject overall torque mean
meanMeanTorques = zeros(block.nrOfBlocks,2);
for blockIdx = 1 : block.nrOfBlocks
    % NE
    interSubj(blockIdx).torqueMeanNE = mean(tmp.interSubj(blockIdx).overallTorqueListNE);
    meanMeanTorques(blockIdx,1) = mean(interSubj(blockIdx).torqueMeanNE);
    % WE
    interSubj(blockIdx).torqueMeanWE = mean(tmp.interSubj(blockIdx).overallTorqueListWE);
    meanMeanTorques(blockIdx,2) = mean(interSubj(blockIdx).torqueMeanWE);
end

%% Plot normalized mean normalized torque
fig = figure('Name', 'Intersubject overall tau normalized mean','NumberTitle','off');
% fig = figure('Name', 'Intersubje overall tau mean','NumberTitle','off');
axes1 = axes('Parent',fig,'FontSize',16);
box(axes1,'on');
hold(axes1,'on');
grid on;
for blockIdx = 1 : block.nrOfBlocks
    subplot (5,1,blockIdx)
    % NE
    plot1 = plot(abs(interSubj(blockIdx).torqueMeanNE),'color',orangeAnDycolor,'lineWidth',4);
    axis tight;
    ax = gca;
    ax.FontSize = 27;
    hold on
    % WE
    plot2 = plot(abs(interSubj(blockIdx).torqueMeanWE),'color',greenAnDycolor,'lineWidth',4);
    hold on
    title(sprintf('Block %s', num2str(blockIdx)),'FontSize',23);
    ylabel('$|\bar\tau^{wb}|$ [Nm]','HorizontalAlignment','center',...
        'FontSize',35,'interpreter','latex');
    if blockIdx == 5
        xlabel('samples','FontSize',30);
    end
    grid on;
    %legend
    leg = legend([plot1,plot2],{'NE','WE'},'Location','northeast');
    set(leg,'Interpreter','latex','FontSize',33);
    % axis tight
    %     ylim([-1.8, 0.7]);
    ylim([-0.3, 2]);
    yticks([0 1])
end
% align_Ylabels(gcf)
% subplotsqueeze(gcf, 1.12);
tightfig();
% save
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_overallTauNormalizedMean'),fig,600);
end

%% Computation (|barBarTau_NE| - |barBarTau_WE|)/|barBarTau_NE|
wholeBodyExo.values = zeros(5,3);
for blockIdx = 1 : block.nrOfBlocks
    wholeBodyExo.values(blockIdx,1) = mean(interSubj(blockIdx).torqueMeanNE);
    wholeBodyExo.values(blockIdx,2) = mean(interSubj(blockIdx).torqueMeanWE);
    wholeBodyExo.values(blockIdx,3) = (abs(wholeBodyExo.values(blockIdx,1)) - ...
        abs(wholeBodyExo.values(blockIdx,2)))/abs(wholeBodyExo.values(blockIdx,1));
end

%% ========================================================================
%%                              AREAS MEAN
%% ========================================================================
% Torso
tmp.torso_range    = [1:14];
interSubjectAnalysis_torso;
% Arms
tmp.rightArm_range = [15:22];
tmp.leftArm_range  = [23:30];
interSubjectAnalysis_arms;
% Legs
tmp.rightLeg_range = [31:38]; % no 39, rightBallFoot joint
tmp.leftLeg_range  = [40:47]; % no 48, leftBallFoot joint
interSubjectAnalysis_legs;
