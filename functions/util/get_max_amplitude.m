function max_amplitude = get_max_amplitude(~, signal)
    [~, dft] = calc_dft(signal, 50, 1, length(signal));
    max_amplitude = max(dft);
end
