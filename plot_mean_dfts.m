function plot_mean_dfts(mean_dfts, num_ocurrences, activities, axis_name)
    for i = 1:length(activities)
        plot(cell2mat(mean_dfts(2 * i - 1)), cell2mat(mean_dfts(2 * i)));
        plt_title = sprintf('DFT mean for activity %s (%d instances in all datasets) - AXIS %s', activities(i), num_ocurrences(i), axis_name);
        title(plt_title);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        pause(1);
    end
end