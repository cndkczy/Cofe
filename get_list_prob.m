clear all
clc
% Specify the paths to the Excel file, text file, and output file
excelFilePath = 'data2test2\sampleinput/sample_annotation.xlsx';
textFilePath = 'data2test2\sampleoutput/ProblematicImagedata.txt';
outputFilePath = 'filtered_output.xlsx';


% Read the Excel file
[~, ~, data] = xlsread(excelFilePath);

% Read the text file and extract substrings from each line
fid = fopen(textFilePath, 'r');
textLines = textscan(fid, '%s', 'Delimiter', '\n');
textLines = textLines{1};
fclose(fid);


% Initialize a logical index to keep track of matching rows
matchingRows = false(size(data, 1), 1);

% Iterate through each line in the text file
for lineIdx = 1:length(textLines)
    % Extract the substring from the 15th to the 26th index
    searchString = extractBetween(textLines{lineIdx}, 15, 26);
    % Iterate through each row in the Excel file
    for i = 1:size(data, 1)
        % Check if the substring is present in either column 3 or 4
        if size(data, 2) >= 4 && ...
                (~isempty(data{i, 3}) && contains(data{i, 3}, searchString)) || ...
                (~isempty(data{i, 4}) && contains(data{i, 4}, searchString))
            matchingRows(i) = true;
        end
    end
end

% Keep only the rows that match the criteria
filteredData = data(matchingRows, :);

% Write the filtered data to a new Excel file
xlswrite(outputFilePath, filteredData);

disp('Filtered data has been saved to the output file.');




