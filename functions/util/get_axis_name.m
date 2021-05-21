%{
@def axis_name
@brief Function that identifies the axis associated with the given value.

@param axis_idx
Value to be associated with one of the axis.

@param signal
Vector with the values to consider.

@return axis_name - name of the axis identified.
%}
function axis_name = get_axis_name(axis_idx)
    switch axis_idx
        case 1
            axis_name = 'X';
        case 2
            axis_name = 'Y';
        case 3
            axis_name = 'Z';    
    end
end

