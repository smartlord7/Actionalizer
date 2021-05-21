
function plot_datasets(datasets, fs, labels, activities, act_colors)
   len = length(datasets);
   label_i = 1;
   ts = 1/fs;
   
   figure;
   
   for i = 1:1
       dataset = cell2mat(datasets(i));
       init_label = label_i;
       
       for k = 1:3
           label_i = init_label;
           subplot(3, 1, k);
           plot(ts/60:ts/60:(length(dataset) * ts)/60, dataset(:, k), 'k');
           y_lbl = sprintf('ACC angle - %s (m/s^2)', get_axis_name(k));
           ylabel(y_lbl);
           
           xlabel('Time (min)')
           
           hold on
           
           while 1
               exp = labels(label_i, 1);

               if exp ~= i
                    break;
               end

               user = labels(label_i, 2);
               act = labels(label_i, 3);
               start = labels(label_i, 4);
               finish = labels(label_i, 5);
               x = start * ts/60:ts/60:finish * ts/60;
               y_point = mean(dataset(start:finish, k)) + 0.7 * (-1)^label_i;
               color_hex = char(act_colors(act));
               color = sscanf(color_hex(2:end),'%2x%2x%2x',[1 3])/255;
               plot(x, dataset(start:finish, k), 'Color', color);
               text(start*ts/60, y_point, activities(act),'Fontsize', 7);
               label_i = label_i + 1;
           end
           
           plt_title = sprintf('Experience %d, User %d', exp, user);
           sgtitle(plt_title);
           
           hold off;
       end
       
       %pause(2);
   end
end