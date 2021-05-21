function max_dist = get_max_dist(~, signal)
    max_dist = abs(max(signal) - min(signal));
end
