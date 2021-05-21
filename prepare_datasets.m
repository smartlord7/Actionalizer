

function [num_act_ocurrences, acts_means, dft_freqs, dft_means, solver_slopes, solver_freqs, solver_mags] = prepare_datasets(datasets, dim, fs, unif_sizes, labels, activities)
   num_act = length(activities);
   dft_means = cell(1, num_act);
   dft_freqs = cell(1, num_act);
   acts_means = cell(1, num_act);
   solver_slopes = cell(1, num_act);
   solver_freqs = cell(1, num_act);
   solver_mags = cell(1, num_act);
   num_act_ocurrences = zeros(1, num_act);
   min_act_size = zeros(1, num_act);
   dyn_act_size = unif_sizes(1);
   static_act_size = unif_sizes(2);
   transition_act_size = unif_sizes(3);
    
   len = length(datasets);
   
   for i = 1:len
       dataset = cell2mat(datasets(i));
       
       indexes = find(labels(:, 1) == i);
           
       for j=1:length(indexes)
           index = indexes(j);
           act = labels(index, 3);
           start = labels(index, 4);
           finish = labels(index, 5);

           act_frag = dataset(start:finish, dim);
           
           slope = get_abs_slope(start:finish, act_frag);

           num_act_ocurrences(act) = num_act_ocurrences(act) + 1;
           l = size(act_frag, 1);
           
           if l < min_act_size(act) || min_act_size(act) == 0 
               min_act_size(act) = l;
           end

           if act < 4
               act_padded = [act_frag ; zeros(dyn_act_size - l, 1)];
           elseif act < 6
               act_padded = [act_frag ; zeros(static_act_size - l, 1)];    
           else
               act_padded = [act_frag ; zeros(transition_act_size - l, 1)];
           end

           [f, m_x] = calc_dft(act_padded, fs, 1, length(act_padded));
 
           
           % Get solver values
           [help_f, help_m_x] = calc_dft(act_frag, fs, 1, length(act_frag));
           max_mag = max(help_m_x);
           freqs = help_f(abs(help_m_x - max_mag) < 0.001);
           relev_freq = abs(freqs(1));
           
           
           if num_act_ocurrences(act) == 1
               acts_means(act) = {act_padded};
               dft_freqs(act) = {f(1:end)};
               dft_means(act) = {m_x};
               solver_slopes(act) = {slope};
               solver_freqs(act) = {relev_freq};
               solver_mags(act) = {max_mag};
           else
               acts_means(act) = {cell2mat(acts_means(act)) + act_padded};
               dft_means(act) = {cell2mat(dft_means(act)) + m_x};
               solver_slopes(act) = {cell2mat(solver_slopes(act)) + slope};
               solver_freqs(act) = {cell2mat(solver_freqs(act)) + relev_freq};
               solver_mags(act) = {cell2mat(solver_mags(act)) + max_mag};
           end
       end
  
   end
   
   for i = 1:length(activities)
       dft_means(i) = {cell2mat(dft_means(i)) / num_act_ocurrences(i)};
       values = cell2mat(acts_means(i));
       acts_means(i) = {values / num_act_ocurrences(i)};
       acts_means(i) = {values(1:min_act_size(i))};
       solver_slopes(i) = {cell2mat(solver_slopes(i)) / num_act_ocurrences(i)};
       solver_freqs(i) = {cell2mat(solver_freqs(i)) / num_act_ocurrences(i)};
       solver_mags(i) = {cell2mat(solver_mags(i)) / num_act_ocurrences(i)};
   end
end