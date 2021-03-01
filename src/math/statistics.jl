###############################################################################
#
# nanmean, nanstd, nanmax, nanmin
#
###############################################################################
"""
    nanmax(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN
"""
function nanmax(x::Array)
    return maximum( x[.!isnan.(x)] )
end




"""
    nanmean(x::Array)

Return the mean of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN
"""
function nanmean(x::Array)
    return mean( x[.!isnan.(x)] )
end




"""
    nanmin(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN
"""
function nanmin(x::Array)
    return minimum( x[.!isnan.(x)] )
end




"""
    nanstd(x::Array)

Return the std of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN
"""
function nanstd(x::Array)
    return std( x[.!isnan.(x)] )
end








###############################################################################
#
# Error measures
#
###############################################################################
"""
    mae(y::Array, pred::Array)

Return the mean absolute error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN
"""
function mae(y::Array, pred::Array)
    return nanmean( abs.(y .- pred) )
end




"""
    mape(y::Array, pred::Array)

Return the mean absolute percentage error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN
"""
function mape(y::Array, pred::Array)
    aver = abs( nanmean(y) );
    diff = abs.(y .- pred) ./ aver .* 100;

    return nanmean( diff )
end




"""
    mase(y::Array, pred::Array)

Return the mean absolute standardized error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN
"""
function mase(y::Array, pred::Array)
    nstd = nanstd(y);
    diff = abs.(y .- pred) ./ nstd .* 100;

    return nanmean( diff )
end




"""
    rmse(y::Array, pred::Array)

Return the root mean square error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN
"""
function rmse(y::Array, pred::Array)
    return sqrt( nanmean( (y .- pred) .^ 2 ) )
end
