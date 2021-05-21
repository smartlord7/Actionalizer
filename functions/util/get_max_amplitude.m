%{
@def max_amplitude
@brief Function that gets the maximum value in the DFT of the given signal.

@param signal
Signal to be considered.

@return max_amplitude - maximum value found.
%}
function max_amplitude = get_max_amplitude(~, signal)
    [~, dft] = calc_dft(signal, 50, 1, length(signal));
    max_amplitude = max(dft);
end
