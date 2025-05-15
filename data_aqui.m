fieldNames = fieldnames(vars);
numFields = length(fieldNames);

% Get time vector from first timeseries
time = vars.(fieldNames{1}).Time;
dataMatrix = time;  % First column is time
columnNames = {'time'};  % Start with time column

% Loop through all fields
for i = 1:numFields
    ts = vars.(fieldNames{i});
    data = ts.Data;

    % Check if data is multi-column
    [~, numCols] = size(data);

    if numCols == 1
        dataMatrix = [dataMatrix, data];
        columnNames{end+1} = fieldNames{i};  % Just use field name
    else
        % If multi-column, expand and name each one uniquely
        for j = 1:numCols
            dataMatrix = [dataMatrix, data(:,j)];
            columnNames{end+1} = sprintf('%s_%d', fieldNames{i}, j);  % e.g. 'vt_mag_1'
        end
    end
end

% Convert to table and export
T = array2table(dataMatrix, 'VariableNames', columnNames);
writetable(T, 'signals_exported.csv');