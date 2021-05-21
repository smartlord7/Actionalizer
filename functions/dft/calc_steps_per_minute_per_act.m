function [mean_value, std_value] = calc_steps_per_minute_per_act(data, freq, fs, thres_ref)
    N = length(data);
    
    values = [];
    for i=1:N
        data_x = data{i}(:, 1);
        data_y = data{i}(:, 2);
        data_z = data{i}(:, 3);
        values = [values, calc_steps_per_min([data_x, data_y, data_z], freq, fs, thres_ref)];
    end
    mean_value = mean(values);
    std_value = std(values);
    
end