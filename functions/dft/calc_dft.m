%{
@def calc_dft
@brief Function that calculates the DFT for a given dataset.

@param dataset
Dataset to use on DFT calculation.

@param fs
Sample frequency used when capturing the values on the dataset.

@param start
Initial index of the dataset to consider.

@param finish
Final index of the dataset to consider.

@return f - vector with frequencies present in the calculated DFT.
        m_x -  vector with the magnitudes associated to each frequency obtained.
%}
function [f, m_x] = calc_dft(dataset, fs, start, finish)

    % define the length of the dataset interval to consider
    N = finish - start + 1;
    
    % calculate the DFT
    dataset = detrend(dataset);
    dft_x = fftshift(fft(dataset));

    % obtain the frequency vector
    if mod(N, 2) == 0
        f = -fs/2:fs/N:fs/2-fs/N;
    else
        f = -fs/2 + fs/(2 * N):fs/N:fs/2-fs/(2 * N);
    end
    
    % obtain the magnitude vector
    m_x = abs(dft_x) ;
end