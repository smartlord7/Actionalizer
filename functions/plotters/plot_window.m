%{
@def plot_window
@brief Function that plots a given window.

@param win_func
Handler of the function associated with the type of window to plot.

@param win_size
Size of the window to consider.

@param win_name
Name assigned to the type of window considered.
%}
function plot_window(win_func, win_size, win_name)

    % obtain the window
    win = win_func(win_size);
    
    figure;
    
    plot(1:win_size, win);
    title(win_name);
    xlabel('N')
    ylabel('W(N)');
end

