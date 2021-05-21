%{
@def get_axis_name
@brief Function that associates a given value with an axis.

@param axis_idx
Value to associate with an axis.

@return axis_name - name of the axis.
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

