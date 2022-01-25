
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% ------------------------------------------------------------------------
%% ------------------------- COVARIANCES PRIORS ---------------------------
%% ------------------------------------------------------------------------
priors.acc_IMU     = priors.trusted * ones(3,1);  %[m^2/s^2]
priors.angAcc      = priors.trusted * ones(3,1);
priors.ddq         = priors.trusted;              %[rad^2/s^4]
priors.foot_fext   = priors.trusted * ones(6,1);  %[N^2,(Nm)^2]
priors.noSens_fext = priors.trusted * ones(6,1);  %[N^2,(Nm)^2]

bucket.Sigmad = priors.no_trusted; % low reliability on the estimation (i.e., no prior info on the model regularization term d)
bucket.SigmaD = priors.trusted;    % high reliability on the model constraints

if opts.EXO
    priors.exo_fext = priors.trusted * ones(6,1); %[N^2,(Nm)^2]
end

% covariances for SOT in Task1
priors.fext_hands = priors.no_trusted * ones(6,1);  %[N^2,(Nm)^2]
priors.b_dh       = priors.trusted * ones(6,1);
