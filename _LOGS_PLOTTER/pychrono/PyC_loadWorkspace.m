function pp = PyC_loadWorkspace(pp)
%LOADWORKSPACE Load the workspace

% Extract year and month from the folder_name
pp.folder_year = pp.folder_name(1:4);
pp.folder_month = pp.folder_name(5:6);

% Define the path to the workspaces directory
pp.workspaces_dir = fullfile('../pychrono', pp.folder_year, pp.folder_month, pp.folder_name, ...
    pp.folder_controller, 'workspaces');

% Automatically load the most recent workspace
% contained in pp.folder_name
pp = autoLoadLatestWorkspace(pp);

disp(['Plotting workspace file: ', pp.workspace_filename]);

% Construct the full path to the workspace file
pp.workspace_path = fullfile(pp.workspaces_dir, pp.workspace_filename);

% Load the specified workspace
% load(pp.workspace_path);

% Load the specified workspace into the base workspace
evalin('base', sprintf('load(''%s'')', pp.workspace_path));


end

