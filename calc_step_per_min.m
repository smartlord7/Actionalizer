function steps_per_min = calc_step_per_min(data, freq, fs, thres_ref)
    
    % obtain the number of data entries and the number of components
    % considered
    N = size(data, 1);
    num_of_dim = size(data, 1);
    
    % prepare matrices for the gravitational acceleration and for the user
    % acceleration
    grav_ac = zeros(num_of_dim, N);
    user_ac = zeros(num_of_dim, N);
    
    % calculate user acceleration by removing gravitational accelari0on
    % from total acceleration measured by the accelerometer on all of the
    % dimensions
    for i=1:num_of_dim
        grav_ac(i,:) = lowpass(data(:, i), freq, fs);
        user_ac(i, :) = data(:, i)'- grav_ac(i, :);
    end
    % calculate vertical acceleration
    vert_ac = dot(user_ac, grav_ac);
    
    % obtain frequencies' vector
    if (mod(N,2)==0)
        freqs = -fs/2:fs/N:fs/2-fs/N;
    else
        freqs = -fs/2+fs/(2*N):fs/N:fs/2-fs/(2*N);
    end
    
    % calculate dft for the vertical acceleration
    dft = abs(fftshift(fft(vert_ac)));
    
    % remove non-positive values to discard duplicate values
    dft = dft(dft > 0);
    freqs = freqs(freqs > 0);
    
    % define a threshold to discard lower step values and consider the first
    % relevant value to be the number of steps per minute
    threshold = max(dft) * thres_ref;
    [~, peaks_indexes] = findpeaks(dft, 'MinPeakHeight', threshold);
    steps_per_min = freqs(peaks_indexes) * 60;
    
end
    