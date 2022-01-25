
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [Fint] = extractEstimatedFint_from_mu_dgiveny(berdy, selectedJoints, mu_dgiveny, stackOfTaskMAP)
% EXTRACTEDESTIMATEDFINT_FROM_MUDGIVENY extracts the estimated internal
% wrenches by MAP.

nrOfJoints = size(selectedJoints,1);
range = zeros(nrOfJoints,1);
nrOfSamples  = size(mu_dgiveny  ,2);

Fint = zeros(6*size(selectedJoints,1), nrOfSamples);
for i = 1 : nrOfJoints
    range(i,1) = (rangeOfDynamicVariable(berdy, iDynTree.JOINT_WRENCH, selectedJoints{i}, stackOfTaskMAP));
    tmpRange = range(i,1) : range(i,1)+5;
    Fint(6*(i-1)+1:6*i,:) = mu_dgiveny(tmpRange,:);
end
end
