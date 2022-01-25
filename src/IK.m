
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [state, selectedJoints] = IK(filenameOsimModel, filenameTrc, setupFile, Sg, motFilename)
% IK computes the Inverse Kinematics by using the OpenSim API.  
% After computing joint angles (q), it uses  Savitzi-Golay for
% obtaining joint velocities (dq) and joint accelerations (ddq).
% Outputs: state in radians.

%% Use OpenSim InverseKinematicTool
import org.opensim.modeling.*  % import OpenSim APIs to be used in MATLAB
osimModel = Model(filenameOsimModel);
osimModel.initSystem();
% generic experiment/model info are loaded from the file.xml:
ikTool = InverseKinematicsTool(setupFile);
% subject info are set manually:
ikTool.setModel(osimModel);
ikTool.setMarkerDataFileName(filenameTrc);
outputMotionFilename = motFilename;
ikTool.setOutputMotionFileName(outputMotionFilename);
if ~exist(outputMotionFilename, 'file')
    ikTool.run();
end

%% Extract data from motion file.mot
motionData = importdata(outputMotionFilename);

%% Create a joint name vector ordered as in OSIM
selectedJoints = cell(size(motionData.colheaders,2)-7,1);
for i = 8 : size(motionData.colheaders,2)
    selectedJoints{i-7} = motionData.colheaders{i};
end
% 8 is the column from which starting to select joints. Column 1 (time) and
% columns from 2 to 7 (ground joints) will be discarded. We decide here
% what will be the order of joints because this order will be passed to the
% modelLoader in the main.

%% Savitzi-Golay computation
state.q  = zeros(size(motionData.data,2)-7, size(motionData.data,1));
state.dq = zeros(size(state.q));

stateTmp.q     = motionData.data(:, 8:end)';  % in deg
[state.q,~,~]  = SgolayFilterAndDifferentiation(Sg.polinomialOrder,Sg.window,stateTmp.q,Sg.samplingTime); % in deg
[~,state.dq,~] = SgolayFilterAndDifferentiation(Sg.polinomialOrder,Sg.window,state.q,Sg.samplingTime); % in deg

% Transformation in radians
state.q  = state.q * pi/180;    % in rad
state.dq = state.dq * pi/180;   % in rad
end
