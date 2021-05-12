function plot_datasets(datasets, act_colors, labels)
   len = size(datasets, 1);
   label_i = 1;
   
   for i = 1:len
       dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
       init_label = label_i;
       
       for k = 1:3
           label_i = init_label;
           subplot(3, 1, k);
           plot(1:length(dataset), dataset(:, k), 'k');
           
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
               x = start:finish;
               
               plot(x, dataset(x, k), act_colors(act));
               
               label_i = label_i + 1;
           end
           
           hold off;
       end
       
       pause(5)
   end
end
