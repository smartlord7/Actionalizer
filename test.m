% region constants
datasets_dir = 'datasets';
labels_path = 'labels.txt';
colors = ['-r', '-g', '-b', '-c', '-m', '-y', '-r', '-g', 'b', 'c', 'm'];
activities = ["WALK", "WALK\_UP", "WALK\_DOWN", "SIT", "STAND", "LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LIE", "LIE\_SIT", "STAND\_LIE", "LIE\_STAND"];
% end region constants

labels = dlmread(labels_path, ' ');
datasets = load_datasets('datasets');

label_i = 1;
fs = 50;
ts = 1/fs;

for i = 1:1
   dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
   init_label = label_i;

   for k = 1:1
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
           interval = start:finish
           y_point = max(dataset(interval, k));

           plt_title = sprintf('Experience %d, User %d', exp, user);
           title(plt_title);
           plot(interval, dataset(interval, k), colors(act));
           %text(start + 0.1, y_point + 0.1, activities(act),'Fontsize', 7);
           label_i = label_i + 1;
       end

       hold off;
   end

   pause(5);
end