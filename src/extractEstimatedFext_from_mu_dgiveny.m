
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [Fext] = extractEstimatedFext_from_mu_dgiveny(berdy, dVectorOrder, mu_dgiveny, stackOfTaskMAP)
% EXTRACTEDESTIMATEDFEXT_FROM_MUDGIVENY extracts the estimated external
% wrenches by MAP.

nrOfLinks = size(dVectorOrder,1);
range = zeros(nrOfLinks,1);
nrOfSamples  = size(mu_dgiveny  ,2);

Fext = zeros(6*size(dVectorOrder,1), nrOfSamples);
for i = 1 : nrOfLinks
    range(i,1) = (rangeOfDynamicVariable(berdy, iDynTree.NET_EXT_WRENCH, dVectorOrder{i}, stackOfTaskMAP));
    tmpRange = range(i,1) : range(i,1)+5;
    Fext(6*(i-1)+1:6*i,:) = mu_dgiveny(tmpRange,:);
end
end
