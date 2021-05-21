
function datasets = load_datasets(directory)
    dataset_files = dir([directory '/*.txt']);
    len = length(dataset_files);
    datasets = cell(1, len);
    
    for i = 1:len
        datasets(i) = {dlmread([directory '/' dataset_files(i).name], ' ')};
    end
end