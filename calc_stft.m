function [freq_values, time_values, num_frames] = calc_stft(dataset, fs, window_function, start, finish)
    len = finish - start + 1;
    t = linspace(start, len - 1/fs, len);
    
    t_frame = 0.128
    t_overlap = 0.064
    n_frame = round(t_frame * fs)
    n_overlap = round(t_overlap * fs)
    num_frames = 0;
    freq_values = [];
    time_values = [];
    
    %calculate window
    window = window_function(n_frame);
    
    %determinate possible frequencies' vector
    if mod(n_frame, 2) == 0
        f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
    else
        f_frame = -fs/2 + fs/(2*n_frame):fs/n_frame: fs/2-fs/(2*n_frame);
    end
    
    for i = start:n_frame-n_overlap:len - n_frame + 1
        %apply the window to the dataset
        window_frame = dataset(i:i + n_frame-1).*window;
        
        %obtain signal fft's magnitude and maximum magnitude
        m_window_frame = abs(fftshift(fft(window_frame)));
        max_m_window_frame = max(m_window_frame);
        
        %find the frequency associated with the maximum magnitude
        index = find(abs(m_window_frame - max_m_window_frame) < 0.001);
        freq_values = [freq_values, f_frame(index(1))];
        
        num_frames = num_frames + 1;
        
        %find the time frame associated with the occurrence of the maximum
        %magnitude
        time_frame = t(i:i + n_frame - 1);
        time_values = [time_values, time_frame(round(n_frame/2) + 1)];
    end
end