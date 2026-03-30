clear
close all
clc

% =========================================================================
% CONFIG
% =========================================================================

addpath(genpath(".\functions\"));

properties.date_folder = '20260325';
properties.controller_folder = 'HybridTwoLayerMRAC';

processMocap = true;
processDebug = false;

properties.minimum_mission_time_duration = 15; % seconds
properties.process_only_new_data = true;

% =========================================================================
% LOAD VEHICLE PROPERTIES
% =========================================================================

vp = vehicleProperties();

properties.year_folder  = properties.date_folder(1:4);
properties.month_folder = properties.date_folder(5:6);

properties.controller_config = ...
    getControllerConfig(properties.controller_folder);

properties = initializeDirectoriesAndFiles(properties,processMocap,processDebug);

% =========================================================================
% PROCESS LOG FILES
% =========================================================================

for i = 1:length(properties.log_files)

    [log,der,mocap,gains,controller_matrices,info,properties] = ...
        processLogFile(properties,i,processMocap,processDebug,vp);

end

handleShortFlights(properties,processMocap);

disp('[INFO] DONE processing data!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DIRECTORY INITIALIZATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function properties = initializeDirectoriesAndFiles(properties,processMocap,processDebug)

config = properties.controller_config;

properties.base_folder = fullfile( ...
    properties.year_folder,...
    properties.month_folder,...
    properties.date_folder,...
    properties.controller_folder);

properties.parent_folder = fullfile('..',properties.base_folder);

% -------------------------------------------------------------------------
% Logs
% -------------------------------------------------------------------------

properties.logs_folder = fullfile(properties.parent_folder,'logs');
properties.log_files   = dir(fullfile(properties.logs_folder,'*.log'));
properties.short_log_files = {};

if isempty(properties.log_files)
    error('No log files found.');
end

% -------------------------------------------------------------------------
% Mocap
% -------------------------------------------------------------------------

if processMocap
    properties.mocap_folder = fullfile(properties.parent_folder,'mocap');
    properties.mocap_files  = dir(fullfile(properties.mocap_folder,'*.log'));
    properties.short_mocap_files = {};
end

% -------------------------------------------------------------------------
% Debug
% -------------------------------------------------------------------------

if processDebug
    properties.debug_folder = fullfile(properties.parent_folder,'logs_debug');
    properties.debug_files  = dir(fullfile(properties.debug_folder,'*.log'));
    properties.short_debug_files = {};
end

% -------------------------------------------------------------------------
% Gains
% -------------------------------------------------------------------------

properties.gains_folder = fullfile(properties.parent_folder,'gains');
properties.gains_files  = dir(fullfile(properties.gains_folder,'gains_*.json'));
properties.short_gains_files = {};

if isfield(config,'hasDerGains') && config.hasDerGains
    properties.der_gains_folder = fullfile(properties.parent_folder,'der_gains');
    properties.der_gains_files  = dir(fullfile(properties.der_gains_folder,'der_gains_*.json'));
    properties.short_der_gains_files = {};
end

if isfield(config,'hasInfo') && config.hasInfo
    properties.info_folder = fullfile(properties.parent_folder,'info');

    for k = 1:numel(config.infoFolders)

        folderName = config.infoFolders{k};
        folderPath  = fullfile(properties.info_folder,folderName);

        properties.(sprintf('%s_folder',folderName)) = folderPath;

        properties.(sprintf('%s_files',folderName)) = ...
            dir(fullfile(folderPath,sprintf('%s_*.json',folderName)));

        properties.(sprintf('short_%s_files',folderName)) = {};
    end
end

% -------------------------------------------------------------------------
% Short Flights Directory
% -------------------------------------------------------------------------

properties.short_flights_directory = ...
    fullfile(properties.parent_folder,'short_flights');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROCESS LOG FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [log,der,mocap,gains,controller_matrices,info,properties] = ...
    processLogFile(properties,fileIndex,processMocap,processDebug,vp)

config = properties.controller_config;

log = [];
der = [];
mocap = [];
gains = [];
controller_matrices = [];
info = struct();

% -------------------------------------------------------------------------
% File paths
% -------------------------------------------------------------------------

properties.log_filename = fullfile( ...
    properties.log_files(fileIndex).folder,...
    properties.log_files(fileIndex).name);

if processMocap
    properties.mocap_filename = fullfile( ...
        properties.mocap_files(fileIndex).folder,...
        properties.mocap_files(fileIndex).name);
end

if processDebug
    properties.debug_filename = fullfile( ...
        properties.debug_files(fileIndex).folder,...
        properties.debug_files(fileIndex).name);
end

% -------------------------------------------------------------------------
% Timestamp
% -------------------------------------------------------------------------

[~,name,~] = fileparts(properties.log_filename);
properties.timestamp = regexp(name,'\d{8}_\d{6}','match','once');

properties.save_directory = fullfile( ...
    fileparts(properties.log_files(fileIndex).folder),'workspaces');

createDirectoryIfNotExists(properties.save_directory)

properties.workspace_filename = fullfile( ...
    properties.save_directory,...
    sprintf('workspace_log_%s.mat',properties.timestamp));

% -------------------------------------------------------------------------
% LOGGING (WORKSPACE + CONTROLLER + DATE + TIME)
% -------------------------------------------------------------------------

fprintf('\n------------------------------------------------------------\n');
fprintf('[INFO] Processing workspace file\n');

[~,wsName,~] = fileparts(properties.workspace_filename);

tokens = regexp(wsName,'workspace_log_(\d{8})_(\d{6})','tokens','once');

if ~isempty(tokens)
    datePart = tokens{1};
    timePart = tokens{2};
else
    datePart = 'unknown';
    timePart = 'unknown';
end

fprintf('[INFO] Controller: %s\n',properties.controller_folder);
fprintf('[INFO] Date     : %s\n',datePart);
fprintf('[INFO] Time     : %s\n',timePart);
fprintf('------------------------------------------------------------\n');

% Skip if workspace exists
if properties.process_only_new_data && isfile(properties.workspace_filename)

    fprintf('[INFO] Workspace already exists (skipping): %s\n\n', ...
        properties.workspace_filename);

    return;
end

% -------------------------------------------------------------------------
% Build Gains Filename
% -------------------------------------------------------------------------

properties.gains_filename = fullfile( ...
    properties.gains_folder,...
    sprintf(config.gainPattern,properties.timestamp));

if config.hasDerGains
    properties.der_gains_filename = fullfile( ...
        properties.der_gains_folder,...
        sprintf('der_gains_%s.json',properties.timestamp));
end

% -------------------------------------------------------------------------
% Load Data
% -------------------------------------------------------------------------

LogDataMatrix = readmatrix(properties.log_filename);

if processMocap
    MocapDataMatrix = readmatrix(properties.mocap_filename);
end

if processDebug
    DebugDataMatrix = readmatrix(properties.debug_filename);
end

% -------------------------------------------------------------------------
% LOG PROCESSING
% -------------------------------------------------------------------------

if ~isempty(LogDataMatrix)

    logParser    = config.logParser;
    gainImporter  = config.gainImporter;
    derivFunction = config.derivativeFunction;

    log   = logParser(LogDataMatrix);
    gains = gainImporter(properties.gains_filename);

    if config.hasDerGains
        gains.DER = importDerGains(properties.der_gains_filename);
    end

    der = computeDerivedValues(log,vp);

    if ~isempty(derivFunction)
        nOut = nargout(derivFunction);
        if nOut == 2
            [der,controller_matrices] = derivFunction(der,log,vp,gains);
        elseif nOut == 1
            der = derivFunction(der,log,vp,gains);
            controller_matrices = [];
        else
            error('Unexpected number of outputs from derivative function.');
        end
    end

    if max(log.time) < properties.minimum_mission_time_duration
        properties.short_log_files{end+1} = properties.log_filename;
    end
end

% -------------------------------------------------------------------------
% MOCAP
% -------------------------------------------------------------------------

if processMocap && ~isempty(MocapDataMatrix)

    mocap = getMocapData(MocapDataMatrix);

    if max(mocap.time) < properties.minimum_mission_time_duration
        properties.short_mocap_files{end+1} = properties.mocap_filename;
    end
end

% -------------------------------------------------------------------------
% DEBUG
% -------------------------------------------------------------------------

if processDebug && ~isempty(DebugDataMatrix)

    log.debug = getDebugData(DebugDataMatrix);

    if max(log.debug.time) < properties.minimum_mission_time_duration
        properties.short_debug_files{end+1} = properties.debug_filename;
    end
end

save(properties.workspace_filename);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTROLLER CONFIG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function config = getControllerConfig(controllerName)

switch controllerName

    case 'PID'
        config.gainPattern = 'gains_%s.json';
        config.hasDerGains = false;
        config.hasInfo = false;
        config.logParser = @getLogData_PID;
        config.gainImporter = @(file) struct();
        config.derivativeFunction = [];

    case 'MRAC'
        config.gainPattern = 'gains_mrac_%s.json';
        config.hasDerGains = false;
        config.hasInfo = false;
        config.logParser = @getLogData_MRAC;
        config.gainImporter = @importGains_MRAC;
        config.derivativeFunction = @computeDerivedValues_MRAC;

    case 'TwoLayerMRAC'
        config.gainPattern = 'gains_two_layer_mrac_%s.json';
        config.hasDerGains = false;
        config.hasInfo = false;
        config.logParser = @getLogData_TLMRAC;
        config.gainImporter = @importGains_TLMRAC;
        config.derivativeFunction = @computeDerivedValues_TLMRAC;

    case 'FunnelTwoLayerMRAC'
        config.gainPattern = 'gains_%s.json';
        config.hasDerGains = true;
        config.hasInfo = true;
        config.infoFolders = {'git_info','safe_mech','low_pass_filter'};
        config.logParser = @getLogData_FunTLMRAC;
        config.gainImporter = @importGains_MRAC;
        config.derivativeFunction = @computeDerivedValues_FunTLMRAC;
    
    case 'HybridTwoLayerMRAC'
        config.gainPattern = 'gains_%s.json';
        config.hasDerGains = true;
        config.hasInfo = true;
        config.infoFolders = {'git_info','safe_mech','low_pass_filter'};
        config.logParser = @getLogData_HybTLMRAC;
        config.gainImporter = @importGains_MRAC;
        config.derivativeFunction = @computeDerivedValues_HybTLMRAC;

    otherwise
        error('Unknown controller type: %s',controllerName);
end

end