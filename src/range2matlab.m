
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [matlabRange] = range2matlab(iDynTreeRange)
% RANGE2MATLAB converts an iDynTree.Range struct to a Matlab range.

matlabRange = (iDynTreeRange.offset+1):(iDynTreeRange.offset+iDynTreeRange.size);
end
