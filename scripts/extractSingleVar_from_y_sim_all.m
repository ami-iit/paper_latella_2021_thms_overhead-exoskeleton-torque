
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

% -----------------------------------------------------------------------%
%  EXTERNAL FORCES
% -----------------------------------------------------------------------%
for blockIdx = blockID
    y_sim_fext(blockIdx).block = block.labels(blockIdx);
    y_sim_fext(blockIdx).order = dVectorOrder;
    y_sim_fext(blockIdx).meas  = cell(length(dVectorOrder),1);
    for vectOrderIdx = 1 : length(dVectorOrder)
        range_fextMEAS = rangeOfSensorMeasurement(berdy, iDynTree.NET_EXT_WRENCH_SENSOR, dVectorOrder{vectOrderIdx}, opts.stackOfTaskMAP);
        y_sim_fext(blockIdx).meas{vectOrderIdx,1} = y_sim(blockIdx).y_sim((range_fextMEAS:range_fextMEAS+5),:);
    end
end
if opts.task1_SOT
    save(fullfile(bucket.pathToProcessedData_SOTtask1,'y_sim_fext.mat'),'y_sim_fext');
else
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'y_sim_fext.mat'),'y_sim_fext');
end

if ~opts.task1_SOT
    % -----------------------------------------------------------------------%
    %  LIN ACCELERATION
    % -----------------------------------------------------------------------%
    for blockIdx = blockID
        nrOfLinAccelerometer = 17;
        y_sim_linAcc(blockIdx).block = block.labels(blockIdx);
        y_sim_linAcc(blockIdx).order = cell(nrOfLinAccelerometer,1);
        y_sim_linAcc(blockIdx).meas = cell(nrOfLinAccelerometer,1);
        for accSensIdx = 1 : nrOfLinAccelerometer
            y_sim_linAcc(blockIdx).order{accSensIdx,1} = data(blockIdx).data(accSensIdx).id;
            range_linAccMEAS = rangeOfSensorMeasurement(berdy, iDynTree.ACCELEROMETER_SENSOR, data(blockIdx).data(accSensIdx).id, opts.stackOfTaskMAP);
            y_sim_linAcc(blockIdx).meas{accSensIdx,1} = y_sim(blockIdx).y_sim((range_linAccMEAS:range_linAccMEAS+2),:);
        end
    end
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'y_sim_linAcc.mat'),'y_sim_linAcc');
    
    % -----------------------------------------------------------------------%
    %  JOINT ACCELERATION
    % -----------------------------------------------------------------------%
    for blockIdx = blockID
        y_sim_ddq(blockIdx).block = block.labels(blockIdx);
        y_sim_ddq(blockIdx).order = selectedJoints;
        y_sim_ddq(blockIdx).meas = cell(humanModel.getNrOfDOFs,1);
        for ddqIdx = 1 : humanModel.getNrOfDOFs
            range_ddqMEAS = rangeOfSensorMeasurement(berdy, iDynTree.DOF_ACCELERATION_SENSOR, selectedJoints{ddqIdx}, opts.stackOfTaskMAP);
            y_sim_ddq(blockIdx).meas{ddqIdx,1} = y_sim(blockIdx).y_sim(range_ddqMEAS,:);
        end
    end
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'y_sim_ddq.mat'),'y_sim_ddq');
end
