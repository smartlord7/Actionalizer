function plot_activities(datasets, fs, act_colors, labels, activities, exp, act_ind)
   %len = size(datasets, 1);
   ts = 1/fs;
   
   dataset = reshape(datasets(exp,:,:), size(datasets(exp,:,:), 2), size(datasets(exp,:,:), 3));
   figure;
   for k = 1:3
       subplot(3, 1, k);

       act = labels(act_ind, 3);
       start = labels(act_ind, 4);
       finish = labels(act_ind, 5);
       x = start * ts/60:ts/60:finish * ts/60;

       plot(x, dataset(start:finish, k), act_colors(act));
       switch k
           case 1
               plt_title = sprintf('Dynamic Activity %s | %s', activities(act), 'X');
           case 2
               plt_title = sprintf('Dynamic Activity %s | %s', activities(act), 'Y');
           case 3
               plt_title = sprintf('Dynamic Activity %s | %s', activities(act), 'Z');
       end
       title(plt_title);
   end
end
