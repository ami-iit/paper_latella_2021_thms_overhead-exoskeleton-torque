
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% ------------------------------------------------------------------------
%% ---------------------------------- MAIN --------------------------------
%% ------------------------------------------------------------------------
bucket.pathToSubject       = fullfile(bucket.datasetRoot, sprintf('S%02d',subjectID));
bucket.pathToTask          = fullfile(bucket.pathToSubject,sprintf('Task%d',taskID));
bucket.pathToRawData       = fullfile(bucket.pathToTask,'data');
bucket.pathToProcessedData = fullfile(bucket.pathToTask,'processed');

if opts.task1_SOT % Task1
    bucket.pathToProcessedData_SOTtask1 = fullfile(bucket.pathToProcessedData,'processed_SOTtask1');
    if ~exist(bucket.pathToProcessedData_SOTtask1)
        mkdir(bucket.pathToProcessedData_SOTtask1)
    end
end

if ~opts.task1_SOT % Task2
    bucket.pathToProcessedData_SOTtask2 = fullfile(bucket.pathToProcessedData,'processed_SOTtask2');
    if ~exist(bucket.pathToProcessedData_SOTtask2)
        mkdir(bucket.pathToProcessedData_SOTtask2)
    end
end

if opts.tuneCovariance
    bucket.pathToCovarianceTuningData   = fullfile(bucket.pathToTask,'covarianceTuning');
    if ~exist(bucket.pathToCovarianceTuningData)
        mkdir(bucket.pathToCovarianceTuningData)
    end
end

if opts.task1_SOT
    %% Load masterFile
    masterFile = load(fullfile(bucket.pathToRawData,sprintf(('S%02d_%02d.mat'),subjectID,taskID)));
    
    %% SUIT struct creation
    if ~exist(fullfile(bucket.pathToProcessedData,'suit.mat'), 'file')
        disp('-------------------------------------------------------------------');
        disp('[Start] Suit extraction ...');
        % 1) extract data from C++ parsed files
        extractSuitDataFromParsing;
        % 2) compute sensor position
        suit = computeSuitSensorPosition(suit);
        save(fullfile(bucket.pathToProcessedData,'suit.mat'),'suit');
        disp('[End] Suit extraction');
    else
        load(fullfile(bucket.pathToProcessedData,'suit.mat'));
    end
    
    % --------------------------------------------------------------
    % OPTIONAL CHECK: print position of the sensors w.r.t. the links
    % sensPosWRTlink = printSensorPosition(suit)
    % --------------------------------------------------------------
    
    %% Extract subject parameters from SUIT
    if ~exist(fullfile(bucket.pathToSubject,'subjectParamsFromData.mat'), 'file')
        subjectParamsFromData = subjectParamsComputation(suit, masterFile.Subject.Info.Weight);
        save(fullfile(bucket.pathToSubject,'subjectParamsFromData.mat'),'subjectParamsFromData');
    else
        load(fullfile(bucket.pathToSubject,'subjectParamsFromData.mat'),'subjectParamsFromData');
    end
    
    %% Create URDF model
    bucket.filenameURDF = fullfile(bucket.pathToSubject, sprintf('XSensURDF_subj%02d_48dof.urdf', subjectID));
    if ~exist(bucket.filenameURDF, 'file')
        bucket.URDFmodel = createXsensLikeURDFmodel( ...
            subjectParamsFromData, ...
            suit.sensors,...
            'filename',bucket.filenameURDF,...
            'GazeboModel',false);
    end
    
    %% Create OSIM model
    bucket.filenameOSIM = fullfile(bucket.pathToSubject, sprintf('XSensOSIM_subj%02d_48dof.osim', subjectID));
    if ~exist(bucket.filenameOSIM, 'file')
        bucket.OSIMmodel = createXsensLikeOSIMmodel( ...
            subjectParamsFromData, ...
            bucket.filenameOSIM);
    end
    
    %% Inverse Kinematic computation
    % Sg parameters setting
    Sg.samplingTime = 1/suit.properties.frameRate;
    Sg.polinomialOrder = 3;
    Sg.window = 57;
    
    if ~exist(fullfile(bucket.pathToProcessedData,'human_state_tmp.mat'), 'file')
        disp('-------------------------------------------------------------------');
        disp('[Start] IK computation ...');
        bucket.setupFile = fullfile(pwd, 'templates', 'setupOpenSimIKTool_Template.xml');
        bucket.trcFile   = fullfile(bucket.pathToRawData,sprintf('S%02d_%02d.trc',subjectID,taskID));
        bucket.motFile   = fullfile(bucket.pathToProcessedData,sprintf('S%02d_%02d.mot',subjectID,taskID));
        [human_state_tmp, selectedJoints] = IK( ...
            bucket.filenameOSIM, ...
            bucket.trcFile, ...
            bucket.setupFile, ...
            Sg, ...
            bucket.motFile);
        save(fullfile(bucket.pathToProcessedData,'human_state_tmp.mat'),'human_state_tmp');
        save(fullfile(bucket.pathToProcessedData,'selectedJoints.mat'),'selectedJoints');
        disp('[End] IK computation');
    else
        load(fullfile(bucket.pathToProcessedData,'human_state_tmp.mat'));
        load(fullfile(bucket.pathToProcessedData,'selectedJoints.mat'));
    end
    % NOTE: selectedJoints is the order of the Osim computation.
    
    if ~exist(fullfile(bucket.pathToProcessedData,'human_ddq_tmp.mat'), 'file')
        % External ddq computation
        human_ddq_tmp = zeros(size(human_state_tmp.q));
        [~,~,human_ddq_tmp] = SgolayFilterAndDifferentiation( ...
            Sg.polinomialOrder, ...
            Sg.window, ...
            human_state_tmp.q, ...
            Sg.samplingTime); % in deg
        human_ddq_tmp = human_ddq_tmp * pi/180; % in rad
        save(fullfile(bucket.pathToProcessedData,'human_ddq_tmp.mat'),'human_ddq_tmp');
    else
        load(fullfile(bucket.pathToProcessedData,'human_ddq_tmp.mat'));
    end
    
    %% q, dq, ddq signals filtering (optional)
    % The signals have been downsampled to align the suit signals
    Sg.windowForFiltering = 407;
    
    if ~exist(fullfile(bucket.pathToProcessedData,'human_state_filt.mat'), 'file')
        for jntIdx = 1 : length(selectedJoints)
            [human_state_tmp_q_filt(jntIdx,:),~,~] = SgolayFilterAndDifferentiation( ...
                Sg.polinomialOrder, ...
                Sg.windowForFiltering, ...
                human_state_tmp.q(jntIdx,:), ...
                Sg.samplingTime);
            [human_state_tmp_dq_filt(jntIdx,:),~,~] = SgolayFilterAndDifferentiation( ...
                Sg.polinomialOrder, ...
                Sg.windowForFiltering, ...
                human_state_tmp.dq(jntIdx,:), ...
                Sg.samplingTime);
            [human_ddq_tmp_filt(jntIdx,:),~,~] = SgolayFilterAndDifferentiation( ...
                Sg.polinomialOrder, ...
                Sg.windowForFiltering, ...
                human_ddq_tmp(jntIdx,:), ...
                Sg.samplingTime);
        end
        human_state_filt.q   = human_state_tmp_q_filt;
        human_state_filt.dq  = human_state_tmp_dq_filt;
        human_state_filt.ddq = human_ddq_tmp_filt;
        save(fullfile(bucket.pathToProcessedData,'human_state_filt.mat'),'human_state_filt');
        % Remove useless quantities
        clearvars human_state_tmp_q_filt human_state_tmp_dq_filt human_ddq_tmp_filt;
    else
        load(fullfile(bucket.pathToProcessedData,'human_state_filt.mat'));
    end
    human_state_tmp.q  = human_state_filt.q;
    human_state_tmp.dq = human_state_filt.dq;
    human_ddq_tmp      = human_state_filt.ddq;
    
    %% Raw data handling
    rawDataHandling;
    
    %% Covariance tuning test
    if opts.tuneCovariance
        blockID = 1; % considering only one trial for covariance tuning
    else
        blockID = 1 : block.nrOfBlocks;
    end
    
    if ~opts.tuneCovariance || powerIdx == 1
        %% Save synchroData with the kinematics infos
        fieldsToBeRemoved = {
            'RightShoe_SF', ...
            'LeftShoe_SF', ...
            'FP_SF'};
        synchroKin = rmfield(synchroData,fieldsToBeRemoved);
        % Save
        if ~opts.tuneCovariance
            save(fullfile(bucket.pathToProcessedData,'synchroKin.mat'),'synchroKin');
        end
        
        %% Transform forces into human forces
        % Preliminary assumption on contact links: 2 contacts only, i.e.,
        % both the feet in the shoes
        bucket.contactLink = cell(2,1);
        
        % Define contacts configuration
        bucket.contactLink{1} = 'RightFoot'; % human link in contact with right shoe
        bucket.contactLink{2} = 'LeftFoot';  % human link in contact with left shoe
        
        for blockIdx = blockID
            shoes(blockIdx) = transformShoesWrenches(synchroData(blockIdx), subjectParamsFromData);
        end
        
        %% Shoes signal filtering
        % The signals of the shoes have been downsampled to align the suit signals
        for blockIdx = blockID
            for elemIdx = 1 : 6
                [shoes_filt(blockIdx).Left_HF(elemIdx,:),~,~] = SgolayFilterAndDifferentiation( ...
                    Sg.polinomialOrder, ...
                    Sg.window, ...
                    shoes(blockIdx).Left_HF(elemIdx,:), ...
                    Sg.samplingTime);
                [shoes_filt(blockIdx).Right_HF(elemIdx,:),~,~] = SgolayFilterAndDifferentiation( ...
                    Sg.polinomialOrder, ...
                    Sg.window, ...
                    shoes(blockIdx).Right_HF(elemIdx,:), ...
                    Sg.samplingTime);
            end
            shoes(blockIdx).Left_HF = shoes_filt(blockIdx).Left_HF;
            shoes(blockIdx).Right_HF = shoes_filt(blockIdx).Right_HF;
            % remove NaN (if any)
            shoes(blockIdx).Left_HF(isnan(shoes(blockIdx).Left_HF))=0;
            shoes(blockIdx).Right_HF(isnan(shoes(blockIdx).Right_HF))=0;
        end
        % Remove useless quantities
        clearvars shoes_filt;
        
        %% ------------------------RUNTIME PROCEDURE-------------------------------
        %% Load URDF model with sensors
        disp('-------------------------------------------------------------------');
        disp('Loading the URDF model...');
        humanModel.filename = bucket.filenameURDF;
        humanModelLoader = iDynTree.ModelLoader();
        if ~humanModelLoader.loadReducedModelFromFile(humanModel.filename, ...
                cell2iDynTreeStringVector(selectedJoints))
            % here the model loads the same order of selectedJoints.
            fprintf('Something wrong with the model loading.')
        end
        
        humanModel = humanModelLoader.model();
        human_kinDynComp = iDynTree.KinDynComputations();
        human_kinDynComp.loadRobotModel(humanModel);
        
        bucket.base = 'Pelvis'; % floating base
        
        % Sensors
        humanSensors = humanModelLoader.sensors();
        humanSensors.removeAllSensorsOfType(iDynTree.GYROSCOPE_SENSOR);
        
        %% Initialize berdy
        disp('Initializing berdy for the URDF model...');
        % Specify berdy options
        berdyOptions = iDynTree.BerdyOptions;
        
        berdyOptions.baseLink = bucket.base;
        berdyOptions.includeAllNetExternalWrenchesAsSensors          = true;
        berdyOptions.includeAllNetExternalWrenchesAsDynamicVariables = true;
        berdyOptions.includeAllJointAccelerationsAsSensors           = true;
        berdyOptions.includeAllJointTorquesAsSensors                 = false;
        berdyOptions.includeCoMAccelerometerAsSensorInTask1          = true;
        berdyOptions.includeCoMAccelerometerAsSensorInTask2          = false;
        berdyOptions.stackOfTasksMAP                                 = true;
        
        % Option useful for the new measurement equation
        %      X_{COMconstrainedLinks} * fˆx_{COMconstrainedLinks} = m * ddx_COM
        % where COMconstrainedLinks is a vector containing link names.
        COMconstrainedLinks = iDynTree.StringVector();
        COMconstrainedLinks.push_back('LeftFoot');
        COMconstrainedLinks.push_back('RightFoot');
        COMconstrainedLinks.push_back('LeftHand');
        COMconstrainedLinks.push_back('RightHand');
        berdyOptions.comConstraintLinkNamesVector = COMconstrainedLinks;
        
        berdyOptions.berdyVariant = iDynTree.BERDY_FLOATING_BASE;
        berdyOptions.includeFixedBaseExternalWrench = false;
        
        % Load berdy
        berdy = iDynTree.BerdyHelper;
        berdy.init(humanModel, humanSensors, berdyOptions);
        
        % Get the current traversal
        traversal = berdy.dynamicTraversal;
        
        % Floating base settings
        currentBase = berdy.model().getLinkName(traversal.getBaseLink().getIndex());
        disp(strcat('Current base is < ', currentBase,'>.'));
        human_kinDynComp.setFloatingBase(currentBase);
        baseKinDynModel = human_kinDynComp.getFloatingBase();
        
        % Consistency check: berdy.model base and human_kinDynComp.model have to be consistent!
        if currentBase ~= baseKinDynModel
            error(strcat('[ERROR] The berdy model base (',currentBerdyBase,') and the kinDyn model base (',baseKinDynModel,') do not match!'));
        end
        
        % The tree is visited with the same order of variables in vector d
        dVectorOrder = cell(traversal.getNrOfVisitedLinks(), 1);
        dJointOrder = cell(traversal.getNrOfVisitedLinks()-1, 1);
        for i = 0 : traversal.getNrOfVisitedLinks() - 1
            if i ~= 0
                joint  = traversal.getParentJoint(i);
                dJointOrder{i} = berdy.model().getJointName(joint.getIndex());
            end
            link = traversal.getLink(i);
            dVectorOrder{i + 1} = berdy.model().getLinkName(link.getIndex());
        end
        
        % ------------------------------------------------------------
        % OPTIONAL CHECK: print the order of variables in d vector
        % printBerdyDynVariables_floating(berdy, opts.stackOfTaskMAP);
        % ------------------------------------------------------------
        
        %% Add link angular acceleration sensors
        % iDynTree.THREE_AXIS_ANGULAR_ACCELEROMETER_SENSOR is not supported
        % by the URDF model.  To be added differently.
        
        % Angular Acceleration struct
        disp('-------------------------------------------------------------------');
        disp('[Start] Computing the link angular acceleration...');
        
        if exist(fullfile(bucket.pathToProcessedData,'angAcc_sensor.mat'), 'file')
            load(fullfile(bucket.pathToProcessedData,'angAcc_sensor.mat'));
        else
            angAcc_sensor = struct;
            for angAccSensIdx = 1 : length(suit.sensors)
                angAcc_sensor(angAccSensIdx).attachedLink = suit.sensors{angAccSensIdx, 1}.label;
                angAcc_sensor(angAccSensIdx).iDynModelIdx = humanModel.getLinkIndex(suit.links{angAccSensIdx, 1}.label);
                angAcc_sensor(angAccSensIdx).sensorName   = strcat(angAcc_sensor(angAccSensIdx).attachedLink, '_angAcc');
                
                angAcc_sensor(angAccSensIdx).S_R_L        = iDynTree.Rotation().RPY(suit.sensors{angAccSensIdx, 1}.RPY(1), ...
                    suit.sensors{angAccSensIdx, 1}.RPY(2), suit.sensors{angAccSensIdx, 1}.RPY(3)).toMatlab;
                angAcc_sensor(angAccSensIdx).pos_SwrtL    = suit.sensors{angAccSensIdx, 1}.position;
                
                for suitLinkIdx = 1 : length(suit.links)
                    if strcmp(suit.sensors{angAccSensIdx, 1}.label,suit.links{suitLinkIdx, 1}.label)
                        sampleToMatch = suitLinkIdx;
                        for lenSample = 1 : suit.properties.lenData
                            G_R_S_mat = quat2Mat(suit.sensors{angAccSensIdx, 1}.meas.sensorOrientation(:,lenSample));
                            for blockIdx = blockID
                                % ---Labels
                                angAcc_sensor(angAccSensIdx).meas(blockIdx).block  = block.labels(blockIdx);
                                % ---Cut measurements
                                tmp.cutRange{blockIdx} = (tmp.blockRange(blockIdx).first : tmp.blockRange(blockIdx).last);
                                angAcc_sensor(angAccSensIdx).meas(blockIdx).S_meas_L = G_R_S_mat' * suit.links{sampleToMatch, 1}.meas.angularAcceleration(:,tmp.cutRange{blockIdx});
                            end
                        end
                        break;
                    end
                end
            end
            % Save
            if ~opts.tuneCovariance
                save(fullfile(bucket.pathToProcessedData,'angAcc_sensor.mat'),'angAcc_sensor');
            end
        end
        
        % Create new angular accelerometer sensor in berdy sensor
        for newSensIdx = 1 : length(suit.sensors)
            humanSensors = addAccAngSensorInBerdySensors(humanSensors,angAcc_sensor(newSensIdx).sensorName, ...
                angAcc_sensor(newSensIdx).attachedLink,angAcc_sensor(newSensIdx).iDynModelIdx, ...
                angAcc_sensor(newSensIdx).S_R_L, angAcc_sensor(newSensIdx).pos_SwrtL);
        end
        disp('[End] Computing the link angular acceleration.');
        
        %% Compute the transformation of the base w.r.t. the global suit frame G
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Computing the <',currentBase,'> iDynTree transform w.r.t. the global frame G...'));
        %--------Computation of the suit base orientation and position w.r.t. G
        for suitLinksIdx = 1 : size(suit.links,1)
            if suit.links{suitLinksIdx, 1}.label == currentBase
                basePos_tot  = suit.links{suitLinksIdx, 1}.meas.position;
                baseOrientation_tot = suit.links{suitLinksIdx, 1}.meas.orientation;
                break
            end
            break
        end
        
        for blockIdx = blockID
            tmp.cutRange{blockIdx} = (tmp.blockRange(blockIdx).first : tmp.blockRange(blockIdx).last);
            bucket.basePosition(blockIdx).basePos_wrtG  = basePos_tot(:,tmp.cutRange{blockIdx});
            bucket.orientation(blockIdx).baseOrientation = baseOrientation_tot(:,tmp.cutRange{blockIdx});
        end
        clearvars basePos_tot baseOrientation_tot;
        
        for blockIdx = blockID
            G_T_base(blockIdx).block = block.labels(blockIdx);
            G_T_base(blockIdx).G_T_b = computeTransformBaseToGlobalFrame( ...
                human_kinDynComp, ...
                synchroKin(blockIdx), ...
                bucket.orientation(blockIdx).baseOrientation, ...
                bucket.basePosition(blockIdx).basePos_wrtG);
        end
        disp(strcat('[End] Computing the <',currentBase,'> iDynTree transform w.r.t. the global frame G'));
        
        %% Contact pattern definition
        % Trials are performed with both the feet attached to the ground (i.e.,
        % doubleSupport).  No single support is assumed for this analysis.
        for blockIdx = blockID
            contactPattern(blockIdx).block = block.labels(blockIdx);
            contactPattern(blockIdx).contactPattern = cell(length(synchroKin(blockIdx).masterTime),1);
            for tmpIdx = 1 : length(synchroKin(blockIdx).masterTime)
                contactPattern(blockIdx).contactPattern{tmpIdx} = 'doubleSupport';
            end
        end
        
        %% Velocity of the currentBase
        % Code to handle the info of the velocity of the base.
        % This value is mandatorily required in the floating-base formalism.
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Computing the <',currentBase,'> velocity...'));
        for blockIdx = blockID
            baseVel(blockIdx).block = block.labels(blockIdx);
            [baseVel(blockIdx).baseLinVelocity, baseVel(blockIdx).baseAngVelocity] = computeBaseVelocity( ...
                human_kinDynComp, ...
                synchroKin(blockIdx), ...
                G_T_base(blockIdx), ...
                contactPattern(blockIdx).contactPattern);
        end
        % Save
        if ~opts.tuneCovariance
            save(fullfile(bucket.pathToProcessedData,'baseVel.mat'),'baseVel');
        end
        disp(strcat('[End] Computing the <',currentBase,'> velocity'));
        
        %% Compute the rate of change of centroidal momentum w.r.t. the base
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Computing the rate of change of centroidal momentum w.r.t. the <',currentBase,'>...'));
        if ~exist(fullfile(bucket.pathToProcessedData_SOTtask1,'base_dh.mat'), 'file')
            for blockIdx = blockID
                base_dh(blockIdx).block = block.labels(blockIdx);
                tmp.baseVelocity6D = [baseVel(blockIdx).baseLinVelocity ; baseVel(blockIdx).baseAngVelocity];
                base_dh(blockIdx).base_dh = computeRateOfChangeOfCentroidalMomentumWRTbase( ...
                    human_kinDynComp, ...
                    humanModel, ...
                    synchroKin(blockIdx), ...
                    tmp.baseVelocity6D, ...
                    G_T_base(blockIdx).G_T_b);
            end
            save(fullfile(bucket.pathToProcessedData_SOTtask1,'base_dh.mat'),'base_dh');
        else
            load(fullfile(bucket.pathToProcessedData_SOTtask1,'base_dh.mat'));
        end
        disp(strcat('[End] Computing the rate of change of centroidal momentum w.r.t. the <',currentBase,'>'));
    end
end

%% EXO analysis (if)
if opts.EXO && opts.task1_SOT
    % Transform forces from the EXO into human forces
    disp('-------------------------------------------------------------------');
    disp('[Start] Transforming EXO force in human frames...');
    load(fullfile(bucket.pathToRawData,sprintf(('S%02d_%02d_rawExo.mat'),subjectID,taskID)));
    
    transformEXOforcesInHumanFrames;
    if ~opts.tuneCovariance
        save(fullfile(bucket.pathToProcessedData_EXO,'EXOfext.mat'),'EXOfext');
    end
    disp('[End] Transforming EXO force in human frames');
end

%% Measurements wrapping
disp('-------------------------------------------------------------------');
disp('[Start] Wrapping measurements...');
for blockIdx = blockID
    fext.rightHuman = shoes(blockIdx).Right_HF;
    fext.leftHuman  = shoes(blockIdx).Left_HF;
    
    data(blockIdx).block = block.labels(blockIdx);
    data(blockIdx).data  = dataPackaging( ...
        blockIdx, ...
        humanModel,...
        currentBase, ...
        humanSensors,...
        suit_runtime,...
        angAcc_sensor, ...
        fext,...
        base_dh(blockIdx).base_dh, ...
        synchroKin(blockIdx).ddq,...
        bucket.contactLink, ...
        priors, ...
        opts.stackOfTaskMAP);
    
    if opts.EXO
        % Find links where EXO forces are acting
        lenCheck = length(data(blockIdx).data);
        for idIdx = 1 : lenCheck
            if strcmp(data(1).data(idIdx).id,'Pelvis')
                tmp.pelvisIdx = idIdx;
            end
            if strcmp(data(1).data(idIdx).id,'LeftUpperArm')
                tmp.LUAIdx = idIdx;
            end
            if strcmp(data(1).data(idIdx).id,'RightUpperArm')
                tmp.RUAIdx = idIdx;
            end
        end
        % Add to data struct the EXO forces
        % 1) PELVIS
        data(blockIdx).data(tmp.pelvisIdx).meas = EXOfext(blockIdx).PELVIS;
        data(blockIdx).data(tmp.pelvisIdx).var  = priors.exo_fext;
        % 2) LUA
        data(blockIdx).data(tmp.LUAIdx).meas = EXOfext(blockIdx).LUA;
        data(blockIdx).data(tmp.LUAIdx).var  = priors.exo_fext;
        % 3) RUA
        data(blockIdx).data(tmp.RUAIdx).meas = EXOfext(blockIdx).RUA;
        data(blockIdx).data(tmp.RUAIdx).var  = priors.exo_fext;
    end
    
    if ~opts.task1_SOT % Task2
        estimatedFextFromSOTtask1 = load(fullfile(bucket.pathToProcessedData_SOTtask1,'estimatedVariables.mat'));
        for linkIdx = 1 : length(estimatedFextFromSOTtask1.estimatedVariables.Fext(blockIdx).label)
            for dataIdx = 1 : length(data)
                if strcmp(data(blockIdx).data(dataIdx).id, estimatedFextFromSOTtask1.estimatedVariables.Fext(blockIdx).label{linkIdx})
                    data(blockIdx).data(dataIdx).meas = estimatedFextFromSOTtask1.estimatedVariables.Fext(blockIdx).values(6*(linkIdx-1)+1:6*linkIdx,:);
                    break;
                end
            end
        end
    end
    
    % y vector as input for MAP
    [data(blockIdx).y, data(blockIdx).Sigmay] = berdyMeasurementsWrapping(berdy, ...
        data(blockIdx).data, ...
        opts.stackOfTaskMAP);
    
    if opts.task1_SOT
        % Modify variances for the external forces at the hands
        range_leftHand = rangeOfSensorMeasurement(berdy, iDynTree.NET_EXT_WRENCH_SENSOR, 'LeftHand',opts.stackOfTaskMAP);
        data(blockIdx).Sigmay(range_leftHand:range_leftHand+5,range_leftHand:range_leftHand+5) = diag(priors.fext_hands);
        
        range_rightHand = rangeOfSensorMeasurement(berdy, iDynTree.NET_EXT_WRENCH_SENSOR, 'RightHand',opts.stackOfTaskMAP);
        data(blockIdx).Sigmay(range_rightHand:range_rightHand+5,range_rightHand:range_rightHand+5) = diag(priors.fext_hands);
    end
end
disp('[End] Wrapping measurements');

if opts.tuneCovariance
    % Save
    if opts.task1_SOT
        save(fullfile(bucket.pathToProcessedData_SOTtask1,'data.mat'),'data');
    else
        save(fullfile(bucket.pathToProcessedData_SOTtask2,'data.mat'),'data');
    end
end

% ---------------------------------------------------
% OPTIONAL CHECK: print the order of measurement in y
% printBerdySensorOrder(berdy, opts.stackOfTaskMAP);
% ---------------------------------------------------

%% ------------------------------- MAP ------------------------------------
%% Priors
priors.mud    = zeros(berdy.getNrOfDynamicVariables(opts.stackOfTaskMAP), 1);
priors.Sigmad = bucket.Sigmad * eye(berdy.getNrOfDynamicVariables(opts.stackOfTaskMAP));
priors.SigmaD = bucket.SigmaD * eye(berdy.getNrOfDynamicEquations(opts.stackOfTaskMAP));

%% Possibility to remove a sensor from the analysis
% excluding the accelerometers and gyroscope whose removal already
% exists the iDynTree option.
sensorsToBeRemoved = [];

% Examples:
%
% bucket.temp.type = iDynTree.NET_EXT_WRENCH_SENSOR;
% bucket.temp.id = 'LeftHand';
% sensorsToBeRemoved = [sensorsToBeRemoved; bucket.temp];

%% MAP computation
for blockIdx = blockID
    priors.Sigmay = data(blockIdx).Sigmay;
    estimation(blockIdx).block = block.labels(blockIdx);
    if opts.Sigma_dgiveny
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Complete MAP computation for Block ',num2str(blockIdx),'...'));
        [estimation(blockIdx).mu_dgiveny, estimation(blockIdx).Sigma_dgiveny] = MAPcomputation_floating( ...
            berdy, ...
            traversal, ...
            synchroKin(blockIdx), ...
            data(blockIdx).y, ...
            G_T_base(blockIdx).G_T_b, ...
            priors, ...
            baseVel(blockIdx).baseAngVelocity, ...
            opts, ...
            'SENSORS_TO_REMOVE', sensorsToBeRemoved);
        disp(strcat('[End] Complete MAP computation for Block ',num2str(blockIdx)));
    else
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] mu_dgiveny MAP computation for Block ',num2str(blockIdx),'...'));
        [estimation(blockIdx).mu_dgiveny] = MAPcomputation_floating( ...
            berdy, ...
            traversal, ...
            synchroKin(blockIdx), ...
            data(blockIdx).y, ...
            G_T_base(blockIdx).G_T_b, ...
            priors, ...
            baseVel(blockIdx).baseAngVelocity, ...
            opts, ...
            'SENSORS_TO_REMOVE', sensorsToBeRemoved);
        disp(strcat('[End] mu_dgiveny MAP computation for Block ',num2str(blockIdx)));
    end
end
% Save
if opts.task1_SOT
    save(fullfile(bucket.pathToProcessedData_SOTtask1,'estimation.mat'),'estimation');
else
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'estimation.mat'),'estimation');
end

%% Variables extraction from MAP estimation
% if Task1 --> extract only fext
% if Task2 --> extract all

% fext extraction (no via Berdy)
for blockIdx = blockID
    disp('-------------------------------------------------------------------');
    disp(strcat('[Start] External force MAP extraction for Block ',num2str(blockIdx),'...'));
    estimatedVariables.Fext(blockIdx).block  = block.labels(blockIdx);
    estimatedVariables.Fext(blockIdx).label  = dVectorOrder;
    estimatedVariables.Fext(blockIdx).values = extractEstimatedFext_from_mu_dgiveny( ...
        berdy, ...
        dVectorOrder, ...
        estimation(blockIdx).mu_dgiveny, ...
        opts.stackOfTaskMAP);
    disp(strcat('[End] External force extraction for Block ',num2str(blockIdx)));
end
if opts.task1_SOT
    save(fullfile(bucket.pathToProcessedData_SOTtask1,'estimatedVariables.mat'),'estimatedVariables');
end
disp('[End] External force MAP extraction');

if ~opts.task1_SOT
    % 6D acceleration (no via Berdy)
    for blockIdx = blockID
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Acceleration MAP extraction for Block ',num2str(blockIdx),'...'));
        estimatedVariables.Acc(blockIdx).block  = block.labels(blockIdx);
        estimatedVariables.Acc(blockIdx).label  = dVectorOrder;
        estimatedVariables.Acc(blockIdx).values = extractEstimatedAcc_from_mu_dgiveny( ...
            berdy, ...
            dVectorOrder, ...
            estimation(blockIdx).mu_dgiveny, ...
            opts.stackOfTaskMAP);
        disp(strcat('[End] Acceleration MAP extraction for Block ',num2str(blockIdx)));
    end
    % torque extraction (via Berdy)
    for blockIdx = blockID
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Torque MAP extraction for Block ',num2str(blockIdx),'...'));
        estimatedVariables.tau(blockIdx).block  = block.labels(blockIdx);
        estimatedVariables.tau(blockIdx).label  = selectedJoints;
        estimatedVariables.tau(blockIdx).values = extractEstimatedTau_from_mu_dgiveny( ...
            berdy, ...
            estimation(blockIdx).mu_dgiveny, ...
            synchroKin(blockIdx).q);
        disp(strcat('[End] Torque MAP extraction for Block ',num2str(blockIdx)));
    end
    % joint acc extraction (no via Berdy)
    for blockIdx = blockID
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Joint acceleration MAP extraction for Block ',num2str(blockIdx),'...'));
        estimatedVariables.ddq(blockIdx).block  = block.labels(blockIdx);
        estimatedVariables.ddq(blockIdx).label  = selectedJoints;
        estimatedVariables.ddq(blockIdx).values = estimation(blockIdx).mu_dgiveny(...
            length(estimation(blockIdx).mu_dgiveny)-(humanModel.getNrOfDOFs-1) : size(estimation(blockIdx).mu_dgiveny,1) ,:);
        disp(strcat('[End] Joint acceleration MAP extraction for Block ',num2str(blockIdx)));
    end
    % fint extraction (no via Berdy)
    for blockIdx = blockID
        disp('-------------------------------------------------------------------');
        disp(strcat('[Start] Internal force MAP extraction for Block ',num2str(blockIdx),'...'));
        estimatedVariables.Fint(blockIdx).block  = block.labels(blockIdx);
        estimatedVariables.Fint(blockIdx).label  = selectedJoints;
        estimatedVariables.Fint(blockIdx).values = extractEstimatedFint_from_mu_dgiveny( ...
            berdy, ...
            selectedJoints, ...
            estimation(blockIdx).mu_dgiveny, ...
            opts.stackOfTaskMAP);
        disp(strcat('[End] Internal force MAP extraction for Block ',num2str(blockIdx)));
    end
    
    % save extracted viariables
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'estimatedVariables.mat'),'estimatedVariables');
end

%% Simulated y
% This section is useful to compare the measurements in the y vector and
% the results of the MAP.  NOTE: you cannot compare directly the results of
% the MAP (i.e., mu_dgiveny) with the measurements in the y vector but you
% have to pass through the y_sim and only later to compare y and y_sim.
for blockIdx = blockID
    disp('-------------------------------------------------------------------');
    disp(strcat('[Start] Simulated y computation for Block ',num2str(blockIdx),'...'));
    y_sim(blockIdx).block = block.labels(blockIdx);
    [y_sim(blockIdx).y_sim] = sim_y_floating( ...
        berdy, ...
        synchroKin(blockIdx), ...
        traversal, ...
        G_T_base(blockIdx).G_T_b, ...
        baseVel(blockIdx).baseAngVelocity, ...
        estimation(blockIdx).mu_dgiveny, ...
        opts);
    disp(strcat('[End] Simulated y computation for Block ',num2str(blockIdx)));
end
% Save
if opts.task1_SOT
    save(fullfile(bucket.pathToProcessedData_SOTtask1,'y_sim.mat'),'y_sim');
else
    save(fullfile(bucket.pathToProcessedData_SOTtask2,'y_sim.mat'),'y_sim');
end

%% Variables extraction from y_sim
extractSingleVar_from_y_sim_all;
