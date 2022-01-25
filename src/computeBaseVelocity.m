
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [baseLinVelocity, baseAngVelocity] = computeBaseVelocity(kinDynComputation, state,  I_T_base ,contactPattern)
% COMPUTEBASEANGULARVELOCITY computes the angular velocity of the model base
% via differential kinematic equation in [rad/s].
%
% The 6D velocity of the base w.r.t. the inertial frame I is:
%
%              I_v_b = - pinv(J(q)_b)* J(q)_S*\dot(s)
%
% where I_v_b = [I_\dot(x)_b; I_w_p].
%
% Inputs:
% - kinDynComputation: berdy object
% - currentBerdyBase:  base of the model
% - state:             Matlab struct containing q and dq
% - I_T_base           iDynTreeTransform from the base frame to the inertial
%                      frame
% - contactPattern:    list of frames of end effectors whose velocity is assumed
%                      to be zero (e.g., a frame associated to a link that is in
%                      fixed contact with the ground)
% Outputs:
% - baseAngVelocity:   I_\dot(x)_b, linear velocity of the base B w.r.t. the
%                      inertial frame I, in [rad/s]
% - baseAngVelocity:   I_w_b, angular velocity of the base B w.r.t. the
%                      inertial frame I, in [rad/s]

q  = iDynTree.JointPosDoubleArray(kinDynComputation.model);
dq = iDynTree.JointDOFsDoubleArray(kinDynComputation.model);
base_vel = iDynTree.Twist();
gravity  = iDynTree.Vector3();
gravity.fromMatlab([0; 0; -9.81]);

samples = size(state.q ,2);
baseLinVelocity = zeros(3,samples);
baseAngVelocity = zeros(3,samples);

for i = 1 : samples
    q.fromMatlab(state.q(:,i));
    dq.fromMatlab(state.dq(:,i));
    base_vel.fromMatlab(zeros(6,1));
    % Compute the Jacobian J = [J(q)_B J(q)_S]
    kinDynComputation.setRobotState(I_T_base.G_T_b{i,1},q,base_vel,dq,gravity);
    
    if strcmp(contactPattern{i},'doubleSupport')
        endEffectorFrame = {'LeftFoot','RightFoot'};
    else
        endEffectorFrame = contactPattern{i};
    end
    
    fullJacobian = getFloatingContactJacobian(kinDynComputation,endEffectorFrame);
    % Compute I_v_B
    I_v_b = - pinvDamped(fullJacobian(:,1:6),1e-4)* fullJacobian(:,7:end)*state.dq(:,i);
    baseLinVelocity(:,i) = I_v_b(1:3,:);
    baseAngVelocity(:,i) = I_v_b(4:6,:);
end
end
