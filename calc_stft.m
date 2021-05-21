function [relev_freqs, relev_mags, times] = calc_stft(x, fs, window_type, window_size, overlap_size)
    N = length(x);
    ts = 1/fs;
    n_frame = round(window_size * fs);
    n_overlap = round(overlap_size * fs);
    
    if mod(n_frame, 2) == 0
        f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
    else
        f_frame = -fs/2 + fs/(2*n_frame):fs/n_frame:fs/2-fs/(2*n_frame);
    end
    
    window = window_type(n_frame);
    
    relev_freqs = [];
    relev_mags = [];
    times = [];
    
    t = 0:ts:(N-1)*ts;
    
    for i = 1:n_frame-n_overlap:N-n_frame+1
        x_frame = x(i:i+n_frame-1);
        x_frame = dtrend(x_frame);
        x_frame = x_frame.*window;
        
        X_frame = fftshift(fft(x_frame));
        
        m_X_frame = abs(X_frame);
        
        mag = max(m_X_frame);
        
        freqs = f_frame(abs(m_X_frame - mag) < 0.001);
        relev_freqs = [relev_freqs, abs(freqs(1))];
        relev_mags = [relev_mags, mag];
        times = [times, t(i)];
    end
        
end