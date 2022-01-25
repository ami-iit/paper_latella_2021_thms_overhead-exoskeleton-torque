
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [y, Sigmay] = berdyMeasurementsWrapping(berdy, data, stackOfTaskMAP)
% BERDYMEASUREMENTSWRAPPING orders the measurements in a format
% compatible with the BerdyHelper class.  It returns a vector of
% ordered measurements and its associated covariance matrix.

sensorOrder = berdy.getSensorsOrdering(stackOfTaskMAP);

y = zeros(berdy.getNrOfSensorsMeasurements(stackOfTaskMAP),size(data(1).meas,2));
Sigmay = zeros(berdy.getNrOfSensorsMeasurements(stackOfTaskMAP), ...
    berdy.getNrOfSensorsMeasurements(stackOfTaskMAP));
for i = 1:size(sensorOrder,2)
    currentInfo = sensorOrder{i};
    found = false;
    for j = 1 : length(data)
        data_j = data(j);
        if (data_j.type == currentInfo.type && ...
                strcmp(data_j.id, currentInfo.id))
            found = true;
            matRange = range2matlab(currentInfo.range);
            y(matRange,:) = data_j.meas;
            Sigmay(matRange,matRange) = diag(data_j.var);
            break;
        end
    end
    if (found == false)
        error(strcat('Could not find sensor type', num2str(currentInfo.type),...
            ' id: ', currentInfo.id ));
    end
end
end
