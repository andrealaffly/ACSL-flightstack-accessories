% function der_gains = importDerGains(jsonFile)
% %IMPORTDERGAINS Import derived gain matrices directly from JSON
% %   Assumes the JSON contains plain matrix fields with no scaling coefficient.
% 
%     % Read JSON file
%     fid = fopen(jsonFile, 'r');
%     if fid == -1
%         error('Could not open file: %s', jsonFile);
%     end
% 
%     raw = fread(fid, inf);
%     str = char(raw');
%     fclose(fid);
% 
%     % Decode JSON
%     data = jsondecode(str);
% 
%     % Initialize output structure
%     der_gains = struct();
% 
%     % Copy each field directly into the output struct
%     gainFields = fieldnames(data);
%     for i = 1:length(gainFields)
%         varName = gainFields{i};
%         der_gains.(varName) = data.(varName);
%     end
% end
% 

function der_gains = importDerGains(jsonFile)
%IMPORTDERGAINS Import derived gain matrices directly from JSON
%   Assumes the JSON contains plain matrix fields with no scaling coefficient.

  % Check if file exists
  if ~exist(jsonFile, 'file')
    warning('importDerGains:FileNotFound', ...
      'Derived gains file not found: %s. Continuing with empty struct.', jsonFile);
    der_gains = struct(); % Return empty struct so caller can handle gracefully
    return;
  end

  % Read JSON file
  fid = fopen(jsonFile, 'r');
  if fid == -1
    warning('importDerGains:FileOpenError', ...
      'Could not open file: %s. Continuing with empty struct.', jsonFile);
    der_gains = struct();
    return;
  end

  raw = fread(fid, inf);
  str = char(raw');
  fclose(fid);

  % Decode JSON
  data = jsondecode(str);

  % Initialize output structure
  der_gains = struct();

  % Copy each field directly into the output struct
  gainFields = fieldnames(data);
  for i = 1:length(gainFields)
    varName = gainFields{i};
    der_gains.(varName) = data.(varName);
  end
end

