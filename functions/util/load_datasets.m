%{
@def load_datasets
@brief Function that gets the data about values all of the experiences from
a given directory.

@param directory
Text file that contains all of the values related to the experiences.

@return datasets - set with the values obtained.
%}
function datasets = load_datasets(directory)
    dataset_files = dir([directory '/*.txt']);
    len = length(dataset_files);
    datasets = cell(1, len);
    
    for i = 1:len
        datasets(i) = {dlmread([directory '/' dataset_files(i).name], ' ')};
    end
end