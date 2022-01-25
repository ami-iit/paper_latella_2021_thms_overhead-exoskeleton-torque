
% SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
%
% SPDX-License-Identifier: BSD-3-Clause

function [osimModelTemplate] = createXsensLikeOSIMmodel(subjectParams, filename)
% CREATEXSENSLIKEOSIMMODEL generates an OSIM model of the subject. Joints of
% the OSIM model are spherical joints.  The base of the model is
% defined as floating base.
%
% Inputs :
% - subjectParams  : anthropometric parameters
% - filename       : (optional) allows to save the file.osim in a folder
%                    called 'Models'

osimModelTemplate = fileread('XSensModelStyle_48OSIMtemplate.osim');
%% -- LINK BASE
%% PELVIS (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'PELVIS_BOX_ORIGIN',num2str(subjectParams.pelvisBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'PELVIS_BOX_SIZE',num2str(subjectParams.pelvisBox));
osimModelTemplate = strrep(osimModelTemplate,'PELVIS_COM_ORIGIN',num2str(subjectParams.pelvisBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'PELVIS_BOX_SIZE',num2str(subjectParams.pelvisBox));
osimModelTemplate = strrep(osimModelTemplate,'PELVISMASS',num2str(subjectParams.pelvisMass));
osimModelTemplate = strrep(osimModelTemplate,'PELVISINERTIAIXX',num2str(subjectParams.pelvisIxx));
osimModelTemplate = strrep(osimModelTemplate,'PELVISINERTIAIYY',num2str(subjectParams.pelvisIyy));
osimModelTemplate = strrep(osimModelTemplate,'PELVISINERTIAIZZ',num2str(subjectParams.pelvisIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PHIPORIGIN',num2str(subjectParams.pHipOrigin'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTASI',num2str(subjectParams.pRightASI'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTASI',num2str(subjectParams.pLeftASI'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTCSI',num2str(subjectParams.pRightCSI'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTCSI',num2str(subjectParams.pLeftCSI'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTISCHIALTUB',num2str(subjectParams.pRightIschialTub'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTISCHIALTUB',num2str(subjectParams.pLeftIschialTub'));
osimModelTemplate = strrep(osimModelTemplate,'PSACRUM',num2str(subjectParams.pSacrum'));
%% -- CHAIN LINKS 2-7
%% L5 (solid: elliptic cylinder  )
osimModelTemplate = strrep(osimModelTemplate,'L5_BOX_ORIGIN',num2str(subjectParams.L5BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'L5_COM_ORIGIN',num2str(subjectParams.L5BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'jL5S1_ORIGIN',num2str(subjectParams.jL5S1'));
osimModelTemplate = strrep(osimModelTemplate,'L5_BOX_SIZE',num2str(subjectParams.L5Box));
osimModelTemplate = strrep(osimModelTemplate,'L5MASS',num2str(subjectParams.L5Mass));
osimModelTemplate = strrep(osimModelTemplate,'L5INERTIAIXX',num2str(subjectParams.L5Ixx));
osimModelTemplate = strrep(osimModelTemplate,'L5INERTIAIYY',num2str(subjectParams.L5Iyy));
osimModelTemplate = strrep(osimModelTemplate,'L5INERTIAIZZ',num2str(subjectParams.L5Izz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PL5SPINALPROCESS',num2str(subjectParams.pL5SpinalProcess'));
%% L3 (solid: elliptic cylinder  )
osimModelTemplate = strrep(osimModelTemplate,'L3_BOX_ORIGIN',num2str(subjectParams.L3BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'L3_COM_ORIGIN',num2str(subjectParams.L3BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'jL4L3_ORIGIN',num2str(subjectParams.jL4L3'));
osimModelTemplate = strrep(osimModelTemplate,'L3_BOX_SIZE',num2str(subjectParams.L3Box));
osimModelTemplate = strrep(osimModelTemplate,'L3MASS',num2str(subjectParams.L3Mass));
osimModelTemplate = strrep(osimModelTemplate,'L3INERTIAIXX',num2str(subjectParams.L3Ixx));
osimModelTemplate = strrep(osimModelTemplate,'L3INERTIAIYY',num2str(subjectParams.L3Iyy));
osimModelTemplate = strrep(osimModelTemplate,'L3INERTIAIZZ',num2str(subjectParams.L3Izz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PL3SPINALPROCESS',num2str(subjectParams.pL3SpinalProcess'));
%% T12 (solid: elliptic cylinder  )
osimModelTemplate = strrep(osimModelTemplate,'T12_BOX_ORIGIN',num2str(subjectParams.T12BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'T12_COM_ORIGIN',num2str(subjectParams.T12BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'jL1T12_ORIGIN',num2str(subjectParams.jL1T12'));
osimModelTemplate = strrep(osimModelTemplate,'T12_BOX_SIZE',num2str(subjectParams.T12Box));
osimModelTemplate = strrep(osimModelTemplate,'T12MASS',num2str(subjectParams.T12Mass));
osimModelTemplate = strrep(osimModelTemplate,'T12INERTIAIXX',num2str(subjectParams.T12Ixx));
osimModelTemplate = strrep(osimModelTemplate,'T12INERTIAIYY',num2str(subjectParams.T12Iyy));
osimModelTemplate = strrep(osimModelTemplate,'T12INERTIAIZZ',num2str(subjectParams.T12Izz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PT12SPINALPROCESS',num2str(subjectParams.pT12SpinalProcess'));
%% T8 (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'T8_BOX_ORIGIN',num2str(subjectParams.T8BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'T8_COM_ORIGIN',num2str(subjectParams.T8BoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'T8_BOX_SIZE',num2str(subjectParams.T8Box));
osimModelTemplate = strrep(osimModelTemplate,'jT9T8_ORIGIN',num2str(subjectParams.jT9T8'));
osimModelTemplate = strrep(osimModelTemplate,'T8MASS',num2str(subjectParams.T8Mass));
osimModelTemplate = strrep(osimModelTemplate,'T8INERTIAIXX',num2str(subjectParams.T8Ixx));
osimModelTemplate = strrep(osimModelTemplate,'T8INERTIAIYY',num2str(subjectParams.T8Iyy));
osimModelTemplate = strrep(osimModelTemplate,'T8INERTIAIZZ',num2str(subjectParams.T8Izz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PPX',num2str(subjectParams.pPX'));
osimModelTemplate = strrep(osimModelTemplate,'PIJ',num2str(subjectParams.pIJ'));
osimModelTemplate = strrep(osimModelTemplate,'PT4SPINALPROCESS',num2str(subjectParams.pT4SpinalProcess'));
osimModelTemplate = strrep(osimModelTemplate,'PT8SPINALPROCESS',num2str(subjectParams.pT8SpinalProcess'));
osimModelTemplate = strrep(osimModelTemplate,'PC7SPINALPROCESS',num2str(subjectParams.pC7SpinalProcess'));
%% NECK (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'NECK_BOX_ORIGIN',num2str(subjectParams.neckBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'NECK_COM_ORIGIN',num2str(subjectParams.neckBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'NECKHEIGHT',num2str(subjectParams.neck_z));
osimModelTemplate = strrep(osimModelTemplate,'NECKRADIUS',num2str(0.5 * subjectParams.neck_x));
osimModelTemplate = strrep(osimModelTemplate,'jT1C7_ORIGIN',num2str(subjectParams.jT1C7'));
osimModelTemplate = strrep(osimModelTemplate,'NECKMASS',num2str(subjectParams.neckMass));
osimModelTemplate = strrep(osimModelTemplate,'NECKINERTIAIXX',num2str(subjectParams.neckIxx));
osimModelTemplate = strrep(osimModelTemplate,'NECKINERTIAIYY',num2str(subjectParams.neckIyy));
osimModelTemplate = strrep(osimModelTemplate,'NECKINERTIAIZZ',num2str(subjectParams.neckIzz));
%% HEAD (solid: sphere)
osimModelTemplate = strrep(osimModelTemplate,'HEAD_COM_ORIGIN',num2str(subjectParams.neckBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'HEAD_BOX_ORIGIN',num2str(subjectParams.neckBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'jC1Head_ORIGIN',num2str(subjectParams.jC1Head'));
osimModelTemplate = strrep(osimModelTemplate,'HEADRADIUS',num2str(0.5 * subjectParams.head_z));
osimModelTemplate = strrep(osimModelTemplate,'HEADRADIAMETER',num2str(subjectParams.head_z));
osimModelTemplate = strrep(osimModelTemplate,'HEADMASS',num2str(subjectParams.headMass));
osimModelTemplate = strrep(osimModelTemplate,'HEADINERTIAIXX',num2str(subjectParams.headIxx));
osimModelTemplate = strrep(osimModelTemplate,'HEADINERTIAIYY',num2str(subjectParams.headIyy));
osimModelTemplate = strrep(osimModelTemplate,'HEADINERTIAIZZ',num2str(subjectParams.headIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PTOPOFHEAD',num2str(subjectParams.pTopOfHead'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTAURICULARIS',num2str(subjectParams.pRightAuricularis'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTAURICULARIS',num2str(subjectParams.pLeftAuricularis'));
osimModelTemplate = strrep(osimModelTemplate,'PBACKOFHEAD',num2str(subjectParams.pBackOfHead'));
%% -- CHAIN LINKS 8-11
%% RIGHT SHOULDER (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDER_BOX_ORIGIN',num2str(subjectParams.rightShoulderBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDER_COM_ORIGIN',num2str(subjectParams.rightShoulderBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERHEIGHT',num2str(subjectParams.rightSho_y));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERRADIUS',num2str(subjectParams.rightSho_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jRightC7Shoulder_ORIGIN',num2str(subjectParams.jRightT4Shoulder'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERMASS',num2str(subjectParams.rightShoulderMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERINERTIAIXX',num2str(subjectParams.rightShoulderIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERINERTIAIYY',num2str(subjectParams.rightShoulderIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTSHOULDERINERTIAIZZ',num2str(subjectParams.rightShoulderIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTACROMION',num2str(subjectParams.pRightAcromion'));
%% RIGHT UPPER ARM (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARM_BOX_ORIGIN',num2str(subjectParams.rightUpperArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARM_COM_ORIGIN',num2str(subjectParams.rightUpperArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMHEIGHT',num2str(subjectParams.rightUpperArm_y));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMRADIUS',num2str(subjectParams.rightUpperArm_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jRightShoulder_ORIGIN',num2str(subjectParams.jRightShoulder'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMMASS',num2str(subjectParams.rightUpperArmMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMINERTIAIXX',num2str(subjectParams.rightUpperArmIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMINERTIAIYY',num2str(subjectParams.rightUpperArmIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERARMINERTIAIZZ',num2str(subjectParams.rightUpperArmIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTARMLATEPICONDYLE',num2str(subjectParams.pRightArmLatEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTARMMEDEPICONDYLE',num2str(subjectParams.pRightArmMedEpicondyle'));
%% RIGHT FORE ARM (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARM_BOX_ORIGIN',num2str(subjectParams.rightForeArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARM_COM_ORIGIN',num2str(subjectParams.rightForeArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMHEIGHT',num2str(subjectParams.rightForeArm_y));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMRADIUS',num2str(subjectParams.rightForeArm_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jRightElbow_ORIGIN',num2str(subjectParams.jRightElbow'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMMASS',num2str(subjectParams.rightForeArmMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMINERTIAIXX',num2str(subjectParams.rightForeArmIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMINERTIAIYY',num2str(subjectParams.rightForeArmIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOREARMINERTIAIZZ',num2str(subjectParams.rightForeArmIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTULNARSTYLOID',num2str(subjectParams.pRightUlnarStyloid'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTRADIALSTYLOID',num2str(subjectParams.pRightRadialStyloid'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTOLECRANON',num2str(subjectParams.pRightOlecranon'));
%% RIGHT HAND (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHAND_BOX_ORIGIN',num2str(subjectParams.rightHandBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHAND_COM_ORIGIN',num2str(subjectParams.rightHandBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHAND_BOX_SIZE',num2str(subjectParams.rightHandBox));
osimModelTemplate = strrep(osimModelTemplate,'jRightWrist_ORIGIN',num2str(subjectParams.jRightWrist'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHANDMASS',num2str(subjectParams.rightHandMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHANDINERTIAIXX',num2str(subjectParams.rightHandIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHANDINERTIAIYY',num2str(subjectParams.rightHandIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTHANDINERTIAIZZ',num2str(subjectParams.rightHandIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTTOPOFHAND',num2str(subjectParams.pRightTopOfHand'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTPINKY',num2str(subjectParams.pRightPinky'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTBALLHAND',num2str(subjectParams.pRightBallHand'));
%% -- CHAIN LINKS 12-15
%% LEFT SHOULDER (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDER_BOX_ORIGIN',num2str(subjectParams.leftShoulderBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDER_COM_ORIGIN',num2str(subjectParams.leftShoulderBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERHEIGHT',num2str(subjectParams.leftSho_y));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERRADIUS',num2str(subjectParams.leftSho_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jLeftC7Shoulder_ORIGIN',num2str(subjectParams.jLeftT4Shoulder'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERMASS',num2str(subjectParams.leftShoulderMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERINERTIAIXX',num2str(subjectParams.leftShoulderIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERINERTIAIYY',num2str(subjectParams.leftShoulderIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTSHOULDERINERTIAIZZ',num2str(subjectParams.leftShoulderIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTACROMION',num2str(subjectParams.pLeftAcromion'));
%% LEFT UPPER ARM (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARM_BOX_ORIGIN',num2str(subjectParams.leftUpperArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARM_COM_ORIGIN',num2str(subjectParams.leftUpperArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMHEIGHT',num2str(subjectParams.leftUpperArm_y));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMRADIUS',num2str(subjectParams.leftUpperArm_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jLeftShoulder_ORIGIN',num2str(subjectParams.jLeftShoulder'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMMASS',num2str(subjectParams.leftUpperArmMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMINERTIAIXX',num2str(subjectParams.leftUpperArmIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMINERTIAIYY',num2str(subjectParams.leftUpperArmIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERARMINERTIAIZZ',num2str(subjectParams.leftUpperArmIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTARMLATEPICONDYLE',num2str(subjectParams.pLeftArmLatEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTARMMEDEPICONDYLE',num2str(subjectParams.pLeftArmMedEpicondyle'));
%% LEFT FORE ARM (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARM_BOX_ORIGIN',num2str(subjectParams.leftForeArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARM_COM_ORIGIN',num2str(subjectParams.leftForeArmBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMHEIGHT',num2str(subjectParams.leftForeArm_y));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMRADIUS',num2str(subjectParams.leftForeArm_z/2));
osimModelTemplate = strrep(osimModelTemplate,'jLeftElbow_ORIGIN',num2str(subjectParams.jLeftElbow'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMMASS',num2str(subjectParams.leftForeArmMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMINERTIAIXX',num2str(subjectParams.leftForeArmIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMINERTIAIYY',num2str(subjectParams.leftForeArmIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOREARMINERTIAIZZ',num2str(subjectParams.leftForeArmIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTULNARSTYLOID',num2str(subjectParams.pLeftUlnarStyloid'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTRADIALSTYLOID',num2str(subjectParams.pLeftRadialStyloid'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTOLECRANON',num2str(subjectParams.pLeftOlecranon'));
%% LEFT HAND (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'LEFTHAND_BOX_ORIGIN',num2str(subjectParams.leftHandBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHAND_COM_ORIGIN',num2str(subjectParams.leftHandBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHAND_BOX_SIZE',num2str(subjectParams.leftHandBox));
osimModelTemplate = strrep(osimModelTemplate,'jLeftWrist_ORIGIN',num2str(subjectParams.jLeftWrist'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHANDMASS',num2str(subjectParams.leftHandMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHANDINERTIAIXX',num2str(subjectParams.leftHandIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHANDINERTIAIYY',num2str(subjectParams.leftHandIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTHANDINERTIAIZZ',num2str(subjectParams.leftHandIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTTOPOFHAND',num2str(subjectParams.pLeftTopOfHand'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTPINKY',num2str(subjectParams.pLeftPinky'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTBALLHAND',num2str(subjectParams.pLeftBallHand'));
%% -- CHAIN LINKS 16-19
%% RIGHT UPPER LEG (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEG_BOX_ORIGIN',num2str(subjectParams.rightUpperLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEG_COM_ORIGIN',num2str(subjectParams.rightUpperLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGHEIGHT',num2str(subjectParams.rightUpperLeg_z));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGRADIUS',num2str(subjectParams.rightUpperLeg_x/2));
osimModelTemplate = strrep(osimModelTemplate,'jRightHip_ORIGIN',num2str(subjectParams.jRightHip'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGMASS',num2str(subjectParams.rightUpperLegMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGINERTIAIXX',num2str(subjectParams.rightUpperLegIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGINERTIAIYY',num2str(subjectParams.rightUpperLegIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTUPPERLEGINERTIAIZZ',num2str(subjectParams.rightUpperLegIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTGREATERTROCHANTER',num2str(subjectParams.pRightGreaterTrochanter'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTPATELLA',num2str(subjectParams.pRightPatella'));
%% RIGHT LOWER LEG (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEG_BOX_ORIGIN',num2str(subjectParams.rightLowerLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEG_COM_ORIGIN',num2str(subjectParams.rightLowerLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGHEIGHT',num2str(subjectParams.rightLowerLeg_z));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGRADIUS',num2str(subjectParams.rightLowerLeg_x/2));
osimModelTemplate = strrep(osimModelTemplate,'jRightKnee_ORIGIN',num2str(subjectParams.jRightKnee'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGMASS',num2str(subjectParams.rightLowerLegMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGINERTIAIXX',num2str(subjectParams.rightLowerLegIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGINERTIAIYY',num2str(subjectParams.rightLowerLegIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTLOWERLEGINERTIAIZZ',num2str(subjectParams.rightLowerLegIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTKNEELATEPICONDYLE',num2str(subjectParams.pRightKneeLatEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTKNEEMEDEPICONDYLE',num2str(subjectParams.pRightKneeMedEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTLATMALLEOLUS',num2str(subjectParams.pRightLatMalleolus'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTMEDMALLEOLUS',num2str(subjectParams.pRightMedMalleolus'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTTIBIALTUB',num2str(subjectParams.pRightTibialTub'));
%% RIGHT FOOT (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOT_BOX_ORIGIN',num2str(subjectParams.rightFootBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOT_COM_ORIGIN',num2str(subjectParams.rightFootBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOT_BOX_SIZE',num2str(subjectParams.rightFootBox));
osimModelTemplate = strrep(osimModelTemplate,'jRightAnkle_ORIGIN',num2str(subjectParams.jRightAnkle'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOTMASS',num2str(subjectParams.rightFootMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOTINERTIAIXX',num2str(subjectParams.rightFootIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOTINERTIAIYY',num2str(subjectParams.rightFootIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTFOOTINERTIAIZZ',num2str(subjectParams.rightFootIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTHEELFOOT',num2str(subjectParams.pRightHeelFoot'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTFIRSTMETATARSAL',num2str(subjectParams.pRightFirstMetatarsal'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTFIFTHMETATARSAL',num2str(subjectParams.pRightFifthMetatarsal'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTPIVOTFOOT',num2str(subjectParams.pRightPivotFoot'));
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTHEELCENTER',num2str(subjectParams.pRightHeelCenter'));
%% RIGHT TOE (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOE_BOX_ORIGIN',num2str(subjectParams.rightToeBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOE_COM_ORIGIN',num2str(subjectParams.rightToeBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOE_BOX_SIZE',num2str(subjectParams.rightToeBox));
osimModelTemplate = strrep(osimModelTemplate,'jRightBallFoot_ORIGIN',num2str(subjectParams.jRightBallFoot'));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOEMASS',num2str(subjectParams.rightToeMass));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOEINERTIAIXX',num2str(subjectParams.rightToeIxx));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOEINERTIAIYY',num2str(subjectParams.rightToeIyy));
osimModelTemplate = strrep(osimModelTemplate,'RIGHTTOEINERTIAIZZ',num2str(subjectParams.rightToeIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PRIGHTTOE',num2str(subjectParams.pRightToe'));
%% -- CHAIN LINKS 20-23
%% LEFT UPPER LEG (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEG_BOX_ORIGIN',num2str(subjectParams.leftUpperLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEG_COM_ORIGIN',num2str(subjectParams.leftUpperLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGHEIGHT',num2str(subjectParams.leftUpperLeg_z));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGRADIUS',num2str(subjectParams.leftUpperLeg_x/2));
osimModelTemplate = strrep(osimModelTemplate,'jLeftHip_ORIGIN',num2str(subjectParams.jLeftHip'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGMASS',num2str(subjectParams.leftUpperLegMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGINERTIAIXX',num2str(subjectParams.leftUpperLegIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGINERTIAIYY',num2str(subjectParams.leftUpperLegIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTUPPERLEGINERTIAIZZ',num2str(subjectParams.leftUpperLegIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTGREATERTROCHANTER',num2str(subjectParams.pLeftGreaterTrochanter'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTPATELLA',num2str(subjectParams.pLeftPatella'));
%% LEFT LOWER LEG (solid: cylinder)
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEG_BOX_ORIGIN',num2str(subjectParams.leftLowerLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEG_COM_ORIGIN',num2str(subjectParams.leftLowerLegBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGHEIGHT',num2str(subjectParams.leftLowerLeg_z));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGRADIUS',num2str(subjectParams.leftLowerLeg_x/2));
osimModelTemplate = strrep(osimModelTemplate,'jLeftKnee_ORIGIN',num2str(subjectParams.jLeftKnee'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGMASS',num2str(subjectParams.leftLowerLegMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGINERTIAIXX',num2str(subjectParams.leftLowerLegIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGINERTIAIYY',num2str(subjectParams.leftLowerLegIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTLOWERLEGINERTIAIZZ',num2str(subjectParams.leftLowerLegIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTKNEELATEPICONDYLE',num2str(subjectParams.pLeftKneeLatEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTKNEEMEDEPICONDYLE',num2str(subjectParams.pLeftKneeMedEpicondyle'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTLATMALLEOLUS',num2str(subjectParams.pLeftLatMalleolus'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTMEDMALLEOLUS',num2str(subjectParams.pLeftMedMalleolus'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTTIBIALTUB',num2str(subjectParams.pLeftTibialTub'));
%% LEFT FOOT (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOT_BOX_ORIGIN',num2str(subjectParams.leftFootBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOT_COM_ORIGIN',num2str(subjectParams.leftFootBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOT_BOX_SIZE',num2str(subjectParams.leftFootBox));
osimModelTemplate = strrep(osimModelTemplate,'jLeftAnkle_ORIGIN',num2str(subjectParams.jLeftAnkle'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOTMASS',num2str(subjectParams.leftFootMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOTINERTIAIXX',num2str(subjectParams.leftFootIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOTINERTIAIYY',num2str(subjectParams.leftFootIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTFOOTINERTIAIZZ',num2str(subjectParams.leftFootIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTHEELFOOT',num2str(subjectParams.pLeftHeelFoot'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTFIRSTMETATARSAL',num2str(subjectParams.pLeftFirstMetatarsal'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTFIFTHMETATARSAL',num2str(subjectParams.pLeftFifthMetatarsal'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTPIVOTFOOT',num2str(subjectParams.pLeftPivotFoot'));
osimModelTemplate = strrep(osimModelTemplate,'PLEFTHEELCENTER',num2str(subjectParams.pLeftHeelCenter'));
%% LEFT TOE (solid: box)
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOE_BOX_ORIGIN',num2str(subjectParams.leftToeBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOE_COM_ORIGIN',num2str(subjectParams.leftToeBoxOrigin));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOE_BOX_SIZE',num2str(subjectParams.leftToeBox));
osimModelTemplate = strrep(osimModelTemplate,'jLeftBallFoot_ORIGIN',num2str(subjectParams.jLeftBallFoot'));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOEMASS',num2str(subjectParams.leftToeMass));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOEINERTIAIXX',num2str(subjectParams.leftToeIxx));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOEINERTIAIYY',num2str(subjectParams.leftToeIyy));
osimModelTemplate = strrep(osimModelTemplate,'LEFTTOEINERTIAIZZ',num2str(subjectParams.leftToeIzz));
% Markers
osimModelTemplate = strrep(osimModelTemplate,'PLEFTTOE',num2str(subjectParams.pLeftToe'));

if nargin == 2
    [dir,~,~] = fileparts(filename);
    if ~exist(dir,'dir')
        mkdir(dir);
    end
    fileID = fopen(filename,'w');
    fprintf(fileID,'%s', osimModelTemplate);
    fclose(fileID);
end
end
