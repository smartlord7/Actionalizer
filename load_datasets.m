%%file load_datasets.m

function datasets = load_datasets(directory)
    dir_files = files(directory);
    datasets = zeros(length(dir_files));
    i = 0;

    for file = dir_files
        datasets(i) = load(file);    
        i = i + 1;    
    end
end 