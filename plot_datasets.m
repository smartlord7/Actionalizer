function plot_datasets(datasets, fs, labels, activities, act_colors)
    len = length(datasets);
    ts = 1/fs;
   
    for i = 1:len
        figure;
        dataset = cell2mat(datasets(i));

        indexes = find(labels(:,1) == i);
       
        exp = i;
        
        for k = 1:3
            subplot(3, 1, k);
            plot(ts/60:ts/60:(length(dataset) * ts)/60, dataset(:, k), 'k');
            y_lbl = sprintf('ACC angle - %s (m/s^2)', get_axis_name(k));
            ylabel(y_lbl);
            xlabel('Time (min)')
           
            hold on

            for j=1:length(indexes)
                index = indexes(j);
                user = labels(index, 2);
                act = labels(index, 3);
                start = labels(index, 4);
                finish = labels(index, 5);
                x = start * ts/60:ts/60:finish * ts/60;
                y_point = mean(dataset(start:finish, k)) + 0.7 * (-1)^index;
                color_hex = char(act_colors(act));
                color = sscanf(color_hex(2:end),'%2x%2x%2x',[1 3])/255;
                plot(x, dataset(start:finish, k), 'Color', color);
                text(start*ts/60, y_point, activities(act),'Fontsize', 7);
                plt_title = sprintf('Experience %d, User %d', exp, user);
                sgtitle(plt_title);
            end

            hold off;
        end
    end
end