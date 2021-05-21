%{
@def group_activities
@brief Function that filters the experiences performed by the given user
from the datasets

@param datasets
Datasets that contain information about all the experiences performed.

@param user
User who performed the desired activities.

@param labels
Vector with labels describing the experiences performed by all of the users.

@param act_indexes
Vector with codes associated with each type of activity

@return grouped - vector containing data about all of the experiences done
by the user
%}
function [grouped] = group_activities(datasets, user, labels, act_indexes)
    grouped = {};
    act_occurrences = zeros(1, 12);
    
    % get information about the experiences done by the user
    exps = unique(labels(labels(:, 2) == user, 1));
    
    
    for i = 1:length(exps)
        exp = exps(i);
        dataset = cell2mat(datasets(exp));

        % find the experience values related to the user
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