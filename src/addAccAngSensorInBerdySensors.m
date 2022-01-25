
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [humanSensors] = addAccAngSensorInBerdySensors(humanSensors, name,parentLink, linkIndex, S_R_L, posSwrtL)
% ADDACCANGSENSORINBERDYSENSORS adds the angular accelerometer sensors to
% the iDynTree Berdy sensor.

newAngAccSens = iDynTree.ThreeAxisAngularAccelerometerSensor;
newAngAccSens.setName(name);
newAngAccSens.setParentLink(parentLink);
newAngAccSens.setParentLinkIndex(linkIndex);

% Rotation
link_T_sensorRot = iDynTree.Rotation();
link_T_sensorRot.fromMatlab(S_R_L);

% Position
link_T_sensorPos = iDynTree.Position();
link_T_sensorPos.fromMatlab(posSwrtL); % in m

% iDynTreeTransform
link_T_sensor = iDynTree.Transform(link_T_sensorRot,link_T_sensorPos);

newAngAccSens.setLinkSensorTransform(link_T_sensor);
humanSensors.addSensor(newAngAccSens);
end
