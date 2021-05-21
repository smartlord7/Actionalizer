
%{
@def plot_stft
@brief Function that calculates the STFTs from the datasets and plots the results.

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
%}
function plot_stft(dataset, fs, window_type, window_size, overlap_size)
    figure;   
    % plot the stft for in all of the three dimensions (x, y, z)
    for k = 1:3
        [relev_freqs, ~, times] = calc_stft(dataset(:,k), fs, window_type, window_size, overlap_size);
        subplot(3,1,k)
        plot(times/60, relev_freqs, 'o');
        plt_title = sprintf('AXIS: %s', get_axis_name(k));
        title(plt_title);
        xlabel('Time (s)');
        ylabel('Frequency (Hz)');
    end
    
    % plot the spectrogram for the stft for in all of the three dimensions (x, y, z)
    for k = 1:3
        figure;
        xlabel('Time (s)');
        spectrogram(dataset(:,k), window_size*fs, overlap_size*fs, 'yaxis');
        plt_title = sprintf('AXIS: %s', get_axis_name(k));
        title(plt_title);
    end
end