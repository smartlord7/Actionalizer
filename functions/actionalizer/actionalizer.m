%{
@def actionalizer
@brief Function to recognize different types of activities of a given dataset.

@param dataset
Dataset to apply the sliding window method and from which to identify the existing activities.

@param fs
Sampling frequency used capturing the values on the dataset.

@param window_type
The type of window to apply to the dataset.

@param window_size
The size of each window to consider.

@param overlap_size
The size of window overlaping to consider.

@param freqs
Cell array of the average frequencies of all datasets for each action.

@param dfts
Cell array of the average magnitudes of each frequency of all datasets for
each action.

@param slopes
Cell array of the average slopes of all datasets for each action.

@param activities
Array with the activity names.
%}
function actionalizer(dataset, fs, window_type, window_size, overlap_size, freqs, dfts, slopes, activities)
    % Possible factors that affect the activity estimation.
    mag_factor = 1;
    freq_factor = 1;
    slope_factor = 1;
    len = length(activities);
    
    
    N = length(dataset(:, 1));
    ts = 1/fs;
    n_frame = round(window_size * fs);
    n_overlap = round(overlap_size * fs);
    
    % Get the frequency vector
    if mod(n_frame, 2) == 0
        f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
    else
        f_frame = -fs/2 + fs/(2*n_frame):fs/n_frame:fs/2-fs/(2*n_frame);
    end
    
    % 12 -> number of activities
    default_freq = zeros(3, len);
    default_mag = zeros(3, len);
    default_slope = zeros(3, len);
    
    % Get the max frequency, magnitude and slopes for each action and
    % dimension (x, y, z)
    for i = 1:len
        for k = 1:3
            default_freq(k, i) = max(freqs{k}{i});
            default_mag(k, i) = max(dfts{k}{i});
            default_slope(k, i) = max(slopes{k}{i});
        end
    end
    
    window = window_type(n_frame);
    
    % Time vector (in seconds)
    t = 0:ts:(N-1)*ts;
    
    for i = 1:n_frame-n_overlap:N-n_frame+1
        interval = i:i+n_frame-1;
        
        % Get the frames for each dimension.
        x_frame_x = dataset(interval, 1);
        x_frame_y = dataset(interval, 2);
        x_frame_z = dataset(interval, 3);

        % Get the slopes for each dimension.
        slope_x = get_abs_slope(interval, x_frame_x);
        slope_y = get_abs_slope(interval, x_frame_y);
        slope_z = get_abs_slope(interval, x_frame_z);

        % Ge the frames for each dimension with the chosen window.
        x_frame_x = detrend(x_frame_x).*window;
        x_frame_y = detrend(x_frame_y).*window;
        x_frame_z = detrend(x_frame_z).*window;

        % Get the dft vector for each dimension.
        m_X_frame_x = abs(fftshift(fft(x_frame_x)));
        m_X_frame_y = abs(fftshift(fft(x_frame_y)));
        m_X_frame_z = abs(fftshift(fft(x_frame_z)));

        % Get the max frequency magnitude for each dimension.
        mag_x = max(m_X_frame_x);
        mag_y = max(m_X_frame_y);
        mag_z = max(m_X_frame_z);

        % Get the frequency which maximizes the magnitude for each
        % dimension.
        freqs_x = f_frame(abs(m_X_frame_x - mag_x) < 0.001);
        freqs_y = f_frame(abs(m_X_frame_y - mag_y) < 0.001);
        freqs_z = f_frame(abs(m_X_frame_z - mag_z) < 0.001);
        freq_x = abs(freqs_x(1));
        freq_y = abs(freqs_y(1));
        freq_z = abs(freqs_z(1));

        % Define a max value for a possible error comparing different.
        % activites
        min_error = 10000;
        correct_activity = 0;
        
        % j -> Activity
        for j = 1:12
            % Get slope deviation comparing to the average of all datasets.
            slope_deviation = norm(slope_factor*[default_slope(1, j) - slope_x, default_slope(2, j) - slope_y, default_slope(3, j) - slope_z]);
            % Get frequency deviation comparing to the average of all
            % datasets.
            freq_deviation = norm(freq_factor*[default_freq(1, j) - freq_x, default_freq(2, j) - freq_y, default_freq(3, j) - freq_z]);
            % Get magnitude deviation comparing to the average of all
            % datasets.
            mag_deviation = norm(mag_factor*[default_mag(1, j) - mag_x, default_mag(2, j) - mag_y, default_mag(3, j) - mag_z]);
            
            % Get the error of the all deviations (We need to minimize both 3 components)
            error = norm([slope_deviation, freq_deviation, mag_deviation]);
            if error < min_error
                min_error = error;
                correct_activity = j;
            end
        end
        
        %fprintf('Time %.1f(s): Slope (%.5f, %.5f, %.5f) Freq(%.5f, %.5f, %.5f) Mag(%.5f %.5f %.5f)\n', t(i), slope_x, slope_y, slope_z, freq_x, freq_y, freq_z, mag_x, mag_y, mag_z);
        fprintf('Time (%.1fs) [Interval: %d] GUESS: %s (%d) with an error of: %.5f\n', t(i), t(i)*fs, activities(correct_activity), correct_activity, min_error);
    end
end