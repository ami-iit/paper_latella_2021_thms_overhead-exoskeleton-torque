
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function contactJacobian = getFloatingContactJacobian(kinDynComputation,contactFrames)
% GETFLOATINGCONTACTJACOBIAN gets and stacks the jacobians for all contact
% forces. This method assumes the state has been already updated.
%
% Inputs:
% - kinDynComputation: structure that contains the model and performs the
%   actual calculation of the jacobian for the desired frame
% - contactFrames: frames in which the contact is happening

if iscellstr(contactFrames)
    % received contact frame names
    names=true;
else
    if isstr(contactFrames)
        % means there is only one frame in the form of a string
        names=true;
        contactFrames={contactFrames};
    else
        % received integer indicating the frame index
        names=false;
    end
end

idyn_Jacobian=  iDynTree.FrameFreeFloatingJacobian(kinDynComputation.model);
idyn_Jacobian.zero();
contactJacobian=[];
for frame=1:length(contactFrames)
    if names
        kinDynComputation.getFrameFreeFloatingJacobian(contactFrames{frame}, idyn_Jacobian);
    else
        kinDynComputation.getFrameFreeFloatingJacobian(contactFrames(frame), idyn_Jacobian);
    end
    contactJacobian=[contactJacobian;idyn_Jacobian.toMatlab];
end
