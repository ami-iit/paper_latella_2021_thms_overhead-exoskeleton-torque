
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [selectedJoints] = cell2iDynTreeStringVector(array)
% CELL2IDYNTREESTRINGVECTOR transforms an iDynTree StringVector object into
% a cell array.

selectedJoints = iDynTree.StringVector();
for i = 1 : length(array)
    selectedJoints.push_back(array{i});
end
assert(selectedJoints.size == length(array), 'Vector size mismatch');
end
