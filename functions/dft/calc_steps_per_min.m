%{
@def steps_per_min
@brief Function that calculates steps per minute per instance of activity.

@param data
Data used on the calculation.

@param min_freq
Minimal frequency to consider when applying a low-pass filter.

@param fs
Sample frequency used when capturing the data values.

@param thres_ref
Threshold reference to consider when discarding lower frequencies.

@return steps_per_min - number of steps per minutes calculated.
%}
function steps_per_min = calc_steps_per_min(data, min_freq, fs, thres_ref)
    
    % obtain the number of data entries and the number of components
    % considered
    N = size(data, 1);
    num_of_dim = size(data, 2);
    
    % prepare matrices for the gravitational acceleration and for the user
    % acceleration
    grav_ac = zeros(num_of_dim, N);
    user_ac = zeros(num_of_dim, N);
    
    % calculate user acceleration by removing gravitational acceleration
    % from total acceleration measured by the accelerometer on all of the
    % dimensions
    for i=1:num_of_dim
        grav_ac(i,:) = lowpass(data(:, i), min_freq, fs);
        user_ac(i, :) = data(:, i)'- grav_ac(i, :);
    end

    % calculate vertical acceleration
    vert_ac = dot(grav_ac, user_ac);
    
    [freqs, dft] = calc_dft(vert_ac, fs, 1, N);
    
    % remove non-positive values to discard duplicate values
    dft = dft(freqs > 0);
    freqs = freqs(freqs > 0);
    
    % define a threshold to discard lower step values and consider the first
    % relevant value to be the number of steps per minute
    threshold = max(dft) * thres_ref;
    [~, peaks_indexes] = findpeaks(dft, 'MinPeakHeight', threshold);
    peak_index = peaks_indexes(1);
    steps_per_min = freqs(peak_index) * 60;    
end
    