
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function printBerdyDynVariables_floating( berdy, stackOfTaskMAP)
% PRINTBERDYDYNVARIABLE_FLOATING prints the order of the vector d.
% For each time frame, d is a vector column vector
% [berdy.getNrOfDynamicVariables() x 1]
% where to each ith-link it is associated the following structure:
%
%  1)    d_i = [a_i, f_i, fx_i, ddq_i]     if in Task 2 of the Stack of task (SOT)
%                                          when stackOfTaskMAP = false
%  2)    d_i = [fx_i]                      if in Task 1 of the Stack of task (SOT)
%                                          when stackOfTaskMAP = true
% Please note that Task 2 coincides with complete version of the
% floating-base MAP computation.
%
% For each variable, the function returns:
% - the type of variable
% - the index of its location in the vector d (NOTE: it is in  0-based
%   notation!)
% - the range or lenght of element for that variable.

dynVariable = berdy.getDynamicVariablesOrdering(stackOfTaskMAP);

for i = 1:size(dynVariable,2)
    currentInfo = dynVariable{i};
    
    type = currentInfo.type;
    typeStr = '';
    switch(type)
        case iDynTree.LINK_BODY_PROPER_CLASSICAL_ACCELERATION
            typeStr = '6D acc      ';
        case iDynTree.JOINT_WRENCH
            typeStr= 'Joint Wrench';
        case iDynTree.NET_EXT_WRENCH
            typeStr = 'Ext. Wrench ';
        case iDynTree.DOF_ACCELERATION
            typeStr = 'Joint acc   ';
    end
    range = currentInfo.range;
    
    fprintf('[%d]Var type %s - id %s -- (idx-length) = (%d-%d)\n', i, typeStr,...
        currentInfo.id, range.offset, range.size);
end
end
