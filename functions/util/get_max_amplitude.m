%{
@def get_max_amplitude
@brief 

@param domain

@param signal

@return max_amplitude
%}
function max_amplitude = get_max_amplitude(~, signal)
    [~, dft] = calc_dft(signal, 50, 1, length(signal));
    max_amplitude = max(dft);
end