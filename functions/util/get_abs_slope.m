%{
@def get_abs_slope
@brief Function that gets the slope of the linear regression for a certain
interval.

@param domain
Interval of values on which the linear regression will be applied.

@param signal
Vector with the values to consider.

@return slope - slope of the 1st degree polynomial resultant of the linear regression applied on the signal.
%}
function slope = get_abs_slope(domain, signal)
    slope = polyfit(domain, signal, 1);
    slope = abs(slope(1));
end