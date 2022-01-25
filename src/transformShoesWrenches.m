
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [shoes] = transformShoesWrenches(synchroStruct, subjectParamsFromData)
% TRANSFORMSHOESWRENCHES transforms external 6D wrenches acquired by the shoes
% w.r.t. human frames. This function computes the 6D wrenches that each shoe
% exerts on the link in contact.
% [See the sketch misc/footInShoe.pdf for the reference frames locations].
%
% Inputs:
% - synchroStruct,        : right and left data
% - subjectParamsFromData : for getting the ankle heights, i.e., the origin
%                           position of the reference frame of both the feet
%                           w.r.t. their projection on each shoe
% Outputs:
% - shoes : struct containing the shoes 6D wrenches expressed w.r.t. human frames
%
% Shoes wrenches are estimated w.r.t. their frames (i.e., origin and
% orientation) that are located at a known position.
%
% For the human estimation we need these wrenches to be
% - multiplied by -1 (as the wrench applied on the human is exactly the
%   opposite of the one excerted on each shoe)
% - expressed in the frame w.r.t. the human link in contact with the shoe

%% Build the transformations
gravityZero = iDynTree.Vector3();
gravityZero.zero();

% LEFT---------------------------------------------------------------------
leftHeel_T_leftFtShoeRot = iDynTree.Rotation();
leftHeel_T_leftFtShoeRot.fromMatlab([ 1.0,  0.0,  0.0; ...
                                      0.0,  1.0,  0.0; ...
                                      0.0,  0.0,  1.0]);
leftHeel_T_leftFtShoePos = iDynTree.Position();
leftFtShoeSeenFromLeftHeel = [0.037; 0 ; -0.050]; % FtShoe (totalForce ref)
leftHeel_T_leftFtShoePos.fromMatlab(leftFtShoeSeenFromLeftHeel); % in m
leftFoot_T_leftHeelPos = iDynTree.Position();
leftHeelSeenFromLeftFoot = subjectParamsFromData.pLeftHeelFoot;
leftFoot_T_leftHeelPos.fromMatlab(leftHeelSeenFromLeftFoot); % in m
leftFoot_T_leftFtShoe = iDynTree.Transform(leftHeel_T_leftFtShoeRot,...
    leftFoot_T_leftHeelPos + leftHeel_T_leftFtShoePos);

% RIGHT--------------------------------------------------------------------
rightHeel_T_rightFtShoeRot = iDynTree.Rotation();
rightHeel_T_rightFtShoeRot.fromMatlab([ 1.0,  0.0,  0.0; ...
                                        0.0,  1.0,  0.0; ...
                                        0.0,  0.0,  1.0]);
rightHeel_T_rightFtShoePos = iDynTree.Position();
rightFtShoeSeenFromRightHeel = [0.037; 0 ; -0.050];
rightHeel_T_rightFtShoePos.fromMatlab(rightFtShoeSeenFromRightHeel); % in m
rightFoot_T_rightHeelPos = iDynTree.Position();
rightHeelSeenFromRightFoot = subjectParamsFromData.pRightHeelFoot;
rightFoot_T_rightHeelPos.fromMatlab(rightHeelSeenFromRightFoot); % in m
rightFoot_T_rightFtShoe = iDynTree.Transform(rightHeel_T_rightFtShoeRot,...
    rightFoot_T_rightHeelPos + rightHeel_T_rightFtShoePos);

%% Transform wrenches from shoes frames into human frames

leftShoeWrench(1:3,:) = synchroStruct.LeftShoe_SF(:,1:3)';
leftShoeWrench(4:6,:) = synchroStruct.LeftShoe_SF(:,4:6)';

rightShoeWrench(1:3,:) = synchroStruct.RightShoe_SF(:,1:3)';
rightShoeWrench(4:6,:) = synchroStruct.RightShoe_SF(:,4:6)';

shoes.block = synchroStruct.block;
% (HF = human frame)
shoes.Left_HF = ...
    -1*(leftFoot_T_leftFtShoe.asAdjointTransformWrench().toMatlab()*leftShoeWrench);
shoes.Right_HF = ...
    -1*(rightFoot_T_rightFtShoe.asAdjointTransformWrench().toMatlab()*rightShoeWrench);
end
