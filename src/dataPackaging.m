
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [dataPacked] = dataPackaging(blockIdx, model, base, sensors, suit, angAcc, fext, b_dh, ddq, contactLink, priors, stackOfTaskMAP)
% DATAPACKAGING creates a data struct organised as follows:
% - data.time (a unified time for all type of sensors)
%
% Each substructure is identified by:
% - type: the type associated to the sensors in iDynTree
% - id  : labels coming from 'model' and 'sensor'
% - meas: value of measurements
% - var : variance of sensor

data      = struct;
data.acc  = struct;
data.angAcc  = struct;
data.ddq  = struct;
data.fext = struct;

%% FROM SUIT
% SENSOR: <ACCELEROMETER>
% type
data.acc.type = iDynTree.ACCELEROMETER_SENSOR;
% id
nOfSensor.acc = sensors.getNrOfSensors(data.acc.type);
data.acc.id   = cell(nOfSensor.acc,1);
for i = 1 : nOfSensor.acc
    data.acc.id{i} = sensors.getSensor(data.acc.type, i-1).getName;
end
% meas
data.acc.meas = cell(nOfSensor.acc,1);
tempData = cell(nOfSensor.acc,2);
sensorsLabelToCmp  = cell(nOfSensor.acc,1);
nOfSensorsFromSuit = size(suit.sensors,1);
for i = 1 :  nOfSensor.acc
    tempData(i,:) = strsplit(data.acc.id{i}, '_');
    sensorsLabelToCmp{i}= tempData(i,1);
    for j = 1 : nOfSensorsFromSuit
        if  strcmp(sensorsLabelToCmp{i},suit.sensors{j, 1}.label)
            data.acc.meas{i} = suit.sensors{j, 1}.meas(blockIdx).sensorOldAcceleration;
            break;
        end
    end
end
% variance
data.acc.var = priors.acc_IMU;

% SENSOR: <ANGULAR ACCELEROMETER>
% type
data.angAcc.type = iDynTree.THREE_AXIS_ANGULAR_ACCELEROMETER_SENSOR;
% id
nOfSensor.angAcc = length(suit.sensors);
data.angAcc.id   = cell(nOfSensor.angAcc,1);
for i = 1 : nOfSensor.angAcc
    data.angAcc.id{i} = angAcc(i).sensorName;
end
% meas
data.angAcc.meas = cell(nOfSensor.angAcc,1);
for i = 1 : nOfSensor.angAcc
    data.angAcc.meas{i} = angAcc(i).meas(blockIdx).S_meas_L;
end
% variance
data.angAcc.var = priors.angAcc;

%% FROM b_dh
if stackOfTaskMAP
    data.b_dh  = struct;
    % type
    data.b_dh.type = iDynTree.COM_ACCELEROMETER_SENSOR;
    % id & meas
    data.b_dh.id   = base;
    data.b_dh.meas = b_dh;
    % variance
    data.b_dh.var  = priors.b_dh;
end

%% FROM ddq
nOfSensor.DOFacc = size(ddq,1);
jointNameFromModel = cell(nOfSensor.DOFacc,1);
for i = 1 : nOfSensor.DOFacc
    jointNameFromModel{i} = model.getJointName(i-1);
end

% SENSOR: <DOF ACCELERATION SENSOR>
% type
data.ddq.type = iDynTree.DOF_ACCELERATION_SENSOR;
% id & meas
data.ddq.id   = cell(size(jointNameFromModel));
data.ddq.meas = cell(size(jointNameFromModel));
for i = 1 : nOfSensor.DOFacc
    data.ddq.id{i}   = jointNameFromModel{i};
    data.ddq.meas{i} = ddq(i,:);
end
% variance
data.ddq.var = priors.ddq;

%% FROM FORCE SOURCE (it could be forceplates OR shoes)
% ---------------------------------------------------------------
% Both sensors are considered as external forces acting as follow:
% - on human rightFoot --> FP1 or ftShoe_Right
% - on human leftFoot  --> FP2 or ftShoe_Left
% - null meas for all the others.
% ---------------------------------------------------------------
nOfSensor.fext = model.getNrOfLinks;
linkNameFromModel = cell(model.getNrOfLinks,1);
for i = 1 : model.getNrOfLinks
    linkNameFromModel{i} = model.getLinkName(i-1);
end

% SENSOR: <EXTERNAL FORCES>
% type
data.fext.type = iDynTree.NET_EXT_WRENCH_SENSOR;
% id
data.fext.id   = cell(size(linkNameFromModel));
for i = 1 : nOfSensor.fext
    data.fext.id{i}     = linkNameFromModel{i};
end
% meas
data.fext.meas = cell(size(linkNameFromModel));

index = cell(size(contactLink));
for i = 1: size(contactLink,1)
    for indx = 1 : nOfSensor.fext
        if  strcmp(data.fext.id{indx},contactLink{i})
            index{i} = indx;
        end
    end
end

% fill the all meas with null fext
wrench = zeros(size(fext.rightHuman));
for i =  1 : nOfSensor.fext
    data.fext.meas{i} = wrench;
    % fill with the 4 fext that are not null
    % <FOR FORCEPLATE>
    if i == index{1}
        data.fext.meas{i} = fext.rightHuman;
    elseif i == index{2}
        data.fext.meas{i} = fext.leftHuman;
    end
end
% variance
data.fext.var = priors.noSens_fext;

%% Final Packaging
dataPacked = struct;
for i = 1 : nOfSensor.acc
    dataPacked(i).type = data.acc.type;
    dataPacked(i).id   = data.acc.id{i};
    dataPacked(i).meas = data.acc.meas{i};
    dataPacked(i).var  = data.acc.var;
end
indx = nOfSensor.acc;
%--
for i = 1 : nOfSensor.angAcc
    dataPacked(i + (indx)).type = data.angAcc.type;
    dataPacked(i + (indx)).id   = data.angAcc.id{i};
    dataPacked(i + (indx)).meas = data.angAcc.meas{i};
    dataPacked(i + (indx)).var  = data.angAcc.var;
end
indx = indx + nOfSensor.angAcc;
%--
if stackOfTaskMAP
    % COM_sensor
    dataPacked(indx + 1).type = data.b_dh.type;
    dataPacked(indx + 1).id   = data.b_dh.id;
    dataPacked(indx + 1).meas = data.b_dh.meas;
    dataPacked(indx + 1).var  = data.b_dh.var;
    indx = indx + 1;
end
%--
for i = 1 : nOfSensor.DOFacc
    dataPacked(i + (indx)).type = data.ddq.type;
    dataPacked(i + (indx)).id   = data.ddq.id{i};
    dataPacked(i + (indx)).meas = data.ddq.meas{i};
    dataPacked(i + (indx)).var  = data.ddq.var;
end
indx = indx + nOfSensor.DOFacc;

for i = 1 : nOfSensor.fext
    dataPacked(i + (indx)).type = data.fext.type;
    dataPacked(i + (indx)).id   = data.fext.id{i};
    dataPacked(i + (indx)).meas = data.fext.meas{i};
    dataPacked(i + (indx)).var  = data.fext.var;
    if i == index{1}
        dataPacked(i + (indx)).var = priors.foot_fext;
    elseif i == index{2}
        dataPacked(i + (indx)).var = priors.foot_fext;
    end
end
end
