function plot_dfts(datasets, fs, labels)
   len = size(datasets, 1);
   label_i = 1;
   ts = 1/fs;
   
   for i = 1:1
       dataset = reshape(datasets(i,:,:), size(datasets(i,:,:), 2), size(datasets(i,:,:), 3));
       init_label = label_i;
       
       for k = 1:1
           label_i = init_label;
           
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
               
               [f, m_x] = calc_dft(dataset(start:finish, k), fs, start, finish);
               
               figure;
               plt_title = sprintf('DFT - Experience %d, User %d', exp, user);
               title(plt_title);
               xlabel('Frequency (Hz)');
               switch k
                   case 1
                      ylabel('ACC angle freq. magnitude - x (rad)');
                   case 2
                      ylabel('ACC angle freq. magnitude - y (rad)');
                   case 3
                      ylabel('ACC angle freq. magnitude - z (rad)');
               end
               
               plot(f, m_x);
              
               label_i = label_i + 1;
           end
       end
   end
end
