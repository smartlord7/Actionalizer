function show_steps_per_minute(data_X, data_Y, data_Z, freq, fs, thres_ref, activity_name)
    N = length(data_X);
    
    values = [];
    for i=1:N
        data_x = cell2mat(data_X(i));
        data_y  = cell2mat(data_Y(i));
        data_z  = cell2mat(data_Z(i));
        data = [data_x, data_y, data_z];
        values = [values, calc_steps_per_min(data, freq, fs, thres_ref)];
    end
    
    [m, n] = size(values);
    fprintf("%s: %s +- %s steps per minute\n", activity_name, num2str(mean(values)), num2str(std(values)));
    fprintf("Values obtained: ");
    for i=1:m
        for j=1:n
            if(j == n)
                fprintf("%s\n", num2str(values(i, j)));
            else
                fprintf("%s ", num2str(values(i, j)));
            end
        end
    end
    
end