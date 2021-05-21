function [f, m_x] = calc_dft(dataset, fs, N)
    dataset = detrend(dataset);
    dft_x = fftshift(fft(dataset));

    if mod(N, 2) == 0
        f = -fs/2:fs/N:fs/2-fs/N;
    else
        f = -fs/2 + fs/(2 * N):fs/N:fs/2-fs/(2 * N);
    end
    
    m_x = (abs(dft_x) ./ N) * 2;
end