function [f, m_x] = calc_dft(dataset, fs, start, finish)
    N = finish - start + 1;

    dft_x = fftshift(fft(dataset));

    if mod(N, 2) == 0
        f = -fs/2:fs/N:fs/2-fs/N;
    else
        f = -fs/2 + fs/(2 * N):fs/N:fs/2-fs/(2 * N);
    end

    m_x = abs(dft_x);
end