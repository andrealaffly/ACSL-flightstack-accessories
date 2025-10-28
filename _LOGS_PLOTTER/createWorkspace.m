
clear
close all
clc

% TODO create short flight folder for logs_debug

addpath(genpath(".\functions\"));

% Date of the directory to analyze
% ------------------------------------------------------------------------------
properties.date_folder = '20251020';
% ------------------------------------------------------------------------------
% Controller name of the directory to analyze
% ------------------------------------------------------------------------------
properties.controller_folder = 'FunnelTwoLayerMRAC'; 
% ------------------------------------------------------------------------------
% Switch to control whether mocap data should be processed
% Set to true to process mocap data, false to skip
% ------------------------------------------------------------------------------
processMocap = true;  
% ------------------------------------------------------------------------------
% Switch to control whether Debug log data should be processed
% Set to true to process Debug log data, false to skip
% ------------------------------------------------------------------------------
processDebug = false;  
% ------------------------------------------------------------------------------
% Set the duration in seconds to check if the log file duration
% is less than "minimum_mission_time_duration"
% ------------------------------------------------------------------------------
properties.minimum_mission_time_duration = 15; % seconds
% ------------------------------------------------------------------------------
% Set the flag to true to process only new data, set it to false to process
% all the data contained in "date_folder/controller_folder"
% ------------------------------------------------------------------------------
properties.process_only_new_data = true;
% ------------------------------------------------------------------------------

% Import vehicle properties
vp = vehicleProperties();

% Extract year and month from the date_folder
properties.year_folder = properties.date_folder(1:4);
properties.month_folder = properties.date_folder(5:6);

% Initialize directories and file lists
properties = initializeDirectoriesAndFiles(properties, processMocap, processDebug);

% Process each log file in the directory
for i = 1:length(properties.log_files)
    [log, der, mocap, gains, controller_matrices, info, properties] = ...
      processLogFile(properties, i, processMocap, processDebug, vp);
end

% ------------------------------------------------------------------------------
% SHORT FLIGHTS (FAULTY START) DIRECTORY
% ------------------------------------------------------------------------------
handleShortFlights(properties, processMocap);

disp('[INFO] DONE processing data!');

%% AUXILLARY FUNCTIONS
% ------------------------------------------------------------------------------
% AUXILLARY FUNCTIONS
% ------------------------------------------------------------------------------

function properties = initializeDirectoriesAndFiles(properties, ...
                                                    processMocap, ...
                                                    processDebug)
  % Create base folder
  properties.base_folder = [properties.year_folder, '/', ...
                            properties.month_folder, '/', ...
                            properties.date_folder, '/', ...
                            properties.controller_folder]; 
  % Path to the logs directory
  properties.logs_folder = ['../', properties.base_folder, '/logs']; 
  % Get a list of all .log files in the logs folder
  properties.log_files = dir(fullfile(properties.logs_folder, '*.log'));
  % List to hold log files with time less than X seconds
  properties.short_log_files = {};  
  % Ensure there is at least a log file in the directory
  if isempty(properties.log_files)
      error('There are no log files in the log directory');
  end

  if processMocap
    % Path to the mocap directory
    properties.mocap_folder = ['../', properties.base_folder, '/mocap']; 
    % Get a list of all .log files in the mocap folder
    properties.mocap_files = dir(fullfile(properties.mocap_folder, '*.log'));
    % Ensure that the number of log files and mocap files are the same
    if length(properties.log_files) ~= length(properties.mocap_files)
        error('The number of log files and mocap files does not match.');
    end
    % List to hold mocap files with time less than 
    % properties.minimum_mission_time_duration seconds
    properties.short_mocap_files = {};  
  end

  if processDebug
    % Path to the logs_debug directory
    properties.debug_folder = ['../', properties.base_folder, '/logs_debug']; 
    % Get a list of all .log files in the logs_debug folder
    properties.debug_files = dir(fullfile(properties.debug_folder, '*.log'));
    % Ensure that the number of log files and debug files are the same
    if length(properties.log_files) ~= length(properties.debug_files)
        error('The number of log files and logs_debug files does not match.');
    end
    % List to hold logs_debug files with time less than 
    % properties.minimum_mission_time_duration seconds
    properties.short_debug_files = {};  
  end
  
  % GAINS folder
  % Path to the gains directory
  properties.gains_folder = ['../', properties.base_folder, '/gains'];
  % Get a list of all gains files in the gains folder
  properties.gains_files = dir(fullfile(properties.gains_folder, 'gains_*.json'));
  % List to hold gains files to move
  properties.short_gains_files = {};

  
  switch properties.controller_folder
      case 'FunnelTwoLayerMRAC'
          % DER_GAINS folder
          % Path to the der_gains directory
          properties.der_gains_folder = ['../', properties.base_folder, '/der_gains'];
          % Get a list of all der_gains files in the der_gains folder
          properties.der_gains_files = dir(fullfile(properties.der_gains_folder, 'der_gains_*.json'));
          % List to hold der_gains files to move
          properties.short_der_gains_files = {};

          % INFO folder
          % Path to the info directory
          properties.info_folder = ['../', properties.base_folder, '/info'];
          properties.git_info_folder = fullfile(properties.info_folder, 'git_info');
          properties.safe_mech_folder = fullfile(properties.info_folder, 'safe_mech');
          properties.low_pass_filter_folder = ... 
            fullfile(properties.info_folder, 'low_pass_filter');
          % Get a list of all files in the folder
          properties.git_info_files = dir(fullfile(properties.git_info_folder, 'git_info_*.json'));
          properties.safe_mech_files = dir(fullfile(properties.safe_mech_folder, 'safe_mech_*.json'));
          properties.low_pass_filter_files = ...
            dir(fullfile(properties.low_pass_filter_folder, 'low_pass_filter_*.json'));
          % List to hold short files to move
          properties.short_git_info_files = {};
          properties.short_safe_mech_files = {};
          properties.short_low_pass_filter_files = {};
      otherwise
        warning('[initializeDirectoriesAndFiles]: Unexpected Controller type')

  end

end


function [log, der, mocap, gains, controller_matrices, info, properties] = ...
  processLogFile(properties, fileIndex, processMocap, processDebug, vp)

    % Initialize output
    log = [];
    der = [];
    mocap = [];
    gains = [];
    controller_matrices = [];
    info = [];
  
    % Get the full path of the current log file
    properties.log_filename = fullfile(properties.log_files(fileIndex).folder, ...
        properties.log_files(fileIndex).name);

    if processMocap
        % Get the full path of the current mocap file
        properties.mocap_filename = fullfile(properties.mocap_files(fileIndex).folder, ...
            properties.mocap_files(fileIndex).name);
    end

    if processDebug
        % Get the full path of the current log_debug file
        properties.debug_filename = fullfile(properties.debug_files(fileIndex).folder, ...
            properties.debug_files(fileIndex).name);
    end

    % Extract the base name from the filename
    [properties.log_filename_folder, properties.log_filename_name, ~] = ...
        fileparts(properties.log_filename);
    % Find the parent folder
    properties.parent_folder = fileparts(properties.log_filename_folder);
    % Extract the specific date from the parent folder (e.g., '20240429')
    [~, properties.parent_folder_name] = fileparts(properties.parent_folder);
    % Extract the timestamp portion from the log filename
    properties.timestamp = regexp(properties.log_filename_name, ...
                                  '\d{8}_\d{6}', 'match', 'once');
    % Define the directory for saving the workspace,
    % based on the parent folder
    properties.save_directory = fullfile(properties.parent_folder, ...
                                         'workspaces'); 
    % Create the full path for the new workspace file
    properties.workspace_filename = fullfile(...
        properties.save_directory,...
        sprintf('workspace_log_%s.mat', properties.timestamp));

    % Ensure the save directory exists
    createDirectoryIfNotExists(properties.save_directory)

    % Check if the workspace already exists and skip processing if the flag is set
    if properties.process_only_new_data && isfile(properties.workspace_filename)
        disp(['Workspace already exists for: ', properties.workspace_filename]);
        return; % Skip processing this file
    end

    % Get the full path of the current gains JSON file
    switch properties.controller_folder
      case 'PID'

      case 'MRAC'
        properties.gains_filename = fullfile(properties.gains_folder, ...
          ['gains_mrac_', properties.timestamp, '.json']);
        % disp(['Matching gains file: ', properties.gains_filename]);
      case 'TwoLayerMRAC'
        properties.gains_filename = fullfile(properties.gains_folder, ...
          ['gains_two_layer_mrac_', properties.timestamp, '.json']);
      case 'FunnelTwoLayerMRAC'
        properties.gains_filename = fullfile(properties.gains_folder, ...
          ['gains_', properties.timestamp, '.json']);
        properties.der_gains_filename = fullfile(properties.der_gains_folder, ...
          ['der_gains_', properties.timestamp, '.json']);
        properties.git_info_filename = fullfile(properties.git_info_folder, ...
          ['git_info_', properties.timestamp, '.json']);
        properties.safe_mech_filename = fullfile(properties.safe_mech_folder, ...
          ['safe_mech_', properties.timestamp, '.json']);
        properties.low_pass_filter_filename = fullfile(properties.low_pass_filter_folder, ...
          ['low_pass_filter_', properties.timestamp, '.json']);
      otherwise
        warning('[processLogFile]: Unexpected Controller type')
    end

    % Extracting data from the current log file
    disp(['Processing log file: ', properties.log_filename]); % Debugging statement
    LogDataMatrix = readmatrix(properties.log_filename);
    if processMocap
      % Extracting data from the current mocap file
      % disp(['Processing mocap file: ', properties.mocap_filename]); % Debugging statement
      MocapDataMatrix = readmatrix(properties.mocap_filename);
    end

    if processDebug
      % Extracting data from the current log_debug file
      % disp(['Processing log_debug file: ', properties.debug_filename]); % Debugging statement
      DebugDataMatrix = readmatrix(properties.debug_filename);
    end

    %----------------------------------------------------------------------
    % LOGGED VALUES
    if ~isempty(LogDataMatrix)
      switch properties.controller_folder
        case 'PID'
          log = getLogData_PID(LogDataMatrix);
        case 'MRAC'
          log = getLogData_MRAC(LogDataMatrix);
          gains = importGains_MRAC(properties.gains_filename);
        case 'TwoLayerMRAC'
          log = getLogData_TLMRAC(LogDataMatrix);
          gains = importGains_TLMRAC(properties.gains_filename);
        % case 'FunnelTwoLayerMRAC'
        %   log = getLogData_FunTLMRAC(LogDataMatrix);
        %   gains = importGains_MRAC(properties.gains_filename);
        %   gains.DER = importDerGains(properties.der_gains_filename);
        %   info.git_info = jsondecode(fileread(properties.git_info_filename));
        %   info.safe_mech = jsondecode(fileread(properties.safe_mech_filename));
        %   info.low_pass_filter = jsondecode(fileread(properties.low_pass_filter_filename));
        case 'FunnelTwoLayerMRAC'
          log = getLogData_FunTLMRAC(LogDataMatrix);
          gains = importGains_MRAC(properties.gains_filename);
          gains.DER = importDerGains(properties.der_gains_filename);
        
          % --- Safe JSON reads with warnings if missing ---
          info = struct(); % initialize to avoid "unassigned" issues
        
          if isfile(properties.git_info_filename)
            info.git_info = jsondecode(fileread(properties.git_info_filename));
          else
            warning('processLogFile:MissingGitInfo', ...
              'Git info file not found: %s. Continuing without git_info.', ...
              properties.git_info_filename);
            info.git_info = struct(); % fallback empty struct
          end
        
          if isfile(properties.safe_mech_filename)
            info.safe_mech = jsondecode(fileread(properties.safe_mech_filename));
          else
            warning('processLogFile:MissingSafeMech', ...
              'Safe mechanism file not found: %s. Continuing without safe_mech.', ...
              properties.safe_mech_filename);
            info.safe_mech = struct();
          end
        
          if isfile(properties.low_pass_filter_filename)
            info.low_pass_filter = jsondecode(fileread(properties.low_pass_filter_filename));
          else
            warning('processLogFile:MissingLowPassFilter', ...
              'Low-pass filter file not found: %s. Continuing without low_pass_filter.', ...
              properties.low_pass_filter_filename);
            info.low_pass_filter = struct();
          end
        otherwise
          warning('[processLogFile]: Unexpected Controller type')
      end
     
      %----------------------------------------------------------------------
  
      % CHECK ON TIME DURATION
      % Check if the log file duration is less than "minimum_mission_time_duration"
      if max(log.time) < properties.minimum_mission_time_duration
          properties.short_log_files{end+1} = properties.log_filename; %#ok<*SAGROW>
      end
  
      % % DERIVED/COMPUTED VALUES
      % der = computeDerivedValues(log, vp);
      % DERIVED/COMPUTED VALUES
      switch properties.controller_folder
        case 'PID'
          der = computeDerivedValues(log, vp);
        case 'MRAC'
          der = computeDerivedValues(log, vp);
          [der, controller_matrices] = computeDerivedValues_MRAC(der, log, vp, gains);
        case 'TwoLayerMRAC'
          der = computeDerivedValues(log, vp);
          [der, controller_matrices] = computeDerivedValues_TLMRAC(der, log, vp, gains);
          case 'FunnelTwoLayerMRAC'
          der = computeDerivedValues(log, vp);
          der = computeDerivedValues_FunTLMRAC(der, log, vp, gains);
        otherwise
          warning('[processLogFile]: Unexpected Controller type')
      end
    end

    if processMocap
      if ~isempty(MocapDataMatrix)
        %----------------------------------------------------------------------
        % MOCAP VALUES
        mocap = getMocapData(MocapDataMatrix);
        %----------------------------------------------------------------------
        % CHECK ON TIME DURATION
        % Check if the mocap file duration is less than "properties.minimum_mission_time_duration"
        if max(mocap.time) < properties.minimum_mission_time_duration
            properties.short_mocap_files{end+1} = properties.mocap_filename;
        end
      end
    end

    if processDebug
      if ~isempty(DebugDataMatrix)
        %----------------------------------------------------------------------
        % MOCAP VALUES
        log.debug = getDebugData(DebugDataMatrix);
        %----------------------------------------------------------------------
        % CHECK ON TIME DURATION
        % Check if the log_debug file duration is less than "properties.minimum_mission_time_duration"
        if max(log.debug.time) < properties.minimum_mission_time_duration
            properties.short_debug_files{end+1} = properties.debug_filename;
        end
      end
    end

    % Check if the log, mocap, and log_debug file have enough rows and delete the files
    % in case they don't
    if (size(LogDataMatrix, 1) < 2 || isempty(LogDataMatrix))
      deleteFileIfNoData(properties, properties.log_filename, LogDataMatrix);
      log = 0;
      der = 0;
      if (processMocap && (size(MocapDataMatrix, 1) < 2 || isempty(MocapDataMatrix)))
          deleteFileIfNoData(properties, properties.mocap_filename, MocapDataMatrix);
          mocap = 0;
      end
      if (processDebug && (size(DebugDataMatrix, 1) < 2 || isempty(DebugDataMatrix)))
          deleteFileIfNoData(properties, properties.debug_filename, DebugDataMatrix);
          log.debug = 0;
      end
      return; % Skip this iteration and go to the next file
    end

    switch properties.controller_folder
      case 'FunnelTwoLayerMRAC'
          % CHECK ON TIME DURATION
          if max(log.time) < properties.minimum_mission_time_duration
              properties.short_der_gains_files{end+1} = properties.der_gains_filename;
              properties.short_git_info_files{end+1} = properties.git_info_filename;
              properties.short_safe_mech_files{end+1} = properties.safe_mech_filename;
              properties.short_low_pass_filter_files{end+1} = properties.low_pass_filter_filename;
          end
      otherwise
          warning('[processLogFile]: Unexpected Controller type')
    end

    % Saving the workspace for the current log file
    save(properties.workspace_filename);

end





