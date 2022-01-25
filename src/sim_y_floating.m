
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [y_simulated] = sim_y_floating(berdy, human_state, traversal, G_T_base, baseAngVel, mu_dgiveny, opts)
% SIM_Y_FLOATING compares the measurements in the y vector (i.e., the vector
% of the measurements) with the results of the MAP estimation in mu_dgiveny.
%
% Note: you cannot compare directly the results of the MAP (i.e., mu_dgiveny)
% with the measurements in the y vector! You have to pass through the
% sim_y_floating and only later to compare vectors y and y_simulated.

% Set gravity
gravity = [0 0 -9.81];
grav  = iDynTree.Vector3();
grav.fromMatlab(gravity);

% Set matrices
berdyMatrices     = struct;
berdyMatrices.D   = iDynTree.MatrixDynSize();
berdyMatrices.b_D = iDynTree.VectorDynSize();
berdyMatrices.Y   = iDynTree.MatrixDynSize();
berdyMatrices.b_Y = iDynTree.VectorDynSize();

berdy.resizeAndZeroBerdyMatrices(berdyMatrices.D,...
    berdyMatrices.b_D,...
    berdyMatrices.Y,...
    berdyMatrices.b_Y,...
    opts.stackOfTaskMAP);

q  = iDynTree.JointPosDoubleArray(berdy.model());
dq = iDynTree.JointDOFsDoubleArray(berdy.model());
currentBase = berdy.model().getLinkName(traversal.getBaseLink().getIndex());
baseIndex = berdy.model().getFrameIndex(currentBase);
base_angVel = iDynTree.Vector3();
samples = size(human_state.q ,2);

for i = 1: samples
    q.fromMatlab(human_state.q(:,i));
    dq.fromMatlab(human_state.dq(:,i));
    base_angVel.fromMatlab(baseAngVel(:,i));
    
    if opts.task1_SOT
        berdy.updateKinematicsFromFloatingBase(G_T_base{i},q,dq,baseIndex,base_angVel);
    else
        berdy.updateKinematicsFromFloatingBase(q,dq,baseIndex,base_angVel);
    end
    
    berdy.getBerdyMatrices(berdyMatrices.D,...
        berdyMatrices.b_D,...
        berdyMatrices.Y,...
        berdyMatrices.b_Y,...
        opts.stackOfTaskMAP);
    
    Y_nonsparse = berdyMatrices.Y.toMatlab();
    
    Y   = sparse(Y_nonsparse);
    b_Y = berdyMatrices.b_Y.toMatlab();
    
    y_simulated(:,i) = Y * mu_dgiveny(:,i) + b_Y;
end
end
