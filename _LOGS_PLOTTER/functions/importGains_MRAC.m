function gains = importGains_MRAC(jsonFile)
    % Read the JSON file
    fid = fopen(jsonFile, 'r');
    raw = fread(fid, inf);
    str = char(raw');
    fclose(fid);
    data = jsondecode(str);
    
    % Initialize the gains structure
    gains = struct();
    
    % Import BASELINE variables into the gains structure
    baselineFields = fieldnames(data.BASELINE);
    for i = 1:length(baselineFields)
        varName = baselineFields{i};
        varData = data.BASELINE.(varName);
        if isfield(varData, 'matrix') && isfield(varData, 'scaling_coef')
            gains.BASELINE.(varName) = varData.scaling_coef * varData.matrix;
        else
            gains.BASELINE.(varName) = varData;
        end
    end
    
    % Import ADAPTIVE variables into the gains structure
    adaptiveFields = fieldnames(data.ADAPTIVE);
    for i = 1:length(adaptiveFields)
        varName = adaptiveFields{i};
        varData = data.ADAPTIVE.(varName);
        if isfield(varData, 'matrix') && isfield(varData, 'scaling_coef')
            gains.ADAPTIVE.(varName) = varData.scaling_coef * varData.matrix;
        else
            gains.ADAPTIVE.(varName) = varData;
        end
    end
end




