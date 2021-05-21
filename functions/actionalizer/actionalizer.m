function actionalizer(dataset, fs, window_type, window_size, overlap_size, freqs, dfts, slopes, activities)
    mag_factor = 1;
    freq_factor = 1;
    slope_factor = 1;
    
    
    N = length(dataset(:, 1));
    ts = 1/fs;
    n_frame = round(window_size * fs);
    n_overlap = round(overlap_size * fs);
    
    if mod(n_frame, 2) == 0
        f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
    else
        f_frame = -fs/2 + fs/(2*n_frame):fs/n_frame:fs/2-fs/(2*n_frame);
    end
    
    % 12 -> number of activities
    default_freq = zeros(3, 12);
    default_mag = zeros(3, 12);
    default_slope = zeros(3, 12);
    
    for i = 1:12
        for k = 1:3
            default_freq(k, i) = max(freqs{k}{i});
            default_mag(k, i) = max(dfts{k}{i});
            default_slope(k, i) = max(slopes{k}{i});
        end
    end
    
    window = window_type(n_frame);
    
    t = 0:ts:(N-1)*ts;
    
    for i = 1:n_frame-n_overlap:N-n_frame+1
        interval = i:i+n_frame-1;
        
        x_frame_x = dataset(interval, 1);
        x_frame_y = dataset(interval, 2);
        x_frame_z = dataset(interval, 3);

        slope_x = get_abs_slope(interval, x_frame_x);
        slope_y = get_abs_slope(interval, x_frame_y);
        slope_z = get_abs_slope(interval, x_frame_z);

        x_frame_x = detrend(x_frame_x).*window;
        x_frame_y = detrend(x_frame_y).*window;
        x_frame_z = detrend(x_frame_z).*window;

        m_X_frame_x = abs(fftshift(fft(x_frame_x)));
        m_X_frame_y = abs(fftshift(fft(x_frame_y)));
        m_X_frame_z = abs(fftshift(fft(x_frame_z)));

        mag_x = max(m_X_frame_x);
        mag_y = max(m_X_frame_y);
        mag_z = max(m_X_frame_z);

        freqs_x = f_frame(abs(m_X_frame_x - mag_x) < 0.001);
        freqs_y = f_frame(abs(m_X_frame_y - mag_y) < 0.001);
        freqs_z = f_frame(abs(m_X_frame_z - mag_z) < 0.001);

        freq_x = abs(freqs_x(1));
        freq_y = abs(freqs_y(1));
        freq_z = abs(freqs_z(1));

        min_error = 10000;
        correct_activitie = 0;
        
        for j = 1:12
            slop_deviation = norm(slope_factor*[default_slope(1, j) - slope_x, default_slope(2, j) - slope_y, default_slope(3, j) - slope_z]);
            freq_deviation = norm(freq_factor*[default_freq(1, j) - freq_x, default_freq(2, j) - freq_y, default_freq(3, j) - freq_z]);
            mag_deviation = norm(mag_factor*[default_mag(1, j) - mag_x, default_mag(2, j) - mag_y, default_mag(3, j) - mag_z]);
            
            error = norm([slop_deviation, freq_deviation, mag_deviation]);
            if error < min_error
                min_error = error;
                correct_activitie = j;
            end
        end
        
        %fprintf('Time %.1f(s): Slope (%.5f, %.5f, %.5f) Freq(%.5f, %.5f, %.5f) Mag(%.5f %.5f %.5f)\n', t(i), slope_x, slope_y, slope_z, freq_x, freq_y, freq_z, mag_x, mag_y, mag_z);
        fprintf('Time (%.1fs) [Interval: %d] GUESS: %s (%d) with an error of: %.5f\n', t(i), t(i)*fs, activities(correct_activitie), correct_activitie, min_error);
    end
end