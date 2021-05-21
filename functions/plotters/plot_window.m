function plot_window(win_func, win_size, win_name)
    win = win_func(win_size);
    
    figure;
    
    plot(1:win_size, win);
    title(win_name)
    
end

