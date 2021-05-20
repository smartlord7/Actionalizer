function [num_act_ocurrences, dft_freqs, dft_means] = calc_activities_mean_dft(datasets, dim, fs, labels, activities)
   num_act = length(activities);
   dft_means = cell(1, num_act);
   dft_freqs = cell(1, num_act);
   num_act_ocurrences = zeros(1, num_act);
   dyn_act_size = 2000;
   static_act_size = 2500;
   transition_act_size = 1500;
    
   len = size(datasets, 1);
   label_i = 1;
   ts = 1/fs;
   
   for i = 1:len
       dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
       init_label = label_i;
       
       label_i = init_label;
           
       while 1
           exp = labels(label_i, 1);

           if exp ~= i
                break;
           end

           act = labels(label_i, 3);
           start = labels(label_i, 4);
           finish = labels(label_i, 5);

           act_frag = dataset(start:finish, dim);

           num_act_ocurrences(act) = num_act_ocurrences(act) + 1;
           l = size(act_frag, 1);

           if act < 4
               act_frag = [act_frag ; zeros(dyn_act_size - l, 1)];
           elseif act < 6
               act_frag = [act_frag ; zeros(static_act_size - l, 1)];    
           else
               act_frag = [act_frag ; zeros(transition_act_size - l, 1)];
           end          

           [f, m_x] = calc_dft(act_frag, fs, 0, length(act_frag));

           if isempty(cell2mat(dft_freqs(act)))
               dft_freqs(act) = {f(1:end - 1)};
               dft_means(act) = {m_x};
           else
               dft_means(act) = {cell2mat(dft_means(act)) + m_x};   
           end

           label_i = label_i + 1;
       end
  
   end
   
   for i = 1:length(activities)
       dft_means(i) = {cell2mat(dft_means(i)) / num_act_ocurrences(i)};
   end    
end