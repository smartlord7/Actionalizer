%{
@def plot_dataset_param
@brief Plot some param of the dataset (slope, max magnitude).

@param meaned_acts
Means for each activity.

@param act_names
List of the activity names.

@param param_func
Function to get the param to plot (get_abs_slope, get_max_dist).

@param param_name
The name of the param.

@param axis
Axis index (1, 2 or 3)

@param colors
List with colors of each activity.

%}

function plot_dataset_param(meaned_acts, act_names, param_func, param_name, axis, colors, dx, dy)  
    figure;
    
    hold on;
    
    for i = 1:length(meaned_acts)
         values = cell2mat(meaned_acts(i));
         domain = 1:length(values);
         
         param_value = param_func(domain, values);
         scatter(i, param_value, 'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', 'black');
         point_lbl = sprintf('%.5f', param_value);
         ylbl = sprintf('Comparison param (%s)', param_name);
         text(i + dx, param_value + dy * (-1)^i, point_lbl, 'Fontsize', 8);
         xlabel('Activity index');
         ylabel(ylbl);
    end
    
    legend(act_names(:), 'Location', 'northwest');
    plt_title = sprintf('%s param comparison - AXIS: %s', param_name, get_axis_name(axis));
    title(plt_title);
    
    hold off;
end