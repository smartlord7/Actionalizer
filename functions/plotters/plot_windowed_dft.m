function plot_windowed_dft(dataset, fs, interval, win_func, title_str, i)
    t_win = interval(end) - interval(1) + 1;
    n_win = round(t_win);
    window = win_func(n_win);
     
    for k = 1:3
        subplot(5, 3, 3 * i + k);
        
        values = dataset(interval, k).*window;
        
        [~, dft] = calc_dft(values, fs, length(interval));
        
        plot(interval, dft);
        plotname = sprintf('DFT %s | AXIS: %s', title_str, get_axis_name(k));
        title(plotname);
    end
end