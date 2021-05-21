%{
@def calc_steps_per_minute_per_act
@brief Function that calculates steps per minute for an activity.

@param data
Data describing the activity in the three dimensions (x, y, z).

@param min_freq
Minimal frequency to consider when applying a low-pass filter to the data.

@param fs
Sample frequency used when capturing the data values.

@param thres_ref
Threshold reference to consider when discarding lower frequencies.

@return mean_value - average number of steps per minutes calculated.
        std_value - standard deviation obtained.
%}
function [mean_value, std_value] = calc_steps_per_minute_per_act(data, min_freq, fs, thres_ref)
    N = length(data);
    
    % calculate the values of steps per minute for each instance of the
    % activity
    values = [];
    for i=1:N
        data_x = data{i}(:, 1);
        data_y = data{i}(:, 2);
        data_z = data{i}(:, 3);
        values = [values, calc_steps_per_min([data_x, data_y, data_z], min_freq, fs, thres_ref)];
    end
    
    % extract the mean and the standard deviation
    mean_value = mean(values);
    std_value = std(values);
    
end