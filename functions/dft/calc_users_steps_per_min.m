%{
@def calc_steps_users
@brief Function that calculates the average steps per minute and correspondent
      standard deviation in all of the dynamic activies for the first N users.

@param datasets
Datasets describing the experiences performed by the users.

@param fs
Sample frequency used when capturing the data values.

@param min_freq
Minimal frequency to consider when applying a low-pass filter to the data.

@param thres_ref
Threshold reference to consider when discarding lower frequencies.

@param num_users
Number of users to consider.

@param dynamic_acts
Vector with the indexes associated with the dynamics activities considered.

@param labels
Vector with labels describing the experiences performed by the users.

@return steps_table - table containing the values obtained.
%}

function steps_table = calc_users_steps_per_min(datasets, fs, min_freq, thres_ref, num_users, dynamic_acts, labels) 
    
    users = 1:1:num_users;
    
    % create arrays to store the data;
    walk_avgs = [];
    walk_stds = [];
    walk_up_avgs = [];
    walk_up_stds = [];
    walk_down_avgs = [];
    walk_down_stds = [];
    
    for i=1:num_users
        user_acts = group_activities(datasets, i, labels, dynamic_acts);
        
        %calculate the average steps per minute and standard deviation for
        %the WALK activity
        walk_data = user_acts{1};
        [mean_value, std_value] = calc_act_steps_per_min(walk_data, min_freq, fs, thres_ref);
        
        walk_avgs = [walk_avgs, mean_value];
        walk_stds = [walk_stds, std_value];
        
        %calculate the average steps per minute and standard deviation for
        %the WALK_UP activity
        walk_up_data = user_acts{2};
        [mean_value, std_value] = calc_act_steps_per_min(walk_up_data, min_freq, fs, thres_ref);
        
        walk_up_avgs = [walk_up_avgs, mean_value];
        walk_up_stds = [walk_up_stds, std_value];
        
        %calculate the average steps per minute and standard deviation for
        %the WALK_DOWN activity
        walk_down_data = user_acts{3};
        [mean_value, std_value] = calc_act_steps_per_min(walk_down_data, min_freq, fs, thres_ref);
        
        walk_down_avgs = [walk_down_avgs, mean_value];
        walk_down_stds= [walk_down_stds, std_value];
        
    end
    
    USER = users';
    WALK_MEAN = walk_avgs';
    WALK_STD = walk_stds';
    WALK_UP_MEAN = walk_up_avgs';
    WALK_UP_STD = walk_up_stds';
    WALK_DOWN_MEAN = walk_down_avgs';
    WALK_DOWN_STD = walk_down_stds';
    
    steps_table = table(USER, WALK_MEAN, WALK_STD, WALK_UP_MEAN, WALK_UP_STD, WALK_DOWN_MEAN, WALK_DOWN_STD);
end