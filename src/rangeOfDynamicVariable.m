
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [index, len] = rangeOfDynamicVariable(berdy, varType, varID, stackOfTaskMAP)
% RANGEOFDYNAMICVARIABLE returns the index and a range of a variable
% of the vector d, given the type of variable and its label.

dynVariable = berdy.getDynamicVariablesOrdering(stackOfTaskMAP);
index = -1;
len = 0;
for i = 1:size(dynVariable,2)
    currentInfo = dynVariable{i};
    if currentInfo.type == varType && strcmp(currentInfo.id, varID)
        range = currentInfo.range;
        index = range.offset + 1;
        len = range.size;
        break;
    end
end
end
