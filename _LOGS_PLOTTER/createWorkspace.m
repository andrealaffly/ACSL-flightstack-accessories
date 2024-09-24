
clear
close all
clc

addpath(".\functions\");

% Date of the directory to analyze
% ------------------------------------------------------------------------------
properties.date_folder = '20240917';
% ------------------------------------------------------------------------------
% Controller name of the directory to analyze
% ------------------------------------------------------------------------------
properties.controller_folder = 'MRAC';
% ------------------------------------------------------------------------------
% Switch to control whether mocap data should be processed
% Set to true to process mocap data, false to skip
% ------------------------------------------------------------------------------
processMocap = true;  
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
properties = initializeDirectoriesAndFiles(properties, processMocap);

% Process each log file in the directory
for i = 1:length(properties.log_files)
    [log, der, mocap, gains, controller_matrices, properties] = ...
      processLogFile(properties, i, processMocap, vp);
end

% ------------------------------------------------------------------------------
% SHORT FLIGHTS (FAULTY START) DIRECTORY
% ------------------------------------------------------------------------------
handleShortFlights(properties, processMocap);

%% AUXILLARY FUNCTIONS
% ------------------------------------------------------------------------------
% AUXILLARY FUNCTIONS
% ------------------------------------------------------------------------------

function properties = initializeDirectoriesAndFiles(properties, processMocap)
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
    % List to hold mocap files with time less than 10 seconds
    properties.short_mocap_files = {};  
  end
  
  % GAINS folder
  % Path to the gains directory
  properties.gains_folder = ['../', properties.base_folder, '/gains'];
  % Get a list of all gains files in the gains folder
  properties.gains_files = dir(fullfile(properties.gains_folder, 'gains_*.json'));
  % List to hold gains files to move
  properties.short_gains_files = {};

end


function [log, der, mocap, gains, controller_matrices, properties] = ...
  processLogFile(properties, fileIndex, processMocap, vp)

    % Initialize output
    log = [];
    der = [];
    mocap = [];
    gains = [];
    controller_matrices = [];
  
    % Get the full path of the current log file
    properties.log_filename = fullfile(properties.log_files(fileIndex).folder, ...
        properties.log_files(fileIndex).name);

    if processMocap
        % Get the full path of the current mocap file
        properties.mocap_filename = fullfile(properties.mocap_files(fileIndex).folder, ...
            properties.mocap_files(fileIndex).name);
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
      otherwise
        warning('Unexpected Controller type')
    end

    % Extracting data from the current log file
    disp(['Processing log file: ', properties.log_filename]); % Debugging statement
    LogDataMatrix = readmatrix(properties.log_filename);
    if processMocap
      % Extracting data from the current mocap file
      % disp(['Processing mocap file: ', properties.mocap_filename]); % Debugging statement
      MocapDataMatrix = readmatrix(properties.mocap_filename);
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
        otherwise
          warning('Unexpected Controller type')
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
          [der, controller_matrices] = computeDerivedValues_mrac(der, log, vp, gains);
        otherwise
          warning('Unexpected Controller type')
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

    % Check if the log and mocap file have enough rows and delete the files
    % in case they don't
    if (size(LogDataMatrix, 1) < 2 || isempty(LogDataMatrix))
      deleteFileIfNoData(properties, properties.log_filename, LogDataMatrix);
      log = 0;
      der = 0;
      if (processMocap && (size(MocapDataMatrix, 1) < 2 || isempty(MocapDataMatrix)))
          deleteFileIfNoData(properties, properties.mocap_filename, MocapDataMatrix);
          mocap = 0;
      end
      return; % Skip this iteration and go to the next file
    end

    % Saving the workspace for the current log file
    save(properties.workspace_filename);

end





