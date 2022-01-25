
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% ================== RIGHT LEG ============================================
%% Table mean per area
%% hip
% ---rotx
tmp.range = 31;
singleJointsTau.rightLeg.tableRightLegMean.hip_rotx  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 32;
singleJointsTau.rightLeg.tableRightLegMean.hip_roty  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 33;
singleJointsTau.rightLeg.tableRightLegMean.hip_rotz  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(exoCheckIdx,2));
end
%% knee
% ---roty
tmp.range = 34;
singleJointsTau.rightLeg.tableRightLegMean.knee_roty  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.knee_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.knee_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 35;
singleJointsTau.rightLeg.tableRightLegMean.knee_rotz  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(exoCheckIdx,2));
end
%% ankle
% ---rotx
tmp.range = 36;
singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 37;
singleJointsTau.rightLeg.tableRightLegMean.ankle_roty = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 38;
singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanNE = mean(abs(tmp.cluster(blockIdx).clusterJointsNE));
    singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanWE = mean(abs(tmp.cluster(blockIdx).clusterJointsWE));
    % mean of mean
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(blockIdx,1) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanNE);
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(blockIdx,2) = mean(singleJointsTau.rightLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(exoCheckIdx,2));
end

%% Bar plot single joints
fig = figure();
axes1 = axes('Parent',fig, ...
    'YGrid','on',...
    'XTickLabel',{ ...
    'rot_x',...
    'rot_y',...
    'rot_z', ...
    'rot_y', ...
    'rot_z',...
    'rot_x',...
    'rot_y',...
    'rot_z'},...
    'XTick',[1.9 3.9 5.9 7.9 9.9 11.9 13.9 15.9],...
    'FontSize',20);
box(axes1,'off');
hold(axes1,'on');
% xtickangle(45);
grid on;

bar1 = bar([1.3, 3.3, 5.3, 7.3, 9.3, 11.3, 13.3, 15.3], ...
    [singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(1,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(1,3)], ...
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
    [singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(2,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(2,3)], ...
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
    [singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(3,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(3,3)], ...
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
    [singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(4,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(4,3)], ...
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
    [singleJointsTau.rightLeg.tableRightLegMean.hip_rotx(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_roty(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.hip_rotz(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_roty(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.knee_rotz(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotx(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_roty(5,3) ...
    singleJointsTau.rightLeg.tableRightLegMean.ankle_rotz(5,3)], ...
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

title('Right leg','FontSize',20);
ylabel(' $|\bar{\bar{\tau}}^{rl}_{NE}|-|\bar{\bar{\tau}}^{rl}_{WE}|$ [Nm]','HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',30,...
    'Interpreter','latex');
ylim([-12, 11.5]);
set(axes1, 'XLimSpec', 'Tight');

%% Patch
yl = ylim;
xl = xlim;
% hip
xl_hip = bar5.XData(3) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl(1), xl_hip, xl_hip, xl(1), xl(1)];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch1 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jHip';
text(xl_hip/2,-11,txt,'FontSize',25);
% knee
xl_knee = bar5.XData(5) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_hip, xl_knee, xl_knee, xl_hip, xl_hip];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch2 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jKnee';
text(xl_hip+(xl_knee-xl_hip)/3,-11,txt,'FontSize',25);
% ankle
xl_ankle = bar5.XData(8) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_knee, xl_ankle, xl_ankle, xl_knee, xl_knee];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch4 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jAnkle';
text(xl_knee+(xl_ankle-xl_knee)/3,-11,txt,'FontSize',25);

%% Save
tightfig();
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_rLegTauMean_bar'),fig,600);
end

%% ================== LEFT LEG ============================================
%% Table mean per area
%% hip
% ---rotx
tmp.range = 40;
singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 41;
singleJointsTau.leftLeg.tableLeftLegMean.hip_roty  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 42;
singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).hip_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(exoCheckIdx,2));
end
%% knee
% ---roty
tmp.range = 43;
singleJointsTau.leftLeg.tableLeftLegMean.knee_roty  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 44;
singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz  = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).knee_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(exoCheckIdx,2));
end
%% ankle
% ---rotx
tmp.range = 45;
singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotx.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(exoCheckIdx,2));
end
% ---roty
tmp.range = 46;
singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_roty.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(exoCheckIdx,2));
end
% ---rotz
tmp.range = 47;
singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz = zeros(block.nrOfBlocks,3);
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
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanNE = mean(tmp.cluster(blockIdx).clusterJointsNE);
    singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanWE = mean(tmp.cluster(blockIdx).clusterJointsWE);
    % mean of mean
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(blockIdx,1) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanNE);
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(blockIdx,2) = mean(singleJointsTau.leftLeg.jointsPerArea(blockIdx).ankle_rotz.torqueMeanWE);
end
% Chech overall effort status due to exo presence
for exoCheckIdx = 1 : block.nrOfBlocks
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(exoCheckIdx,3) = ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(exoCheckIdx,1)) - ...
        abs(singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(exoCheckIdx,2));
end

%% Bar plot single joints
fig = figure();
axes1 = axes('Parent',fig, ...
    'YGrid','on',...
    'XTickLabel',{ ...
    'rot_x',...
    'rot_y',...
    'rot_z', ...
    'rot_y', ...
    'rot_z',...
    'rot_x',...
    'rot_y',...
    'rot_z'},...
    'XTick',[1.9 3.9 5.9 7.9 9.9 11.9 13.9 15.9],...
    'FontSize',20);
box(axes1,'off');
hold(axes1,'on');
% xtickangle(45);
grid on;

bar1 = bar([1.3, 3.3, 5.3, 7.3, 9.3, 11.3, 13.3, 15.3], ...
    [singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(1,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(1,3)], ...
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
    [singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(2,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(2,3)], ...
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
    [singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(3,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(3,3)], ...
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
    [singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(4,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(4,3)], ...
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
bar5 = bar([2.5, 4.5, 6.5, 8.5, 10.5, 12.5, 14.5, 16.5], ...
    [singleJointsTau.leftLeg.tableLeftLegMean.hip_rotx(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_roty(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.hip_rotz(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_roty(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.knee_rotz(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotx(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_roty(5,3) ...
    singleJointsTau.leftLeg.tableLeftLegMean.ankle_rotz(5,3)], ...
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

title('Left leg','FontSize',20);
ylabel(' $|\bar{\bar{\tau}}^{ll}_{NE}|-|\bar{\bar{\tau}}^{ll}_{WE}|$ [Nm]','HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',30,...
    'Interpreter','latex');
ylim([-12, 11.5]);
set(axes1, 'XLimSpec', 'Tight');

%% Patch
yl = ylim;
xl = xlim;
% hip
xl_hip = bar5.XData(3) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl(1), xl_hip, xl_hip, xl(1), xl(1)];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch1 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jHip';
text(xl_hip/2,-11,txt,'FontSize',25);
% knee
xl_knee = bar5.XData(5) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_hip, xl_knee, xl_knee, xl_hip, xl_hip];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch2 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jKnee';
text(xl_hip+(xl_knee-xl_hip)/3,-11,txt,'FontSize',25);
% ankle
xl_ankle = bar5.XData(8) + (bar1.XData(2) - bar5.XData(1))/2;
xBox = [xl_knee, xl_ankle, xl_ankle, xl_knee, xl_knee];
yBox = [yl(1), yl(1), yl(2), yl(2), yl(1)];
patch4 = patch(xBox, yBox, 'black', 'FaceColor', 'white', 'FaceAlpha', 0.05);
txt = 'jAnkle';
text(xl_knee+(xl_ankle-xl_knee)/3,-11,txt,'FontSize',25);
%% Save
tightfig();
if saveON
    save2pdf(fullfile(bucket.pathToPlots,'intersubj_lLegTauMean_bar'),fig,600);
end
