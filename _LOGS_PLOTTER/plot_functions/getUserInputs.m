function pp = getUserInputs()
    % Create a figure window with custom background color
    fig = uifigure('Position', [500 500 500 250], 'Name', 'User Inputs', ...
        'Color', [0.95 0.95 0.95]);

    % Define common font and font size
    fontName = 'Arial';
    fontSize = 14;
    fontWeight = 'bold';  % Make labels bold
    
    % Define custom colors
    bgColor = [0.95 0.95 0.95];  % Background color
    labelColor = [0.1 0.1 0.5];  % Label color (dark blue)
    buttonColor = [0.3 0.75 0.93];  % Light blue button
    buttonTextColor = [1 1 1];  % White text for button

    % Define default values for user inputs
    defaultFolderName = '20240927';
    defaultFolderController = 'TwoLayerMRAC';
    defaultWorkspaceFilename = 'workspace_log_20240927_115052.mat';
    defaultAutoLoad = true;
    
    % Create input fields for folder name
    lblFolderName = uilabel(fig, 'Position', [20 180 150 22], 'Text', 'Folder Name:', ...
        'FontName', fontName, 'FontSize', fontSize, 'FontColor', labelColor, ...
        'BackgroundColor', bgColor, 'FontWeight', fontWeight);
    txtFolderName = uieditfield(fig, 'text', 'Position', [200 180 280 22], 'Value', defaultFolderName, ...
        'FontName', fontName, 'FontSize', fontSize);
    
    % Create input fields for controller folder name
    lblFolderController = uilabel(fig, 'Position', [20 140 180 22], 'Text', 'Controller Folder Name:', ...
        'FontName', fontName, 'FontSize', fontSize, 'FontColor', labelColor, ...
        'BackgroundColor', bgColor, 'FontWeight', fontWeight);
    txtFolderController = uieditfield(fig, 'text', 'Position', [200 140 280 22], 'Value', defaultFolderController, ...
        'FontName', fontName, 'FontSize', fontSize);
    
    % Create input fields for workspace filename
    lblWorkspaceFilename = uilabel(fig, 'Position', [20 100 150 22], 'Text', 'Workspace Filename:', ...
        'FontName', fontName, 'FontSize', fontSize, 'FontColor', labelColor, ...
        'BackgroundColor', bgColor, 'FontWeight', fontWeight);
    txtWorkspaceFilename = uieditfield(fig, 'text', 'Position', [200 100 280 22], ...
      'Value', defaultWorkspaceFilename, 'FontName', fontName, 'FontSize', fontSize);
    
    % Create checkbox for auto-load last workspace
    chkAutoLoad = uicheckbox(fig, 'Position', [200 60 280 22], 'Text', 'Auto-load last workspace', ...
        'FontName', fontName, 'FontSize', fontSize, 'Value', defaultAutoLoad, 'FontColor', ...
        labelColor, 'FontWeight', fontWeight);
    
    % Create a button to confirm the input and close the GUI with custom color
    btnConfirm = uibutton(fig, 'Position', [200 20 100 30], 'Text', 'Confirm', ...
        'ButtonPushedFcn', @(btn,event) confirmCallback(fig, txtFolderName, ...
        txtFolderController, txtWorkspaceFilename, chkAutoLoad), ...
        'BackgroundColor', buttonColor, 'FontSize', fontSize, 'FontName', ...
        fontName, 'FontColor', buttonTextColor);
    
    % Wait for the figure to close before returning
    uiwait(fig);
    
    % Callback function for the confirm button
    function confirmCallback(fig, txtFolderName, txtFolderController, txtWorkspaceFilename, chkAutoLoad)
        % Collect the inputs into the pp struct
        pp.folder_name = txtFolderName.Value;
        pp.folder_controller = txtFolderController.Value;
        pp.workspace_filename = txtWorkspaceFilename.Value;
        pp.auto_load_last_workspace = chkAutoLoad.Value;

        % Display the inputs to confirm
        disp(['Folder Name: ', pp.folder_name]);
        disp(['Controller Folder Name: ', pp.folder_controller]);
        disp(['Workspace Filename: ', pp.workspace_filename]);
        disp(['Auto-load last workspace: ', mat2str(pp.auto_load_last_workspace)]);
        
        % Close the GUI and allow the program to continue
        uiresume(fig);
        close(fig);
    end
end




