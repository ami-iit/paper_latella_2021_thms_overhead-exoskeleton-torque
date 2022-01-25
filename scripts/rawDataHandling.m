
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

%% Preliminaries
%--------------------------------------------------------------------------
% Xsens       frequency  --> 60  Hz, acquired with MVNX2018
% shoes       frequency  --> 100 Hz
% force plate frequency  --> 1K  Hz
% exoskeleton            --> passive
%--------------------------------------------------------------------------
% 5 repetitions of the same task (i.e.,5 blocks).
% Data in the masterFile.mat are saved in 5 separate blocks while the
% suit.mat (extracted from MVNX) does not have this division.
%--------------------------------------------------------------------------
% Legend:
% G:   global reference frame
% S:   sensor reference frame
% FS1: right ftShoe wrench
% FS2: left ftShoe wrench
% FP:  force plate

disp('-------------------------------------------------------------------');
disp('[Start] Raw data handling computation ...');

block.labels = {
    'block1'; ...
    'block2'; ...
    'block3'; ...
    'block4'; ...
    'block5'};
block.nrOfBlocks = size(block.labels,1);

%% ========================================================================
%% ============================== XSENS ===================================
%% ========================================================================
disp('        -----------------------------------------------------------');
disp('        Processing Xsens data');
%% Xsens timestamps and RT grouped by blocks
for blockIdx = 1 : block.nrOfBlocks
    masterFile.Subject.Block(blockIdx).XsensTimestamp = [];
    masterFile.Subject.Block(blockIdx).XsensTimeRT    = [];
    for trialIdx = 1 : 24
        masterFile.Subject.Block(blockIdx).XsensTimestamp = [masterFile.Subject.Block(blockIdx).XsensTimestamp; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).XSens.Timestamp];
        masterFile.Subject.Block(blockIdx).XsensTimeRT    = [masterFile.Subject.Block(blockIdx).XsensTimeRT; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).XSens.TimeRT];
    end
end

for i = 1 : length(masterFile.Subject.Block) %5 blocks
    tmp.XsensBlockRange(i).first = masterFile.Subject.Block(i).XsensTimestamp(1);
    tmp.XsensBlockRange(i).last = masterFile.Subject.Block(i).XsensTimestamp(end);
end

for i = 1 : size(suit.sensors{1, 1}.meas.sensorOrientation,2) % sensor 1 since it is equal for all the sensors
    for j = 1 : block.nrOfBlocks
        if suit.time.xSens(i) == tmp.XsensBlockRange(1,j).first
            tmp.blockRange(j).first = i;
        end
        if suit.time.xSens(i) == tmp.XsensBlockRange(1,j).last
            tmp.blockRange(j).last = i;
        end
    end
end

%% Timestamps table struct
for blockIdx = 1 : block.nrOfBlocks
    % ---Labels
    timestampTable(blockIdx).block  = block.labels(blockIdx);
    
    % ---Xsens Timestamp Range
    timestampTable(blockIdx).masterfileTimestamps = masterFile.Subject.Block(blockIdx).XsensTimestamp;
    timestampTable(blockIdx).masterfileTimeRT     = masterFile.Subject.Block(blockIdx).XsensTimeRT;

    % ---Cut MVNX in 5 blocks according to previous ranges
    timestampTable(blockIdx).XsensTimestampRange = [tmp.XsensBlockRange(blockIdx).first, tmp.XsensBlockRange(blockIdx).last];
    timestampTable(blockIdx).XsensCutRange = [tmp.blockRange(blockIdx).first, tmp.blockRange(blockIdx).last];
    tmp.cutRange = (tmp.blockRange(blockIdx).first : tmp.blockRange(blockIdx).last);
    timestampTable(blockIdx).timeMVNX = suit.time.xSens(:,tmp.cutRange);
    
    % ---Create a new sampling vector
    % NOTE: this vector will be used as sampling vector for the FP and
    % ftShoes data contained in the masterfile!
    tmp.RTblock_samples = size(timestampTable(blockIdx).timeMVNX,2);
    tmp.step = (timestampTable(blockIdx).masterfileTimeRT(end) - timestampTable(blockIdx).masterfileTimeRT(1))/(tmp.RTblock_samples -1);
    timestampTable(blockIdx).masterfileNewTimeRT = timestampTable(blockIdx).masterfileTimeRT(1) : tmp.step : timestampTable(blockIdx).masterfileTimeRT(end);
end

%% Subdivide suit.mat meas in 5 blocks accordingly to the above division
tmp.cutRange = cell(5,1);
for sensIdx = 1: size(suit.sensors,1)
    suit_runtime.sensors{sensIdx, 1}.label        = suit.sensors{sensIdx, 1}.label;
    suit_runtime.sensors{sensIdx, 1}.attachedLink = suit.sensors{sensIdx, 1}.attachedLink;
    suit_runtime.sensors{sensIdx, 1}.position     = suit.sensors{sensIdx, 1}.position;
    
    for blockIdx = 1 : block.nrOfBlocks
        % ---Labels
        suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).block  = block.labels(blockIdx);
        % ---Cut (useful) meas
        tmp.cutRange{blockIdx} = (tmp.blockRange(blockIdx).first : tmp.blockRange(blockIdx).last);
        suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorOrientation = suit.sensors{sensIdx, 1}.meas.sensorOrientation(:,tmp.cutRange{blockIdx});
        suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorFreeAcceleration = suit.sensors{sensIdx, 1}.meas.sensorFreeAcceleration(:,tmp.cutRange{blockIdx});
        % NOTE: MVNX data do not need interpolation!
    end
end

%% Transform the sensorFreeAcceleration of MVNX2018 into the oldest version
if ~exist(fullfile(bucket.pathToProcessedData,'suit_runtime.mat'), 'file')
    gravity = [0; 0; -9.81];
    for sensIdx = 1: size(suit.sensors,1)
        for blockIdx = 1 : block.nrOfBlocks
            len = size(suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorOrientation,2);
            for lenIdx = 1 : len
                G_R_S = quat2Mat(suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorOrientation(:,lenIdx));% fromQuaternion(quaternion);
                % Transformation:        S_a_old = S_R_G * (G_a_new - gravity)
                suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorOldAcceleration(:,lenIdx) = ...
                    transpose(G_R_S) * (suit_runtime.sensors{sensIdx, 1}.meas(blockIdx).sensorFreeAcceleration(:,lenIdx) - gravity);
            end
        end
    end
    save(fullfile(bucket.pathToProcessedData,'suit_runtime.mat'),'suit_runtime');
else
    load(fullfile(bucket.pathToProcessedData,'suit_runtime.mat'));
end

%% ========================================================================
%% ============================== IK data =================================
%% ========================================================================
disp('        -----------------------------------------------------------');
disp('        Processing IK data');

% Create the synchroData struct where every external is synchronized:
% - masterTime
% - ftshoes
% - state (q,dq)
% - ddq

for blockIdx = 1 : block.nrOfBlocks
    synchroData(blockIdx).block = block.labels(blockIdx);
    synchroData(blockIdx).masterTime = timestampTable(blockIdx).masterfileNewTimeRT;
    synchroData(blockIdx).q   = human_state_tmp.q(:,tmp.cutRange{blockIdx});
    synchroData(blockIdx).dq  = human_state_tmp.dq(:,tmp.cutRange{blockIdx});
    synchroData(blockIdx).ddq = human_ddq_tmp(:,tmp.cutRange{blockIdx});
end

%% ========================================================================
%% ============================== ftSHOES =================================
%% ========================================================================
disp('        -----------------------------------------------------------');
disp('        Processing ftShoes data');

%% ftShoes data grouped by blocks
for blockIdx = 1 : block.nrOfBlocks
    masterFile.Subject.Block(blockIdx).shoesTimeRT = [];
    % FS1
    tbr.masterFile.Subject.Block(blockIdx).FXR = [];
    tbr.masterFile.Subject.Block(blockIdx).FYR = [];
    tbr.masterFile.Subject.Block(blockIdx).FZR = [];
    tbr.masterFile.Subject.Block(blockIdx).MXR = [];
    tbr.masterFile.Subject.Block(blockIdx).MYR = [];
    tbr.masterFile.Subject.Block(blockIdx).MZR = [];
    % FS2
    tbr.masterFile.Subject.Block(blockIdx).FXL = [];
    tbr.masterFile.Subject.Block(blockIdx).FYL = [];
    tbr.masterFile.Subject.Block(blockIdx).FZL = [];
    tbr.masterFile.Subject.Block(blockIdx).MXL = [];
    tbr.masterFile.Subject.Block(blockIdx).MYL = [];
    tbr.masterFile.Subject.Block(blockIdx).MZL = [];
    
    for trialIdx = 1 : 24
        masterFile.Subject.Block(blockIdx).shoesTimeRT = [masterFile.Subject.Block(blockIdx).shoesTimeRT; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.TimeRT];
        % FS1
        tbr.masterFile.Subject.Block(blockIdx).FXR = [tbr.masterFile.Subject.Block(blockIdx).FXR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FXR];
        tbr.masterFile.Subject.Block(blockIdx).FYR = [tbr.masterFile.Subject.Block(blockIdx).FYR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FYR];
        tbr.masterFile.Subject.Block(blockIdx).FZR = [tbr.masterFile.Subject.Block(blockIdx).FZR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FZR];
        tbr.masterFile.Subject.Block(blockIdx).MXR = [tbr.masterFile.Subject.Block(blockIdx).MXR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MXR];
        tbr.masterFile.Subject.Block(blockIdx).MYR = [tbr.masterFile.Subject.Block(blockIdx).MYR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MYR];
        tbr.masterFile.Subject.Block(blockIdx).MZR = [tbr.masterFile.Subject.Block(blockIdx).MZR; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MZR];
        % FS2
        tbr.masterFile.Subject.Block(blockIdx).FXL = [tbr.masterFile.Subject.Block(blockIdx).FXL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FXL];
        tbr.masterFile.Subject.Block(blockIdx).FYL = [tbr.masterFile.Subject.Block(blockIdx).FYL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FYL];
        tbr.masterFile.Subject.Block(blockIdx).FZL = [tbr.masterFile.Subject.Block(blockIdx).FZL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.FZL];
        tbr.masterFile.Subject.Block(blockIdx).MXL = [tbr.masterFile.Subject.Block(blockIdx).MXL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MXL];
        tbr.masterFile.Subject.Block(blockIdx).MYL = [tbr.masterFile.Subject.Block(blockIdx).MYL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MYL];
        tbr.masterFile.Subject.Block(blockIdx).MZL = [tbr.masterFile.Subject.Block(blockIdx).MZL; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceshoe.MZL];
    end
end

for blockIdx = 1 : block.nrOfBlocks
    % FS1
    masterFile.Subject.Block(blockIdx).FS1 = [ ...
        tbr.masterFile.Subject.Block(blockIdx).FXR, ...
        tbr.masterFile.Subject.Block(blockIdx).FYR, ...
        tbr.masterFile.Subject.Block(blockIdx).FZR, ...
        tbr.masterFile.Subject.Block(blockIdx).MXR, ...
        tbr.masterFile.Subject.Block(blockIdx).MYR, ...
        tbr.masterFile.Subject.Block(blockIdx).MZR, ...
        ];
    % FS2
    masterFile.Subject.Block(blockIdx).FS2 = [ ...
        tbr.masterFile.Subject.Block(blockIdx).FXL, ...
        tbr.masterFile.Subject.Block(blockIdx).FYL, ...
        tbr.masterFile.Subject.Block(blockIdx).FZL, ...
        tbr.masterFile.Subject.Block(blockIdx).MXL, ...
        tbr.masterFile.Subject.Block(blockIdx).MYL, ...
        tbr.masterFile.Subject.Block(blockIdx).MZL, ...
        ];
end

%% ftShoes Interpolation
% Cutting signals (if needed)
for blockIdx = 1 : block.nrOfBlocks
    tmp.lengthFS = size(masterFile.Subject.Block(blockIdx).FS1,1);
    for j = 1 : tmp.lengthFS
        if (timestampTable(blockIdx).masterfileNewTimeRT(1) - masterFile.Subject.Block(blockIdx).shoesTimeRT(j) < 0.01)
            tmp.idxFS(blockIdx) = j;
            break;
        end
    end
    tmp.ftShoes.cutRange = (tmp.idxFS(blockIdx) : size(masterFile.Subject.Block(blockIdx).FS1,1));
    if tmp.ftShoes.cutRange(1) ~= 1
        tmp.ftShoes.cut(blockIdx).RightShoe = masterFile.Subject.Block(blockIdx).FS1(tmp.ftShoes.cutRange,:);
        tmp.ftShoes.cut(blockIdx).LeftShoe  = masterFile.Subject.Block(blockIdx).FS2(tmp.ftShoes.cutRange,:);
        tmp.ftShoes.cut(blockIdx).timeRT    = masterFile.Subject.Block(blockIdx).shoesTimeRT(tmp.ftShoes.cutRange,:);
    else
        tmp.ftShoes.cut(blockIdx).RightShoe = masterFile.Subject.Block(blockIdx).FS1;
        tmp.ftShoes.cut(blockIdx).LeftShoe  = masterFile.Subject.Block(blockIdx).FS2;
        tmp.ftShoes.cut(blockIdx).timeRT    = masterFile.Subject.Block(blockIdx).shoesTimeRT;
    end
end

% Interpolation
% (SF = sensor frame)
for blockIdx = 1 : block.nrOfBlocks
    for i = 1 : 6
        synchroData(blockIdx).RightShoe_SF(:,i) = interp1(tmp.ftShoes.cut(blockIdx).timeRT, ...
            tmp.ftShoes.cut(blockIdx).RightShoe(:,i), ...
            timestampTable(blockIdx).masterfileNewTimeRT);
        synchroData(blockIdx).LeftShoe_SF(:,i)  = interp1(tmp.ftShoes.cut(blockIdx).timeRT, ...
            tmp.ftShoes.cut(blockIdx).LeftShoe(:,i), ...
            timestampTable(blockIdx).masterfileNewTimeRT);
    end
end

%% ========================================================================
%% ============================ FORCE PLATE ==============================
%% ========================================================================
disp('        -------------------------------------------------------------');
disp('        Processing force plate data');
%% Force plate data grouped by blocks
for blockIdx = 1 : block.nrOfBlocks
    masterFile.Subject.Block(blockIdx).fpTimeRT = [];
    % FS1
    tbr.masterFile.Subject.Block(blockIdx).FX = [];
    tbr.masterFile.Subject.Block(blockIdx).FY = [];
    tbr.masterFile.Subject.Block(blockIdx).FZ = [];
    tbr.masterFile.Subject.Block(blockIdx).MX = [];
    tbr.masterFile.Subject.Block(blockIdx).MY = [];
    tbr.masterFile.Subject.Block(blockIdx).MZ = [];
    
    for trialIdx = 1 : 24
        masterFile.Subject.Block(blockIdx).fpTimeRT = [masterFile.Subject.Block(blockIdx).fpTimeRT; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.TimeRT];
        tbr.masterFile.Subject.Block(blockIdx).FX = [tbr.masterFile.Subject.Block(blockIdx).FX; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.FX];
        tbr.masterFile.Subject.Block(blockIdx).FY = [tbr.masterFile.Subject.Block(blockIdx).FY; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.FY];
        tbr.masterFile.Subject.Block(blockIdx).FZ = [tbr.masterFile.Subject.Block(blockIdx).FZ; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.FZ];
        tbr.masterFile.Subject.Block(blockIdx).MX = [tbr.masterFile.Subject.Block(blockIdx).MX; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.MX];
        tbr.masterFile.Subject.Block(blockIdx).MY = [tbr.masterFile.Subject.Block(blockIdx).MY; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.MY];
        tbr.masterFile.Subject.Block(blockIdx).MZ = [tbr.masterFile.Subject.Block(blockIdx).MZ; ...
            masterFile.Subject.Block(blockIdx).Trial(trialIdx).Forceplate.MZ];
    end
end

for blockIdx = 1 : block.nrOfBlocks
    masterFile.Subject.Block(blockIdx).FP = [ ...
        tbr.masterFile.Subject.Block(blockIdx).FX, ...
        tbr.masterFile.Subject.Block(blockIdx).FY, ...
        tbr.masterFile.Subject.Block(blockIdx).FZ, ...
        tbr.masterFile.Subject.Block(blockIdx).MX, ...
        tbr.masterFile.Subject.Block(blockIdx).MY, ...
        tbr.masterFile.Subject.Block(blockIdx).MZ, ...
        ];
end

%% Force plate Interpolation
% The total force is outputted as a single value.

% Cutting signals (if needed)
for blockIdx = 1 : block.nrOfBlocks
    tmp.lengthFP = size(masterFile.Subject.Block(blockIdx).FP,1);
    for j = 1 : tmp.lengthFP
        if (timestampTable(blockIdx).masterfileNewTimeRT(1) - masterFile.Subject.Block(blockIdx).fpTimeRT(j) < 0.001)
            tmp.idxFP(blockIdx) = j;
            break;
        end
    end
    tmp.fp.cutRange = (tmp.idxFP(blockIdx) : size(masterFile.Subject.Block(blockIdx).FP,1));
    if tmp.fp.cutRange(1) ~= 1
        tmp.fp.cut(blockIdx).fpTot   = masterFile.Subject.Block(blockIdx).FP(tmp.fp.cutRange,:);
        tmp.fp.cut(blockIdx).timeRT  = masterFile.Subject.Block(blockIdx).fpTimeRT(tmp.fp.cutRange,:);
    else
        tmp.fp.cut(blockIdx).fpTot   = masterFile.Subject.Block(blockIdx).FP;
        tmp.fp.cut(blockIdx).timeRT  = masterFile.Subject.Block(blockIdx).fpTimeRT;
    end
end

% Interpolation
% (SF = sensor frame)
for blockIdx = 1 : block.nrOfBlocks
    for i = 1 : 6
        synchroData(blockIdx).FP_SF(:,i) = interp1(tmp.fp.cut(blockIdx).timeRT, ...
            tmp.fp.cut(blockIdx).fpTot(:,i), ...
            timestampTable(blockIdx).masterfileNewTimeRT);
    end
end

%% ========================================================================
%% ========================================================================
%% ========================================================================
%% Cleaning up workspace
clearvars timestampTable i j sensIdx tbr human_state_tmp human_ddq_tmp;
disp('[End] Raw data handling computation.');
