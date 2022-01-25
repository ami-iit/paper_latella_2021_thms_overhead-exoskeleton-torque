
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [G_T_base] = computeTransformBaseToGlobalFrame (kinDynComputation, state, baseOrientation, basePosition)
%COMPUTETRANSFORMBASETOGLOBALFRAME computes the iDynTreen transform for the
% base w.r.t. the global suit frame G.

% Initialize state
q  = iDynTree.JointPosDoubleArray(kinDynComputation.model);
dq = iDynTree.JointDOFsDoubleArray(kinDynComputation.model);

% Define parameters
G_T_baseRot = iDynTree.Rotation();
G_T_basePos = iDynTree.Position();

samples = size(state.q ,2);
G_T_base = cell(samples,1);

for i = 1 : samples
    q.fromMatlab(state.q(:,i));
    dq.fromMatlab(state.dq(:,i));
    % rot
    G_R_base = quat2Mat(baseOrientation(:,i));
    G_T_baseRot.fromMatlab(G_R_base);
    % pos
    G_T_basePos.fromMatlab(basePosition(:,i));
    % transf
    G_T_base{i,:}= iDynTree.Transform(G_T_baseRot,G_T_basePos);
end
