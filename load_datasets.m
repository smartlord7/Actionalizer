filename = 'datasets/acc_exp01_user01.txt';
labelname = 'datasets/labels.txt';
dataset = dlmread(filename, ' ');
label = dlmread(labelname, ' ');

colors = ['-r', '-g', '-b', '-c', '-m', '-y', '-r', '-g', 'b', 'c', 'm'];

for k=1:3
    subplot(3, 1, k);
    plot(1:length(dataset), dataset(:, k), '-k')
    hold on
    for i=1:length(label)
        exp = label(i, 1);
        if exp == 2
            break
        end
        user = label(i, 2);
        activity = label(i, 3);
        start = label(i, 4);
        finish = label(i, 5);
        
        x = start:finish;
        plot(x, dataset(x, k), colors(activity))
    end
end

hold off