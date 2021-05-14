function plot_datasets(datasets, fs, act_colors, labels)
   len = size(datasets, 1);
   label_i = 1;
   ts = 1/fs;
   
   for i = 1:1
       dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
       init_label = label_i;
       
       for k = 1:3
           label_i = init_label;
           subplot(3, 1, k);
           plot(ts/60:ts/60:(length(dataset) * ts)/60, dataset(:, k), 'k');
           
           switch k
               case 1
                   ylabel('ACC angle - x (rad)');
               case 2
                   ylabel('ACC angle - y (rad)');
               case 3
                   ylabel('ACC angle - z (rad)');
           end
           
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
               y_point = max(dataset(x, k));
               
               plt_title = sprintf('Experience %d, User %d', exp, user);
               title(plt_title);
               plot(x, dataset(x, k), act_colors(act));
               text(start + 0.1, y_point + 0.1, activities(act),'Fontsize', 7);
               label_i = label_i + 1;
           end
           
           hold off;
       end
       
       pause(5);
   end
end
