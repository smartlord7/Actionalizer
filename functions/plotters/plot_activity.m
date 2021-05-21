function plot_activity(datasets, fs, act_colors, labels, activities, exp, act_ind)
   ts = 1/fs;
   
   dataset = reshape(datasets(exp,:,:), size(datasets(exp,:,:), 2), size(datasets(exp,:,:), 3));
   
   act = labels(act_ind, 3);
   start = labels(act_ind, 4);
   finish = labels(act_ind, 5);
   
   plot_window(dataset, start:finish, @hamming, 'Hamming', 0)
   plot_window(dataset, start:finish, @hann, 'Hann', 1)
   plot_window(dataset, start:finish, @blackman, 'Blackman', 2)
   plot_window(dataset, start:finish, @rectwin, 'Rectangular', 3)
   plot_window(dataset, start:finish, @gausswin, 'Gaussiana', 4)
   
   figure;
   for k = 1:3
       subplot(3, 1, k);
       
       x = start * ts/60:ts/60:finish * ts/60;
       
       plot(x, dataset(start:finish, k), act_colors(act));
       switch k
           case 1
               plt_title = sprintf('Activity %s | %s', activities(act), 'X');
           case 2
               plt_title = sprintf('Activity %s | %s', activities(act), 'Y');
           case 3
               plt_title = sprintf('Activity %s | %s', activities(act), 'Z');
       end
       title(plt_title);
   end
end
