
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% ================== RIGHT ARM ===========================================
%% Table mean per area
%% C7shoulder
% ---rotx
tmp.range = 15;
singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(exoCheckIdx,2));
end
%% shoulder
% ---rotx
tmp.range = 16;
singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 17;
singleJointsTau.rightArm.tableRightArmMean.shoulder_roty  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 18;
singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(exoCheckIdx,2));
end
%% elbow
% ---roty
tmp.range = 19;
singleJointsTau.rightArm.tableRightArmMean.elbow_roty  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.elbow_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.elbow_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 20;
singleJointsTau.rightArm.tableRightArmMean.elbow_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(exoCheckIdx,2));
end
%% wrist
% ---rotx
tmp.range = 21;
singleJointsTau.rightArm.tableRightArmMean.wrist_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(exoCheckIdx,2));
end
% ---rotz
tmp.range = 22;
singleJointsTau.rightArm.tableRightArmMean.wrist_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(blockIdx,1) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanNE);
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(blockIdx,2) = mean(singleJointsTau.rightArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(exoCheckIdx,2));
end

%% Bar plot single joints
fig = figure();
axes1 = axes('Parent',fig, ...
    'YGrid','on',...
    'XTickLabel',{ ...
    'rot_x', ...
    'rot_x',...
    'rot_y',...
    'rot_z', ...
    'rot_y', ...
    'rot_z',...
    'rot_x',...
    'rot_z'},...
    'XTick',[1.9 3.9 5.9 7.9 9.9 11.9 13.9 15.9],...
    'FontSize',20);
box(axes1,'off');
hold(axes1,'on');
grid on;

bar1 = bar([1.3, 3.3, 5.3, 7.3, 9.3, 11.3, 13.3, 15.3], ...
    [singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(1,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(1,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar1.YData(barIdx) < 0
        bar1.FaceColor = 'flat';
        bar1.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar1.XData(barIdx),bar1.YData(barIdx),'1', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar1.XData(barIdx),bar1.YData(barIdx),'1', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar2 = bar([1.6, 3.6, 5.6, 7.6, 9.6, 11.6, 13.6, 15.6], ...
    [singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(2,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(2,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar2.YData(barIdx) < 0
        bar2.FaceColor = 'flat';
        bar2.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar2.XData(barIdx),bar2.YData(barIdx),'2', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar2.XData(barIdx),bar2.YData(barIdx),'2', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar3 = bar([1.9, 3.9, 5.9, 7.9, 9.9, 11.9, 13.9, 15.9], ...
    [singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(3,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(3,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar3.YData(barIdx) < 0
        bar3.FaceColor = 'flat';
        bar3.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar3.XData(barIdx),bar3.YData(barIdx),'3', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar3.XData(barIdx),bar3.YData(barIdx),'3', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar4 = bar([2.2, 4.2, 6.2, 8.2, 10.2, 12.2, 14.2, 16.2], ...
    [singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(4,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(4,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar4.YData(barIdx) < 0
        bar4.FaceColor = 'flat';
        bar4.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar4.XData(barIdx),bar4.YData(barIdx),'4', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar4.XData(barIdx),bar4.YData(barIdx),'4', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar5 = bar([2.5, 4.5, 6.5, 8.5, 10.5, 12.5, 14.5, 16.5], ...
    [singleJointsTau.rightArm.tableRightArmMean.C7shoulder_rotx(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotx(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_roty(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.shoulder_rotz(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_roty(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.elbow_rotz(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotx(5,3) ...
    singleJointsTau.rightArm.tableRightArmMean.wrist_rotz(5,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar5.YData(barIdx) < 0
        bar5.FaceColor = 'flat';
        bar5.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar5.XData(barIdx),bar5.YData(barIdx),'5', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar5.XData(barIdx),bar5.YData(barIdx),'5', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end

title('Right arm','FontSize',20);
ylabel(' $|\bar{\bar{\tau}}^{ra}_{NE}|-|\bar{\bar{\tau}}^{ra}_{WE}|$ [Nm]','HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',30,...
    'Interpreter','latex');
ylim([-12, 11.5]);
set(axes1, 'XLimSpec', 'Tight');

%% Patch
yl = ylim;
xl = xlim;
% C7shoulder
xl_C7shoulder = bar5.XData(1) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl(1), xl_C7shoulder, xl_C7shoulder, xl(1), xl(1)];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch1 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jC7sho';
text(xl_C7shoulder/2,-11,txt,'FontSize',25);
% shoulder
xl_shoulder = bar5.XData(4) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_C7shoulder, xl_shoulder, xl_shoulder, xl_C7shoulder, xl_C7shoulder];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch2 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jShoulder';
text(xl_C7shoulder+(xl_shoulder-xl_C7shoulder)/3,-11,txt,'FontSize',25);
% elbow
xl_elbow = bar5.XData(6) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_shoulder, xl_elbow, xl_elbow, xl_shoulder, xl_shoulder];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch3 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jElbow';
text(xl_shoulder+(xl_elbow-xl_shoulder)/3,-11,txt,'FontSize',25);
% wrist
xl_wrist = bar5.XData(8) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_elbow, xl_wrist, xl_wrist, xl_elbow, xl_elbow];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch4 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jWrist';
text(xl_elbow+(xl_wrist-xl_elbow)/3,-11,txt,'FontSize',25);

%% Save
tightfig();
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_rArmTauMean_bar'),fig,600);
end

%% ================== LEFT ARM ============================================
%% Table mean per area
%% C7shoulder
% ---rotx
tmp.range = 23;
singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).C7shoulder_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(exoCheckIdx,2));
end
%% shoulder
% ---rotx
tmp.range = 24;
singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 25;
singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 26;
singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).shoulder_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(exoCheckIdx,2));
end
%% elbow
% ---roty
tmp.range = 27;
singleJointsTau.leftArm.tableLeftArmMean.elbow_roty  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 28;
singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).elbow_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(exoCheckIdx,2));
end
%% wrist
% ---rotx
tmp.range = 29;
singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(exoCheckIdx,2));
end
% ---rotz
tmp.range = 30;
singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz  = zeros(block.nrOfBlocks,3);
for blockIdx = 1 : block.nrOfBlocks
    tmp.cluster(blockIdx).clusterJointsNE = [];
    tmp.cluster(blockIdx).clusterJointsWE = [];
    % Create vector for all the subjects divided in blocks
    for subjIdx = 1 : nrOfSubject
        tmp.cluster(blockIdx).clusterJointsNE = [tmp.cluster(blockIdx).clusterJointsNE; ...
            intraSubj(subjIdx).NE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormNE)];
        tmp.cluster(blockIdx).clusterJointsWE = [tmp.cluster(blockIdx).clusterJointsWE; ...
            intraSubj(subjIdx).WE.estimatedVariables.tau(blockIdx).values(tmp.range,1:interSubj(blockIdx).lenghtOfIntersubjNormWE)];
    end
    % mean vector
    singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(blockIdx,1) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanNE);
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(blockIdx,2) = mean(singleJointsTau.leftArm.jointsPerArea(blockIdx).wrist_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(exoCheckIdx,2));
end

%% Bar plot single joints
fig = figure();
axes1 = axes('Parent',fig, ...
    'YGrid','on',...
    'XTickLabel',{ ...
    'rot_x', ...
    'rot_x',...
    'rot_y',...
    'rot_z', ...
    'rot_y', ...
    'rot_z',...
    'rot_x',...
    'rot_z'},...
    'XTick',[1.9 3.9 5.9 7.9 9.9 11.9 13.9 15.9],...
    'FontSize',20);
box(axes1,'off');
hold(axes1,'on');
grid on;

bar1 = bar([1.3, 3.3, 5.3, 7.3, 9.3, 11.3, 13.3, 15.3], ...
    [singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(1,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(1,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar1.YData(barIdx) < 0
        bar1.FaceColor = 'flat';
        bar1.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar1.XData(barIdx),bar1.YData(barIdx),'1', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar1.XData(barIdx),bar1.YData(barIdx),'1', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar2 = bar([1.6, 3.6, 5.6, 7.6, 9.6, 11.6, 13.6, 15.6], ...
    [singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(2,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(2,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar2.YData(barIdx) < 0
        bar2.FaceColor = 'flat';
        bar2.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar2.XData(barIdx),bar2.YData(barIdx),'2', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar2.XData(barIdx),bar2.YData(barIdx),'2', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar3 = bar([1.9, 3.9, 5.9, 7.9, 9.9, 11.9, 13.9, 15.9], ...
    [singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(3,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(3,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar3.YData(barIdx) < 0
        bar3.FaceColor = 'flat';
        bar3.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar3.XData(barIdx),bar3.YData(barIdx),'3', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar3.XData(barIdx),bar3.YData(barIdx),'3', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar4 = bar([2.2, 4.2, 6.2, 8.2, 10.2, 12.2, 14.2, 16.2], ...
    [singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(4,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(4,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar4.YData(barIdx) < 0
        bar4.FaceColor = 'flat';
        bar4.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar4.XData(barIdx),bar4.YData(barIdx),'4', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar4.XData(barIdx),bar4.YData(barIdx),'4', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end
hold on;
bar5 = bar([2.5, 4.5, 6.5, 8.5, 10.5, 12.5, 14.5, 16.5], ...
    [singleJointsTau.leftArm.tableLeftArmMean.C7shoulder_rotx(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotx(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_roty(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.shoulder_rotz(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_roty(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.elbow_rotz(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotx(5,3) ...
    singleJointsTau.leftArm.tableLeftArmMean.wrist_rotz(5,3)], ...
    0.15,'FaceColor',benefit_color_green);
for barIdx = 1 : 8
    if bar5.YData(barIdx) < 0
        bar5.FaceColor = 'flat';
        bar5.CData(barIdx,:) = noBenefit_color_red;
        text_custom = text(bar5.XData(barIdx),bar5.YData(barIdx),'5', ...
            'HorizontalAlignment','center','VerticalAlignment','top');
        set(text_custom,'FontSize',14);
    else
        text_custom = text(bar5.XData(barIdx),bar5.YData(barIdx),'5', ...
            'HorizontalAlignment','center','VerticalAlignment','bottom');
        set(text_custom,'FontSize',14);
    end
end

title('Left arm','FontSize',20);
ylabel(' $|\bar{\bar{\tau}}^{la}_{NE}|-|\bar{\bar{\tau}}^{la}_{WE}|$ [Nm]','HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',30,...
    'Interpreter','latex');
ylim([-12, 11.5]);
set(axes1, 'XLimSpec', 'Tight');

%% Patch
yl = ylim;
xl = xlim;
% C7shoulder
xl_C7shoulder = bar5.XData(1) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl(1), xl_C7shoulder, xl_C7shoulder, xl(1), xl(1)];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch1 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jC7sho';
text(xl_C7shoulder/2,-11,txt,'FontSize',25);
% shoulder
xl_shoulder = bar5.XData(4) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_C7shoulder, xl_shoulder, xl_shoulder, xl_C7shoulder, xl_C7shoulder];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch2 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jShoulder';
text(xl_C7shoulder+(xl_shoulder-xl_C7shoulder)/3,-11,txt,'FontSize',25);
% elbow
xl_elbow = bar5.XData(6) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_shoulder, xl_elbow, xl_elbow, xl_shoulder, xl_shoulder];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch3 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jElbow';
text(xl_shoulder+(xl_elbow-xl_shoulder)/3,-11,txt,'FontSize',25);
% wrist
xl_wrist = bar5.XData(8) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_elbow, xl_wrist, xl_wrist, xl_elbow, xl_elbow];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch4 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jWrist';
text(xl_elbow+(xl_wrist-xl_elbow)/3,-11,txt,'FontSize',25);

%% Save
tightfig();
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_lArmTauMean_bar'),fig,600);
end
