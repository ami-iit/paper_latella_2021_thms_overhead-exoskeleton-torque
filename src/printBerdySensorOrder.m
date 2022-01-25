
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function printBerdySensorOrder(berdy, stackOfTaskMAP)
% PRINTBERDYSENSORORDER prints the order of the sensors in the vector y.
% For each measurement, the function returns:
% - the type of sensor
% - the index of its location in the vector y (NOTE: it is in  0-based
%   notation!)
% - the range or lenght of element for that sensor
%
% With the option stackOfTaskMAP = true, the function prints the y vector
% with only the measurements of the external forces and the rate of
% change of the linear momentum.

sensorOrder = berdy.getSensorsOrdering(stackOfTaskMAP);

for i = 1 : size(sensorOrder,2)
    currentInfo = sensorOrder{i};
    
    type = currentInfo.type;
    typeStr = '';
    switch(type)
        case iDynTree.SIX_AXIS_FORCE_TORQUE_SENSOR
            typeStr = 'Int_Wrench_sensor       ';
        case iDynTree.ACCELEROMETER_SENSOR
            typeStr = 'Accelerometer           ';
        case iDynTree.THREE_AXIS_ANGULAR_ACCELEROMETER_SENSOR
            typeStr = 'AngAcceleration_sensor  ';
        case iDynTree.GYROSCOPE_SENSOR
            typeStr= 'Gyroscope                ';
        case iDynTree.COM_ACCELEROMETER_SENSOR
            typeStr = 'COMacceleration_sensor  ';
        case iDynTree.DOF_ACCELERATION_SENSOR
            typeStr = 'JointAcceleration_sensor';
        case iDynTree.DOF_TORQUE_SENSOR
            typeStr = 'JointTorque_sensor      ';
        case iDynTree.NET_EXT_WRENCH_SENSOR
            typeStr = 'Ext_wrench_sensor       ';
        case iDynTree.JOINT_WRENCH_SENSOR
            typeStr = 'JointWrench_sensor      ';
    end
    range = currentInfo.range;
    
    fprintf('[%d]Var type %s - id %s -- (idx-length) = (%d-%d)\n', i, typeStr,...
        currentInfo.id, range.offset, range.size);
end
end
