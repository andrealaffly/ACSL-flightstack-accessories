function deleteFileIfNoData(properties, filename, dataMatrix)
%DELETEFILEIFNODATA Delete a log file if it has less than 2 rows

  if (size(dataMatrix, 1) < 2 || isempty(filename))
    disp(['WARNING: The file ', filename, ' does not have enough rows. File DELETED.']);
    if ispc % check if OS is Windows
      recycle('on'); % Enable recycling feature (move to trash instead of deleting)
      delete(filename); % Move the file to trash
    else
      delete(filename); % Delete the file
    end

    % Extract the timestamp from the filename
    [~, filename_no_ext, ~] = fileparts(filename);
    timestamp = regexp(filename_no_ext, '\d{8}_\d{6}', 'match', 'once');
    
    % If timestamp is found, move the corresponding gains file to trash
    if ~isempty(timestamp)
      gains_files = dir(fullfile(properties.gains_folder, sprintf('gains_*_%s.json', timestamp)));
      for i = 1:length(gains_files)
        gains_file = fullfile(properties.gains_folder, gains_files(i).name);
        if ispc
          recycle('on'); % Enable recycling feature (move to trash instead of deleting)
          delete(gains_file); % Move the file to trash
        else
          delete(gains_file); % Delete the file
        end
      end
    end
  end
end

