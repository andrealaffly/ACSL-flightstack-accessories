function handleShortFlights(properties, processMocap)
%HANDLESHORTFLIGHTS Move short flights that are not meaningful to a
%different directory

  % Define the directory for short flights
  properties.short_flights_directory = fullfile(properties.parent_folder, 'short_flights');
  
  % Define subdirectories
  properties.short_flights_logs_directory = fullfile(properties.short_flights_directory, 'logs');
  properties.short_flights_mocap_directory = fullfile(properties.short_flights_directory, 'mocap');
  properties.short_flights_gains_directory = fullfile(properties.short_flights_directory, 'gains');
  properties.short_flights_der_gains_directory = fullfile(properties.short_flights_directory, 'der_gains');
  properties.short_flights_git_info_directory = fullfile(properties.short_flights_directory, 'info/git_info');
  properties.short_flights_safe_mech_directory = fullfile(properties.short_flights_directory, 'info/safe_mech');
  properties.short_flights_workspaces_directory = fullfile(properties.short_flights_directory, 'workspaces');
  
  % Ensure the short flights subdirectories exist
  % Ensure the short flights subdirectories exist
  dirs = {properties.short_flights_logs_directory, ...
          properties.short_flights_mocap_directory, ...
          properties.short_flights_gains_directory, ...
          properties.short_flights_der_gains_directory, ...
          properties.short_flights_git_info_directory, ...
          properties.short_flights_safe_mech_directory, ...
          properties.short_flights_workspaces_directory};
  cellfun(@createDirectoryIfNotExists, dirs);

  % createDirectoryIfNotExists(properties.short_flights_logs_directory);
  % createDirectoryIfNotExists(properties.short_flights_mocap_directory);
  % createDirectoryIfNotExists(properties.short_flights_gains_directory);
  % createDirectoryIfNotExists(properties.short_flights_workspaces_directory);

  % Move the short log files
  moveFiles(properties.short_log_files, properties.short_flights_logs_directory);
  
  % Move the short mocap files, if processing mocap data
  if processMocap
    moveFiles(properties.short_mocap_files, properties.short_flights_mocap_directory);
  end
  
  % % Move the respective gains files based on the timestamps of the short log files
  % moveGainsAndWorkspaceFiles(properties, 'gains_*_%s.json');

  % Move gains, workspace, der_gains, and info files
  moveAllAssociatedFiles(properties);

end

% Auxillary functions
% ------------------------------------------------------------------------------

function moveFiles(files, destinationDirectory)
  for i = 1:length(files)
    [~, filename, ext] = fileparts(files{i});
    movefile(files{i}, fullfile(destinationDirectory, [filename, ext]));
  end
end

% function moveGainsAndWorkspaceFiles(properties, gainsPattern)
%   for i = 1:length(properties.short_log_files)
%     [~, short_log_filename, ~] = fileparts(properties.short_log_files{i});
%     timestamp = regexp(short_log_filename, '\d{8}_\d{6}', 'match', 'once');
% 
%     if ~isempty(timestamp)
%       % Find the matching gains files
%       gains_files = dir(fullfile(properties.gains_folder, sprintf(gainsPattern, timestamp)));
% 
%       for j = 1:length(gains_files)
%         movefile(fullfile(properties.gains_folder, gains_files(j).name), ...
%             fullfile(properties.short_flights_gains_directory, gains_files(j).name));
%       end
% 
%       % Find the matching workspace file
%       workspace_file = fullfile(properties.save_directory, ...
%           sprintf('workspace_log_%s.mat', timestamp));
% 
%       if exist(workspace_file, 'file')
%         movefile(workspace_file, ...
%             fullfile(properties.short_flights_workspaces_directory, ...
%             sprintf('workspace_log_%s.mat', timestamp)));
%       end
%     end
%   end
% end

function moveAllAssociatedFiles(properties)
  for i = 1:length(properties.short_log_files)
    [~, short_log_filename, ~] = fileparts(properties.short_log_files{i});
    timestamp = regexp(short_log_filename, '\d{8}_\d{6}', 'match', 'once');

    if ~isempty(timestamp)
      % === Gains ===
      moveMatchingFiles(properties.gains_folder, ...
          sprintf('gains_%s.json', timestamp), ...
          properties.short_flights_gains_directory);

      % === DER Gains ===
      if isfield(properties, 'der_gains_folder')
        moveMatchingFiles(properties.der_gains_folder, ...
            sprintf('der_gains_%s.json', timestamp), ...
            properties.short_flights_der_gains_directory);
      end

      % === Git Info ===
      if isfield(properties, 'git_info_folder')
        moveMatchingFiles(properties.git_info_folder, ...
            sprintf('git_info_%s.json', timestamp), ...
            properties.short_flights_git_info_directory);
      end

      % === Safe Mech ===
      if isfield(properties, 'safe_mech_folder')
        moveMatchingFiles(properties.safe_mech_folder, ...
            sprintf('safe_mech_%s.json', timestamp), ...
            properties.short_flights_safe_mech_directory);
      end

      % === Workspace ===
      workspace_file = fullfile(properties.save_directory, ...
          sprintf('workspace_log_%s.mat', timestamp));
      if isfile(workspace_file)
        movefile(workspace_file, ...
          fullfile(properties.short_flights_workspaces_directory, ...
            sprintf('workspace_log_%s.mat', timestamp)));
      end
    end
  end
end

function moveMatchingFiles(src_folder, filename_pattern, dst_folder)
  full_path = fullfile(src_folder, filename_pattern);
  matching_files = dir(full_path);
  for k = 1:length(matching_files)
    movefile(fullfile(src_folder, matching_files(k).name), ...
             fullfile(dst_folder, matching_files(k).name));
  end
end


