
%{
@def calc_stft
@brief Function that calculates the STFT for a given dataset.

@param dataset
Dataset to use on STFT calculation.

@param fs
Sample frequency used when capturing the values on the dataset.

@param window_type
The type of window to apply to the dataset.

@param window_size
The size of each window to consider.

@param overlap_size
The size of overlaping to consider on the window application to the
dataset.

@return relev_freqs - vector with the relevant frequencies obtained.
        relev_mags -  vector with the magnitudes associated to each frequency obtained.
        times - vector with the time instances associated to each frequency
        obtained.
%}
function [relev_freqs, relev_mags, times] = calc_stft(x, fs, window_type, window_size, overlap_size)
    N = length(x);
    ts = 1/fs;
    
    % calculate the number of window frames and the number of overlapings
    n_frame = round(window_size * fs);
    n_overlap = round(overlap_size * fs);
    
    % obtain the frequencies vector
    if mod(n_frame, 2) == 0
        f_frame = -fs/2:fs/n_frame:fs/2-fs/n_frame;
    else
        f_frame = -fs/2 + fs/(2*n_frame):fs/n_frame:fs/2-fs/(2*n_frame);
    end
    
    % calculate the window
    window = window_type(n_frame);
    
    % prepare arrays to store the results
    relev_freqs = [];
    relev_mags = [];
    times = [];
    
    % obtain the time vector
    t = 0:ts:(N-1)*ts;
    
    for i = 1:n_frame-n_overlap:N-n_frame+1
        % obtain the frame to consider
        x_frame = x(i:i+n_frame-1);
        x_frame = dtrend(x_frame);
        
        % apply the window to the frame
        x_frame = x_frame.*window;
        
        % calculate the DFT of the frame
        X_frame = fftshift(fft(x_frame));
        
        % obtain the magnitudes
        m_X_frame = abs(X_frame);
        
        % obtain the maximum magnitude
        mag = max(m_X_frame);
        
        % obtain the relevant frequencies and the corresponding magnitutes
        % and time instances
        freqs = f_frame(abs(m_X_frame - mag) < 0.001);
        relev_freqs = [relev_freqs, abs(freqs(1))];
        relev_mags = [relev_mags, mag];
        times = [times, t(i)];
    end
        
end