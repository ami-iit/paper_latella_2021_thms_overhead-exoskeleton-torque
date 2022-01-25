
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [index, len] = rangeOfSensorMeasurement(berdy, sensType, sensID, stackOfTaskMAP)
% RANGEOFDYNAMICVARIABLE returns the index and a range of a variable
% of the vector y, given the type of variable and its label.

sensorOrder = berdy.getSensorsOrdering(stackOfTaskMAP);
index = -1;
len = 0;
for i = 1:size(sensorOrder,2)
    currentInfo = sensorOrder{i};
    if currentInfo.type == sensType && strcmp(currentInfo.id, sensID)
        range = currentInfo.range;
        index = range.offset + 1;
        len = range.size;
        break;
    end
end
end
