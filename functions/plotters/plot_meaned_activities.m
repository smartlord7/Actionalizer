%{
@def plot_meaned_activities
@brief Function that plots the mean of all activities instances.

@param acts
Datasets containing the values obtained in the experiences.

@param axis
Sampling frequency used when capturing the values on the dataset.

@param act_names
Vector with the names assigned to each activity.
%}
function plot_meaned_activities(acts, axis, act_names)
    figure;

    for i = 1:length(act_names)
        values = cell2mat(acts(i));
        n = 1:length(values);
        subplot(4, 3, i)
        plot(n, values);
        title(act_names(i))
    end
    
    main_ttl = sprintf('Meaned activities - AXIS: %s', get_axis_name(axis));
    sgtitle(main_ttl);
end

