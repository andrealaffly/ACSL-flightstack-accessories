function pp = autoLoadLatestWorkspace(pp)
%AUTOLOADLATESTWORKSPACE Automatically load the most recent workspace
% contained in pp.folder_name

% Construct the full path to the workspace file
if pp.auto_load_last_workspace
    
    % Get list of all workspace files in the directory
    workspace_files = dir(fullfile(pp.workspaces_dir, 'workspace_log_*.mat'));
    
    % Sort the files by date in descending order
    [~, idx] = sort([workspace_files.datenum], 'descend');
    workspace_files = workspace_files(idx);
    
    % Get the most recent workspace file
    if ~isempty(workspace_files)
        pp.workspace_filename = workspace_files(1).name;
    else
        error('No workspace files found in the specified directory.');
    end
end

end

