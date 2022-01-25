
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [b_dh] = computeRateOfChangeOfCentroidalMomentumWRTbase(kinDynComputation, humanModel, state, baseVelocity, G_T_b)
% COMPUTERATEOFCHANGEOFCENTROIDALMOMENTUMWRTBASE computes the 6D rate of
% change of the centroidal momentum expressed w.r.t. the base.  Starting
% from the formula of the centroidal momentum expressed w.r.t. base, i.e.,
%
%                     b_h = (b_X_C * C_h)                           (1)
%
% the objective is to compute the derivative of (1), i.e.,
%
%                   b_dh ~= (b_X_C * C_dh)                          (2)
%
% being:
% - C cetroidal frame
% - b base frame
% - b_X_C the adjoint 6x6 wrench transform
% - C_h   the centroidal momentum expressed w.r.t. C frame
% - C_dh  the rate of change of the centroidal momentum expressed
%         w.r.t. C frame, such as C_dh = m * (linAccCOM - g)
%         where:
%         - m is the model total mass
%         - linAccCOM is the linear CoM acceleration w.r.t. C

q  = iDynTree.JointPosDoubleArray(kinDynComputation.model);
dq = iDynTree.JointDOFsDoubleArray(kinDynComputation.model);
base_vel = iDynTree.Twist();
gravity = iDynTree.Vector3();
gravityMatlab = [0; 0; -9.81];
gravity.fromMatlab(gravityMatlab);

% Centroidal frame with the orientation of the global frame
G_R_C = iDynTree.Rotation();
G_R_C.fromMatlab([ 1.0,  0.0,  0.0; ...
                   0.0,  1.0,  0.0; ...
                   0.0,  0.0,  1.0]);

samples = size(state.q ,2);
b_dh = zeros(6,samples);
for i = 1 : samples
    q.fromMatlab(state.q(:,i));
    dq.fromMatlab(state.dq(:,i));
    base_vel.fromMatlab(baseVelocity(:,i));
    kinDynComputation.setRobotState(G_T_b{i,1},q,base_vel,dq,gravity);
    
    % Get the bias acceleration of the COM w.r.t. C frame
    biasAccCOM = kinDynComputation.getCenterOfMassBiasAcc();
    % Compute C_dh
    C_dh =  [humanModel.getTotalMass * (biasAccCOM.toMatlab() - gravityMatlab); ...
             zeros(3,1)]; %zeros(3,1) is the angular part. For now, its measurement is equal to zero.
    % Compute the transform b_T_C = b_T_G * G_T_C
    % 1) G_T_C
    G_pos_C = kinDynComputation.getCenterOfMassPosition();
    G_T_C = iDynTree.Transform(G_R_C, G_pos_C);
    % 2) b_T_G
    b_T_G = G_T_b{i,1}.inverse;
    b_T_C = b_T_G * G_T_C;
    % Compute b_dh
    b_dh(:,i) =  b_T_C.asAdjointTransformWrench.toMatlab() * C_dh;
end
