function [grouped] = group_activities(datasets, user, labels, act_indexes)
    grouped = {};
    act_occurrences = zeros(1, 12);
    
    exps = unique(labels(labels(:, 2) == user, 1));
    
    for i = 1:length(exps)
        exp = exps(i);
        dataset = cell2mat(datasets(exp));

        indexes = find(labels(:, 1) == exp);

        % 12 -> number of different actions

        for j = 1:length(indexes)
            index = indexes(j);
            act = labels(index, 3);
            start = labels(index, 4);
            finish = labels(index, 5);
            act_occurrences(act) = act_occurrences(act) + 1;
            if ismember(act, act_indexes)
                grouped{act}{act_occurrences(act)} = dataset(start:finish, :);
            end
        end
    end
end