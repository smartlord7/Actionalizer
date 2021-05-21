function max_amplitude = get_max_amplitude(domain, signal)
    [~, dft] = calc_dft(signal, 50, domain(1), domain(end));
    max_amplitude = max(dft);
end
