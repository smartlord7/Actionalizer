function plot_dataset_param(meaned_acts, act_names, param_func, plt_title, colors)  
    figure;
    
    hold on;
    
    for i = 1:length(meaned_acts)
         values = cell2mat(meaned_acts(i));
         domain = 1:length(values);
         
         param_value = param_func(domain, values);
         scatter(i, param_value, 'MarkerFaceColor', ['#' colors{i}], 'MarkerEdgeColor', 'black');
         fprintf('Comparison param value (Act. %s): %.5f\n', act_names(i), param_value);
    end
    
    legend(act_names(:), 'Location', 'northwest');
    title(plt_title)
    
    hold off;
end