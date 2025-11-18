function structToJSON(json_struct, filename)
jsonFile = jsonencode(json_struct,PrettyPrint=true);

% Write JSON to file
fid = fopen(filename, 'w');
if fid == -1
    error('Cannot create JSON file.');
end
fwrite(fid, jsonFile, 'char');
fclose(fid);

disp(['JSON file saved as: ' filename]);
end
