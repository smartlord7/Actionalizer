%{
@def extract_relevant_freqs
@brief Function that calculates the STFT for a given vector of frequencies.

@param freqs
Vector with all of the frequencies to consider.

@param dft
Vector with all of the values of DFT associated with the given frequencies.

@param threshold
The threshold to consider when finding the relevant frequencies.

@return rlv_freqs - vector with the relevant frequencies obtained.
        rlv_freqs_m -  vector with the magnitudes associated to each frequency obtained.
%}
function [rlv_freqs, rlv_freqs_m] = extract_relevant_freqs(freqs, dft, threshold)

    % obtain the maximum frequency
    max_magnitude = max(dft);
    
    % define the minimal frequency to consider
    min_magnitude = threshold * max_magnitude;
    
    % find all the frequencies superior to the threshold considered and
    % their respective locations
    [peaks, peaks_location] = findpeaks(dft, 'MinPeakheight', min_magnitude);
    peaks = peaks(end / 2 + 1:end);
    peaks_location = peaks_location(end / 2 + 1:end);
    
    rlv_freqs = freqs(peaks_location);
    rlv_freqs_m = peaks;
end