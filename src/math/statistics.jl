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
    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return maximum( _x )
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
    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return mean( _x )
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
    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return median( _x )
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
    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return minimum( _x )
end




"""

    nanpercentile(x::Array, p::Number)

Return the percentile by excluding the NaN of given
- `x` Array of data
- `p` Percentile

---
Example
```julia
xs = rand(100);
pth = nanpercentile(rand(100), 50);
xs[1:10] .= NaN;
pth = nanpercentile(rand(100), 50);
```
"""
function nanpercentile(x::Array, p::Number)
    @assert 0 <= p <= 100

    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return percentile( _x, p )
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
    _x = filter(!isnan, x);

    if length(_x) == 0 return NaN end;

    return std( _x )
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
    _mean = abs( nanmean(y) );
    _diff = abs.(y .- pred) ./ _mean .* 100;

    return nanmean( _diff )
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
    _nstd = nanstd(y);
    _diff = abs.(y .- pred) ./ _nstd .* 100;

    return nanmean( _diff )
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
