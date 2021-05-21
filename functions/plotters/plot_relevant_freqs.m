function plot_relevant_freqs(freqs, act_dfts, act_names, threshold)
    figure;

    for i = 1:length(act_dfts)
       curr_freqs = cell2mat(freqs(i));
       curr_dft = cell2mat(act_dfts(i));
       [rlv_freqs, rlv_freqs_m] = extract_relevant_freqs(curr_freqs, curr_dft, threshold);
       subplot(4, 3, i);
       stem(rlv_freqs, rlv_freqs_m);
       title(act_names(i));
    end
end