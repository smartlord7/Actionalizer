%{
@def load_datasets
@brief Function that loads the required data.

@param directory
Text file that contains the values of the experiences.

@return datasets
Cell matrix with all of the values
%}
function datasets = load_datasets(directory)
    dataset_files = dir([directory '/*.txt']);
    len = length(dataset_files);
    datasets = cell(1, len);
    
    for i = 1:len
        datasets(i) = {dlmread([directory '/' dataset_files(i).name], ' ')};
    end
end