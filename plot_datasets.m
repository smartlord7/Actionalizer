function plot_datasets(datasets, fs, act_colors, labels, activities)
   len = size(datasets, 1);
   label_i = 1;
   ts = 1/fs;
   
   for i = 1:len
       dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
       init_label = label_i;
       
       for k = 1:3
           label_i = init_label;
           subplot(3, 1, k);
           plot(ts/60:ts/60:(length(dataset) * ts)/60, dataset(:, k), 'k');
           y_lbl = sprintf('ACC angle - %s (rad/s^2)', axis_idx_to_axis_name(k));
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
               y_point = max(dataset(start:finish, k)) + 0.1;
               
               plt_title = sprintf('Experience %d, User %d', exp, user);
               title(plt_title);
               plot(x, dataset(start:finish, k), act_colors(act));
               text(start*ts/60, y_point, activities(act),'Fontsize', 7);
               label_i = label_i + 1;
           end
           
           hold off;
       end
       
       pause(2);
   end
end
