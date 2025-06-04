function workspaces = loadSortedWorkspacesByField(dir_path, field_path)
%LOADSORTEDWORKSPACESBYFIELD Loads and sorts workspace .mat files
%   Sorts files by a specified nested field (e.g., 'sim_cfg.wrapper_params.my_ball_density')
%
%   Args:
%     dir_path (string): Path to the directory containing workspace_log_*.mat files
%     field_path (string): Dot-separated field path to sort by (e.g., 'sim_cfg.wrapper_params.my_ball_density')
%
%   Returns:
%     workspaces (struct array): Struct array with loaded content and sort key

  files = dir(fullfile(dir_path, 'workspace_log_*.mat'));
  if isempty(files)
    error("No workspace_log_*.mat files found in: %s", dir_path);
  end

  temp = struct([]);
  for i = 1:length(files)
    file_path = fullfile(files(i).folder, files(i).name);
    data = load(file_path);

    try
      value = getNestedField(data, field_path);
    catch
      error("⚠ Could not find field '%s' in file: %s", field_path, files(i).name);
    end

    temp(i).filename = files(i).name;
    temp(i).sort_key = value;

    % Include all top-level workspace fields
    top_fields = fieldnames(data);
    for f = 1:length(top_fields)
      temp(i).(top_fields{f}) = data.(top_fields{f});
    end
  end

  % Sort based on the extracted value
  [~, idx] = sort([temp.sort_key]);
  workspaces = temp(idx);

  % Display a short summary
  fprintf("✅ Loaded and sorted %d workspaces by '%s':\n", numel(workspaces), field_path);
  for i = 1:numel(workspaces)
    fprintf("  [%2d] %s → %.4f\n", i, workspaces(i).filename, workspaces(i).sort_key);
  end
end

function value = getNestedField(s, path)
%GETNESTEDFIELD Retrieves a nested field from a struct using dot-separated path
%   Example: getNestedField(s, 'sim_cfg.wrapper_params.my_ball_density')
  fields = strsplit(path, '.');
  value = s;
  for i = 1:length(fields)
    if isfield(value, fields{i})
      value = value.(fields{i});
    else
      error("Missing field: %s", strjoin(fields(1:i), '.'));
    end
  end
end
