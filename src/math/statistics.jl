###############################################################################
#
# nanmean, nanmedian, nanstd, nanmax, nanmin
#
###############################################################################
"""

    nanmax(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN

---
Example
```julia
xs = [1, 2, 4, NaN];
nmax = nanmax(xs);
```
"""
function nanmax(x::Array)
    return maximum( filter(!isnan, x) )
end




"""

    nanmean(x::Array)

Return the mean of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

---
Example
```julia
xs = [1, 2, 4, NaN];
nmean = nanmean(xs);
```
"""
function nanmean(x::Array)
    return mean( filter(!isnan, x) )
end




"""

    nanmedian(x::Array)

Return the median of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

---
Example
```julia
xs = [1, 2, 4, NaN];
nmed = nanmedian(xs);
```
"""
function nanmedian(x::Array)
    return median( filter(!isnan, x) )
end




"""

    nanmin(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN

---
Example
```julia
xs = [1, 2, 4, NaN];
nmin = nanmin(xs);
```
"""
function nanmin(x::Array)
    return minimum( filter(!isnan, x) )
end




"""

    nanstd(x::Array)

Return the std of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

---
Example
```julia
xs = [1, 2, 4, NaN];
nstd = nanstd(xs);
```
"""
function nanstd(x::Array)
    return std( filter(!isnan, x) )
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

---
Example
```julia
ys = [1, 2, 4, NaN];
preds = [2, 4, 1, NaN];
nmae = mae(ys, preds);
```
"""
function mae(y::Array, pred::Array)
    return nanmean( abs.(y .- pred) )
end




"""

    mape(y::Array, pred::Array)

Return the mean absolute percentage error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN

---
Example
```julia
ys = [1, 2, 4, NaN];
preds = [2, 4, 1, NaN];
nmape = mape(ys, preds);
```
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

---
Example
```julia
ys = [1, 2, 4, NaN];
preds = [2, 4, 1, NaN];
nmase = mase(ys, preds);
```
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

---
Example
```julia
ys = [1, 2, 4, NaN];
preds = [2, 4, 1, NaN];
rmse = rmse(ys, preds);
```
"""
function rmse(y::Array, pred::Array)
    return sqrt( nanmean( (y .- pred) .^ 2 ) )
end
