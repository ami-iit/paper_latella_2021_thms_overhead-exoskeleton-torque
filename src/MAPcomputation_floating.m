
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [mu_dgiveny, Sigma_dgiveny] = MAPcomputation_floating(berdy, traversal, state, y, G_T_base, priors, baseAngVel, opts, varargin)
% MAPCOMPUTATION_FLOATING solves the inverse dynamics problem with a
% maximum-a-posteriori estimation by using the Newton-Euler algorithm and
% redundant sensor measurements as described in the paper

% Simultaneous Floating-Base Estimation of Human Kinematics and Joint Torques
% Latella, C.; Traversaro, S.; Ferigo, D.; Tirupachuri, Y.; Rapetti, L.;
% Andrade Chavez, F.J.; Nori, F.; Pucci, D.
% Sensors 2019, 19, 2794. https://doi.org/10.3390/s19122794
%
% Considering a generic multibody model composed by n moving rigid bodies
% (i.e., links) connected by joints and being in the Gaussian framework,
% the output 'mu_dgiveny' coincides with the vector 'd' structured as
% follows
%                 d  = [d_1, d_2, ..., d_n], i = 1,...,n
%
% where:
%                d_i = [a_i, f_i, fx_i, ddq_i]
%
% and a_i is the link-i spatial acceleration, f_i is the 6D wrench
% transmitted to link-i from its parent, fx_i is the external 6D wrench on
% link-i and ddq_i is acceleration of joint-i.
%
% The relationship between d and the sensor measurements y is given by
%
%                      Y(q, dq) d + b_Y = y                   (1)
%
% where the matrix Y(q, dq), is represented as a sparse matrix. Moreover,
% the variables in d should satisfy the Newton-Euler equations
%
%                    D(q,dq) d + b_D(q, dq) = 0               (2)
%
% again represented as a sparse matrix.
% By stacking together the MEASUREMENTS EQUATIONS (1) and CONSTRAINTS
% EQUATIONS (2)the system that MAP solves is obtained.

% -------------------------------------------------------------------------
% NOTE:
% The function provides an option to remove a specified sensor from the
% analysis.  By default,  MAP is computed by using all the sensors
% (i.e.,  the full vector of y measurements).
% If the sensor to remove is specified in the option , MAP
% loads the full y and then removes automatically values related to that
% sensor and the related block variance from Sigmay.
% -------------------------------------------------------------------------

%% Argument options
options = struct(   ...
    'SENSORS_TO_REMOVE', []...
    );

% read the acceptable names
optionNames = fieldnames(options);

% count arguments
nArgs = length(varargin);
if round(nArgs/2)~=nArgs/2
    error('createXsensLikeURDFmodel needs propertyName/propertyValue pairs')
end

for pair = reshape(varargin,2,[]) % pair is {propName;propValue}
    inpName = upper(pair{1}); % make case insensitive
    
    if any(strcmp(inpName,optionNames))
        % overwrite options. If you want you can test for the right class here
        % Also, if you find out that there is an option you keep getting wrong,
        % you can use "if strcmp(inpName,'problemOption'),testMore,end"-statements
        options.(inpName) = pair{2};
    else
        error('%s is not a recognized parameter name',inpName)
    end
end

%% Sensor removal options
rangeOfRemovedSensors = [];
for i = 1 : size(options.SENSORS_TO_REMOVE)
    ithSensor = options.SENSORS_TO_REMOVE(i);
    [index, len] = rangeOfSensorMeasurement( berdy, ithSensor.type, ithSensor.id, opts.stackOfTaskMAP);
    rangeOfRemovedSensors = [rangeOfRemovedSensors, index : index + len - 1];
end

y(rangeOfRemovedSensors,:) = [];
priors.Sigmay(rangeOfRemovedSensors, :) = [];
priors.Sigmay(:, rangeOfRemovedSensors) = [];
%% Set variables
% Set matrices
berdyMatrices       = struct;
berdyMatrices.D     = iDynTree.MatrixDynSize();
berdyMatrices.b_D   = iDynTree.VectorDynSize();
berdyMatrices.Y     = iDynTree.MatrixDynSize();
berdyMatrices.b_Y   = iDynTree.VectorDynSize();

berdy.resizeAndZeroBerdyMatrices(berdyMatrices.D,...
    berdyMatrices.b_D,...
    berdyMatrices.Y,...
    berdyMatrices.b_Y,...
    opts.stackOfTaskMAP);

% Set priors
mud        = priors.mud;
Sigmad = sparse(priors.Sigmad);
SigmaD = sparse(priors.SigmaD);
Sigmay = sparse(priors.Sigmay);

% Allocate outputs
samples = size(y, 2);
nrOfDynVariables = berdy.getNrOfDynamicVariables(opts.stackOfTaskMAP);
mu_dgiveny    = zeros(nrOfDynVariables, samples);
% Sigma_dgiveny = sparse(nrOfDynVariables, nrOfDynVariables, samples);
Sigma_dgiveny =  cell(samples,1);

%% MAP Computation
q  = iDynTree.JointPosDoubleArray(berdy.model());
dq = iDynTree.JointDOFsDoubleArray(berdy.model());
currentBase = berdy.model().getLinkName(traversal.getBaseLink().getIndex());
baseIndex = berdy.model().getFrameIndex(currentBase);
base_angVel = iDynTree.Vector3();

for i = 1 : samples
    q.fromMatlab(state.q(:,i));
    dq.fromMatlab(state.dq(:,i));
    base_angVel.fromMatlab(baseAngVel(:,i));
    
    if opts.task1_SOT
        berdy.updateKinematicsFromFloatingBase(G_T_base{i},q,dq,baseIndex,base_angVel);
    else
        berdy.updateKinematicsFromFloatingBase(q,dq,baseIndex,base_angVel);
    end
    
    berdy.getBerdyMatrices(berdyMatrices.D,...
        berdyMatrices.b_D,...
        berdyMatrices.Y,...
        berdyMatrices.b_Y,...
        opts.stackOfTaskMAP);
    
    D   = sparse(berdyMatrices.D.toMatlab());
    b_D = berdyMatrices.b_D.toMatlab();
    Y_nonsparse = berdyMatrices.Y.toMatlab();
    Y_nonsparse(rangeOfRemovedSensors, :) = [];
    Y   = sparse(Y_nonsparse);
    b_Y = berdyMatrices.b_Y.toMatlab();
    
    b_Y(rangeOfRemovedSensors) = [];
    
    % Check on the [Y; D] matrix rank
    if (i==1)
        bigMatrix = full([Y; D]);
        rowsOfbigMatrix = size(bigMatrix,1);
        columnsOfbigMatrix = size(bigMatrix,2);
        % svd
        svd_bigMatrix = svd(bigMatrix);
        rank_bigMatrix = nnz(svd_bigMatrix);
        if (rowsOfbigMatrix > columnsOfbigMatrix)
            if rank_bigMatrix == nrOfDynVariables
                disp('[Info] [Y; D] is a full rank matrix with rows > columns');
            else
                disp('[Info] [Y; D] is a matrix with rows > columns');
            end
        else
            error('[Info] [Y; D] is a matrix with rows < columns! Check the matrix!!');
        end
    end
    
    if ~opts.stackOfTaskMAP
        SigmaBarD_inv   = D' * (SigmaD \ D) + inv(Sigmad);
        
        % the permutation matrix for SigmaBarD_inv is computed only for the first
        % sample, beacuse this matrix does not change in the experiment
        if (i==1)
            [~,~,PBarD]= chol(SigmaBarD_inv);
        end
        
        rhsBarD         = (Sigmad \ mud) - D' * (SigmaD \ b_D);
        muBarD          = CholSolve(SigmaBarD_inv , rhsBarD, PBarD);
        
        Sigma_dgiveny_inv = SigmaBarD_inv + Y' * (Sigmay \ Y);
        
        % the permutation matrix for Sigma_dgiveny_inv is computed only for the first
        % sample, beacuse this matrix does not change in the experiment
        if (i==1)
            [~,~,P]= chol(Sigma_dgiveny_inv);
        end
        rhs             = Y' * (Sigmay \ (y(:,i) - b_Y)) + SigmaBarD_inv * muBarD;
        
    else
        
        Sigma_dgiveny_inv = Y' * (Sigmay \ Y);
        
        % the permutation matrix for Sigma_dgiveny_inv is computed only for the first
        % sample, beacuse this matrix does not change in the experiment
        if (i==1)
            [~,~,P]= chol(Sigma_dgiveny_inv);
        end
        rhs              = Y' * (Sigmay \ (y(:,i) - b_Y));
    end
    
    if nargout > 1   % Sigma_dgiveny requested as output
        Sigma_dgiveny{i}   = inv(Sigma_dgiveny_inv);
        mu_dgiveny(:,i)    = Sigma_dgiveny{i} * rhs;
    else             % Sigma_dgiveny does not requested as output
        mu_dgiveny(:,i)    = CholSolve(Sigma_dgiveny_inv, rhs, P);
    end
end
end

function [x] = CholSolve(A, b, P)
if ~issymmetric(A)
    A = (A+A')/2;
end
C              = P'*A*P;  % P is given as input
[R]            = chol(C); % R is such that R'*R = P'*C*P

w_forward      = P\b;
z_forward      = R'\w_forward;
y_forward      = R\z_forward;
x              = P'\y_forward;
end
