
function plot_meaned_dfts(freqs, meaned_dfts, num_ocurrences, activities, axis)
    for i = 1:length(activities)
        plot(cell2mat(freqs(i)), cell2mat(meaned_dfts(i)));
        plt_title = sprintf('DFT mean for activity %s (%d instances in all datasets) - AXIS %s', activities(i), num_ocurrences(i), get_axis_name(axis));
        title(plt_title);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        pause(1);
    end
end