%{
@def plot_dataset_param
@brief 

@param meaned_acts


@param act_names


@param param_func


@param param_name


@param axis
Axis to be considered.

@param colors
Vector with color RGB codes to assign to mark each activity.

@param dx
Distance of point in the x axis to place the label

@param dy
Distance of point in the y axis to place the label
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