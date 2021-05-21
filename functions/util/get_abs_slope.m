function slope = get_abs_slope(domain, signal)
    slope = polyfit(domain, signal, 1);
    slope = abs(slope(1));
end