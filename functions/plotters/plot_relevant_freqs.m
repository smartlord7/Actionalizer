%{
@def plot_relevant_freqs
@brief Function that plots the relevant frequencies of a given signal.

@param freqs
Vector that contains possible frequencies existent in the signal.

@param act_dfts
Vector that contains the signal's DFT.

@param act_names
Vector with names assigned to each activity.

@param threshold
Percentage relative to the max DFT value to consider when extracting the relevant frequencies.

%}
function plot_relevant_freqs(freqs, act_dfts, act_names, threshold)
    figure;
    
    hold on;

    for i = 1:length(act_dfts)
       curr_freqs = cell2mat(freqs(i));
       curr_dft = cell2mat(act_dfts(i));
       [rlv_freqs, rlv_freqs_m] = extract_relevant_freqs(curr_freqs, curr_dft, threshold);
       subplot(4, 3, i);
       stem(rlv_freqs, rlv_freqs_m);
       title(act_names(i));
       xlabel('Frequency (Hz)');
       ylabel('Magnitude');
       point_lbl = sprintfc('%.4f', rlv_freqs);
       text(rlv_freqs, rlv_freqs_m, point_lbl, 'Fontsize', 8);
    end
    
    plt_title = sprintf("Relevant frequencies (threshold of %d%%) - AXIS: %s", threshold * 100, get_axis_name(axis));
    sgtitle(plt_title);
    
    hold off;
end