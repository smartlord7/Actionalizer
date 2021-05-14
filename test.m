% region constants
datasets_dir = 'datasets';
labels_path = 'labels.txt';
colors = ['-r', '-g', '-b', '-c', '-m', '-y', '-r', '-g', 'b', 'c', 'm'];
activities = ["WALK", "WALK\_UP", "WALK\_DOWN", "SIT", "STAND", "LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LIE", "LIE\_SIT", "STAND\_LIE", "LIE\_STAND"];
% end region constants

labels = dlmread(labels_path, ' ');
datasets = load_datasets('datasets');

plot_datasets(datasets, colors, labels, activities);