
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Load exo data
load(fullfile(bucket.pathToAnalysis,'intraSubj_EXOdata.mat'));

% Normalization of data
for subjIdx = 1 : length(intraSubj)
    for blockIdx = 1 : block.nrOfBlocks
        % ---- normalized RSF
        exoData(subjIdx).RSF(blockIdx).normalized = ...
            (intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res - ...
            min(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res))/ ...
            (max(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res) - ...
            min(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res));
        % ---- normalized LSF
        exoData(subjIdx).LSF(blockIdx).normalized = ...
            (intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res - ...
            min(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res))/ ...
            (max(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res) - ...
            min(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res));
        % ---- normalized RHF
        exoData(subjIdx).RHF(blockIdx).normalized = ...
            (intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res - ...
            min(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res))/ ...
            (max(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res) - ...
            min(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res));
        % ---- normalized LHF
        exoData(subjIdx).LHF(blockIdx).normalized = ...
            (intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res - ...
            min(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res))/ ...
            (max(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res) - ...
            min(intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res));
    end
end

%% Inter-subject overall mean
% Uniform the range of signals per block
for blockIdx = 1 : block.nrOfBlocks
    interSubj(blockIdx).block = block.labels(blockIdx);
    tmp.interSubj(blockIdx).range = [];
    for subjIdx = 1 : nrOfSubject
        tmp.interSubj(blockIdx).range = [tmp.interSubj(blockIdx).range; ...
            size(intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res,2)];
    end
    interSubj(blockIdx).lenghtOfIntersubjEXOfext = min(tmp.interSubj(blockIdx).range);
end

% Create vectors for all the subjects divided in blocks
for blockIdx = 1 : block.nrOfBlocks
    % RSF
    tmp.interSubj(blockIdx).overallRSFlist = [];
    tmp.interSubj(blockIdx).overallRexoAngles = [];
    for subjIdx = 1 : nrOfSubject
        % FORCES
        tmp.interSubj(blockIdx).overallRSFlist  = [tmp.interSubj(blockIdx).overallRSFlist; ...
            intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
        % ANGLES
        qToCompare_temp = intraSubj(subjIdx).roundedAngles(blockIdx).qToCompare_right_round';
        tmp.interSubj(blockIdx).overallRexoAngles  = [tmp.interSubj(blockIdx).overallRexoAngles; ...
            qToCompare_temp(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
    end
    % LSF
    tmp.interSubj(blockIdx).overallLSFlist = [];
    tmp.interSubj(blockIdx).overallLexoAngles = [];
    for subjIdx = 1 : nrOfSubject
        % FORCES
        tmp.interSubj(blockIdx).overallLSFlist  = [tmp.interSubj(blockIdx).overallLSFlist; ...
            intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_arm_support_res(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
        % ANGLES
        qToCompare_temp = intraSubj(subjIdx).roundedAngles(blockIdx).qToCompare_left_round';
        tmp.interSubj(blockIdx).overallLexoAngles  = [tmp.interSubj(blockIdx).overallLexoAngles; ...
            qToCompare_temp(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
    end
    % RHF
    tmp.interSubj(blockIdx).overallRHFlist = [];
    for subjIdx = 1 : nrOfSubject
        % FORCES
        tmp.interSubj(blockIdx).overallRHFlist  = [tmp.interSubj(blockIdx).overallRHFlist; ...
            intraSubj(subjIdx).rightEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
    end
    % LHF
    tmp.interSubj(blockIdx).overallLHFlist = [];
    for subjIdx = 1 : nrOfSubject
        % FORCES
        tmp.interSubj(blockIdx).overallLHFlist  = [tmp.interSubj(blockIdx).overallLHFlist; ...
            intraSubj(subjIdx).leftEXOforceInFinalShoulderAngles(blockIdx).F_KGkraft_res(:, 1:interSubj(blockIdx).lenghtOfIntersubjEXOfext)];
    end
end

meanMeanTorques = zeros(block.nrOfBlocks,2);
for blockIdx = 1 : block.nrOfBlocks
    % RSF
    if blockIdx == 1
        interSubj(blockIdx).meanRSF = mean(tmp.interSubj(blockIdx).overallRSFlist(:,300:end)); %forces
    else
        interSubj(blockIdx).meanRSF = mean(tmp.interSubj(blockIdx).overallRSFlist(:,2000:end)); %forces
    end
    tmp.meanMeanRSF(blockIdx,1) = mean(interSubj(blockIdx).meanRSF);
    interSubj(blockIdx).meanRexoAngles = mean(tmp.interSubj(blockIdx).overallRexoAngles(:,2000:end)); %angles
    % LSF
    if blockIdx == 1
        interSubj(blockIdx).meanLSF = mean(tmp.interSubj(blockIdx).overallLSFlist(:,300:end)); %forces
    else
        interSubj(blockIdx).meanLSF = mean(tmp.interSubj(blockIdx).overallLSFlist(:,2000:end)); %forces
    end
    tmp.meanMeanLSF(blockIdx,1) = mean(interSubj(blockIdx).meanLSF);
    interSubj(blockIdx).meanLexoAngles = mean(tmp.interSubj(blockIdx).overallLexoAngles(:,2000:end)); %angles
    % RHF
    if blockIdx == 1
        interSubj(blockIdx).meanRHF = mean(tmp.interSubj(blockIdx).overallRHFlist(:,300:end)); %forces
    else
        interSubj(blockIdx).meanRHF = mean(tmp.interSubj(blockIdx).overallRHFlist(:,2000:end)); %forces
    end
    tmp.meanMeanRHF(blockIdx,1) = mean(interSubj(blockIdx).meanRHF);
    % LHF
    if blockIdx == 1
        interSubj(blockIdx).meanLHF = mean(tmp.interSubj(blockIdx).overallLHFlist(:,300:end)); %forces
    else
        interSubj(blockIdx).meanLHF = mean(tmp.interSubj(blockIdx).overallLHFlist(:,2000:end)); %forces
    end
    tmp.meanMeanLHF(blockIdx,1) = mean(interSubj(blockIdx).meanLHF);
end

%% Plot: inter-subject support exo forces per block
fig = figure('Name', 'Intersubject exo forces','NumberTitle','off');
axes1 = axes('Parent',fig,'FontSize',16);
box(axes1,'on');
hold(axes1,'on');
grid on;

titleLabel = {'Left upper arm','Pelvis','Right upper arm'};
leg = cell(5,1);
for subplotIdx = 1 : 3
    
    for blockIdx = 1 : block.nrOfBlocks
        subplot(3,1,subplotIdx)
        % LSF
        if subplotIdx == 1
            plotLSF = plot(interSubj(blockIdx).meanLSF, 'color',color.exoBlocks{blockIdx},'lineWidth',4);
            ax=gca;
            ax.FontSize = 40;
            ylabel('$f_{RSLF}$ [Nm]','HorizontalAlignment','center',...
                'FontSize',60,'interpreter','latex');
            hold on
        end
        % HF
        if subplotIdx == 2
            plotHF = plot((interSubj(blockIdx).meanRHF + interSubj(blockIdx).meanLHF), 'color',color.exoBlocks{blockIdx},'lineWidth',4);
            ax=gca;
            ax.FontSize = 40;
            ylabel('$f_{RHF}$ [Nm]','HorizontalAlignment','center',...
                'FontSize',60,'interpreter','latex');
            hold on
        end
        % RSF
        if subplotIdx == 3
            plotRSF = plot(interSubj(blockIdx).meanRSF, 'color',color.exoBlocks{blockIdx},'lineWidth',4);
            ax=gca;
            ax.FontSize = 40;
            ylabel('$f_{RSRF}$ [Nm]','HorizontalAlignment','center',...
                'FontSize',60,'interpreter','latex');
            
            xlabel('samples','FontSize',45);
            hold on
        end
        title(titleLabel{subplotIdx},'FontSize',40);
        grid on;
        % legend
        leg{blockIdx} = strcat(block.labels{blockIdx});
    end
    legend(leg,'Location','southeast', 'FontSize',40,'Orientation','horizontal')
    axis tight
end
tightfig();
% save
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_blocksMeanExoForces'),fig,600);
end
