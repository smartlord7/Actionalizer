function plot_windowed_dft(dataset, interval, window_function, window_name, i)
    t_frame = interval(end) - interval(1) + 1;
    n_frame = round(t_frame);
    window = window_function(n_frame);
    
    dimensions = ["X", "Y", "Z"];
    
    for k=1:3
        subplot(5, 3, i*3 + k);
        values = dataset(interval, k).*window;
        
        dft = abs(fftshift(fft(values)));
        
        plot(interval, dft);
        plotname = sprintf('DFT %s | %s', window_name, dimensions(k));
        title(plotname);
    end
end