
%{
@def plot_windowed_dft
@brief Function that plots a given windowed dft.

@param dataset
Dataset with the values obtained during the experiments.

@param interval
Time interval to consider.

@param win_func
Pointer to the function associated with type of window to plot.

@param title_str
Title to atribute to the plotted graphic.

@param i
Index to identify the position for the plotted graphic.

%}
function plot_windowed_dft(dataset, fs, interval, win_func, title_str, i)
    t_win = interval(end) - interval(1) + 1;
    n_win = round(t_win);
    window = win_func(n_win);
     
    % consider the three dimensions
    for k = 1:3
        subplot(5, 3, 3 * i + k);
        
        % apply the window to the dataset frame
        values = dataset(interval, k).*window;
        
        % calculate the dft for the frame
        [~, dft] = calc_dft(values, fs, 1, length(interval));
        
        plot(interval, dft);
        plotname = sprintf('DFT %s | AXIS: %s', title_str, get_axis_name(k));
        title(plotname);
    end
end