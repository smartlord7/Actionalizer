%{
@def plot_activity
@brief Function that plots an identified activity.

@param datasets
Datasets to containing the values obtained in the experiences.

@param fs
Sample frequency used when capturing the values on the dataset.

@param act_colors
Vector with color RGB codes to assign to mark each activity.

@param labels
Vector with labels describing the experiences performed by the users.

@param activities
Vector with names atributed to each activity.

@param exp
Experience index to identify the experiences to consider.

@param act_ind
Index value to identify the activity.
%}
function plot_activity(datasets, fs, act_colors, labels, activities, exp, act_ind)
   ts = 1/fs;
   
   % reshape the datasets received
   dataset = reshape(datasets(exp,:,:), size(datasets(exp,:,:), 2), size(datasets(exp,:,:), 3));
   
   % find the code atributed to each activity and the correspondent start and finish
   % time instances
   act = labels(act_ind, 3);
   start = labels(act_ind, 4);
   finish = labels(act_ind, 5);
   
   % plot the activity when applied different types of window
   plot_window(dataset, start:finish, @hamming, 'Hamming', 0)
   plot_window(dataset, start:finish, @hann, 'Hann', 1)
   plot_window(dataset, start:finish, @blackman, 'Blackman', 2)
   plot_window(dataset, start:finish, @rectwin, 'Rectangular', 3)
   plot_window(dataset, start:finish, @gausswin, 'Gaussiana', 4)
   
   figure;
   % plot the three dimensions (x, y, z) measured during the activity
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