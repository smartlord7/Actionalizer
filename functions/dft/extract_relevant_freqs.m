function [rlv_freqs, rlv_freqs_m] = extract_relevant_freqs(freqs, dft, threshold)
     max_magnitude = max(dft);
     min_magnitude = threshold * max_magnitude;
     [peaks, peaks_location] = findpeaks(dft, 'MinPeakheight', min_magnitude);
     peaks = peaks(end / 2 + 1:end);
     peaks_location = peaks_location(end / 2 + 1:end);
         
     rlv_freqs = freqs(peaks_location);
     rlv_freqs_m = peaks;
end