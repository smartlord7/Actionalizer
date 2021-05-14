function datasets = load_datasets(directory)
    dataset_files = dir([directory '/*.txt']);
    max_size = 0;
    len = length(dataset_files);
    
    for i = 1:len
        current_size = size(dlmread([directory '/' dataset_files(i).name], ' '), 1);
        if current_size > max_size
            max_size = current_size;
        end
    end
    
    datasets = zeros(len, max_size, 3);
    
    for i = 1:len
        dataset = dlmread([directory '/' dataset_files(i).name], ' ');
        current_size = size(dataset, 1);   
        datasets(i,:,:,:) = [dataset ; NaN(max_size - current_size, 3)];
    end
end
