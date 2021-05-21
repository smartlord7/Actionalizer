%{
@def plot_meaned_dfts
@brief

@param freqs

@param meaned_dfts

@param num_ocurrences

@param activities

@param activities

@param axis

%}
function plot_meaned_dfts(freqs, meaned_dfts, num_ocurrences, activities, axis)

    figure;
    hold on;

    for i = 1:length(activities)
        subplot(4, 3, i);
        
        plot(cell2mat(freqs(i)), cell2mat(meaned_dfts(i)));
        plt_title = sprintf('%s (%d instances in all datasets)', activities(i), num_ocurrences(i));
        title(plt_title);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
    end
    
    plt_title = sprintf('DFT mean for all activities - AXIS %s', get_axis_name(axis));
    sgtitle(plt_title);
    
    hold off;
end