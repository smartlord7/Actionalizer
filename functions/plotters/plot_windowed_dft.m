function plot_windowed_dft(dataset, fs, interval, window_function, title_str, i)
    t_frame = interval(end) - interval(1) + 1;
    n_frame = round(t_frame);
    window = window_function(n_frame);
     
    for k = 1:3
        subplot(5, 3, 3 * i + k);
        
        values = dataset(interval, k).*window;
        
        [~, dft] = calc_dft(values, fs, length(interval));
        
        plot(interval, dft);
        plotname = sprintf('DFT %s | AXIS: %s', title_str, get_axis_name(k));
        title(plotname);
    end
end