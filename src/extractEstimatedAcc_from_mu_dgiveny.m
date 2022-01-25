
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [Acc] = extractEstimatedAcc_from_mu_dgiveny(berdy, dVectorOrder, mu_dgiveny, stackOfTaskMAP)
% EXTRACTEDESTIMATEDACC_FROM_MUDGIVENY extracts the estimated 6D accelerations
% by MAP.

nrOfLinks = size(dVectorOrder,1);
range = zeros(nrOfLinks,1);
nrOfSamples  = size(mu_dgiveny  ,2);

Acc = zeros(6*size(dVectorOrder,1), nrOfSamples);
for i = 1 : nrOfLinks
    range(i,1) = (rangeOfDynamicVariable(berdy, ...
        iDynTree.LINK_BODY_PROPER_CLASSICAL_ACCELERATION, dVectorOrder{i}, stackOfTaskMAP));
    tmpRange = range(i,1) : range(i,1)+5;
    Acc(6*(i-1)+1:6*i,:) = mu_dgiveny(tmpRange,:);
end
end
