function plot_meaned_activities(acts, axis, act_names)
    for i = 1:length(act_names)
        values = cell2mat(acts(i));
        n = 1:length(values);
        subplot(4, 3, i)
        plot(n, values);
        title(act_names(i))
    end
    
    main_ttl = sprintf('Meaned activities - AXIS: %s', get_axis_name(axis));
end

