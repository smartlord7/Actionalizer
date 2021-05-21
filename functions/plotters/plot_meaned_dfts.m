%{
@def plot_meaned_dfts
@brief Function that plots the meaned DFTs of all of the activities.

@param freqs
Vector that contains possible frequencies existent in the signal.

@param meaned_dfts
The mean of all activity dfts.

@param num_ocurrences
The number of ocurrences of each activity in all datasets.

@param activities
List containing the activity names.

@param axis
The current dataset axis (1, 2, 3).

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