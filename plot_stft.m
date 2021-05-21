function plot_stft(x, fs, window_type, window_size, overlap_size)
    figure;
    
    axis_type = ["X", "Y", "Z"];
    
    for k = 1:3
        [relev_freqs, relev_mags, times] = calc_stft(x(:,k), fs, window_type, window_size, overlap_size);
        subplot(3,1,k)
        plot(times/60, relev_freqs, 'o');
        plt_title = sprintf('STFT %s', axis_type(k));
        title(plt_title);
    end
    
    for k = 1:3
        figure;
        spectrogram(x(:,k), window_size*fs, overlap_size*fs, 'yaxis');
        plt_title = sprintf('STFT %s', axis_type(k));
        title(plt_title);
    end
end