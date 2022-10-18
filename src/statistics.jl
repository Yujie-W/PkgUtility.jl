#######################################################################################################################################################################################################
#
# Changes to the function
# General
#     2022-Oct-17: move function outside of the folder
#
#######################################################################################################################################################################################################
"""

    numerical∫(f::Vector{FT}, Δx::Vector{FT}) where {FT<:AbstractFloat}
    numerical∫(f::Vector{FT}, Δx::FT) where {FT<:AbstractFloat}

Return the intergal of given
- `f` f(x) for each x
- `Δx` Δx for x

    numerical∫(f::Function, x_min::FT, x_max::FT, n::Int) where {FT<:AbstractFloat}
    numerical∫(f::Function, x_min::FT, x_max::FT, x_tol::FT = sqrt(eps(FT)), y_tol::FT = sqrt(eps(FT))) where {FT<:AbstractFloat}

Return the integral of given
- `f` A function
- `x_min` Minimum limit of x
- `x_max` Maximum limit of x
- `n` Number of points in the x range (evenly stepped)
- `x_tol` Tolerance of Δx (x/N)
- `y_tol` Tolerance of the integral solution

"""
function numerical∫ end

numerical∫(f::Vector{FT}, Δx::Vector{FT}) where {FT<:AbstractFloat} = (
    if length(Δx) == length(f)
        return f' * Δx
    end;

    @warn twarn("Dimensions not matching, use the matching parts only...");
    N = min(length(f), length(Δx));
    return view(f,1:N)' * view(Δx,1:N)
);

numerical∫(f::Vector{FT}, Δx::FT) where {FT<:AbstractFloat} = sum(f) * abs(Δx);

numerical∫(f::Function, x_min::FT, x_max::FT, n::Int) where {FT<:AbstractFloat} = (
    _sum = 0;
    _dx  = (x_max - x_min) / n;
    for _i in 1:n
        _x = x_min + FT(_i-0.5) * _dx;
        _sum += f(_x);
    end;

    return _sum * _dx
);

numerical∫(f::Function, x_min::FT, x_max::FT, x_tol::FT = sqrt(eps(FT)), y_tol::FT = sqrt(eps(FT))) where {FT<:AbstractFloat} = (
    @assert y_tol > 0;

    # _sum_0: sum before halfing steps (_N), _sum_N: sum after halfing steps
    _sum_0::FT = (f(x_min) + f(x_max)) / 2;
    _sum_N::FT = 0;
    _N = 1;

    # continue the steps till the tolerances are reached
    while true
        _sum_N = (numerical∫(f, x_min, x_max, _N) + _sum_0) / 2;
        if abs(_sum_N - _sum_0) < y_tol || 1/_N < x_tol
            break;
        end;
        _sum_0 = _sum_N;
        _N *= 2;
    end;

    return _sum_N
);


#######################################################################################################################################################################################################
#
# Changes to the function
# General
#     2022-Oct-17: move function outside of the folder
#
#######################################################################################################################################################################################################
"""

    lower_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}

Return the lower quadratic solution or NaN, given
- `a` Parameter in `a*x^2 + b*x + c = 0`
- `b` Parameter in `a*x^2 + b*x + c = 0`
- `c` Parameter in `a*x^2 + b*x + c = 0`

"""
function lower_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}
    discr = b^2 - 4*a*c;

    if (discr >= 0) && (a > 0)
        return (-b - sqrt(discr)) / (2 * a)
    elseif (discr >= 0) && (a < 0)
        return (-b + sqrt(discr)) / (2 * a)
    else
        return FT(NaN)
    end
end


#######################################################################################################################################################################################################
#
# Changes to the function
# General
#     2022-Oct-17: move function outside of the folder
#
#######################################################################################################################################################################################################
"""

    upper_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}

Return the upper quadratic solution or NaN, given
- `a` Parameter in `a*x^2 + b*x + c = 0`
- `b` Parameter in `a*x^2 + b*x + c = 0`
- `c` Parameter in `a*x^2 + b*x + c = 0`

"""
function upper_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}
    discr = b^2 - 4*a*c;

    if (discr >= 0) && (a > 0)
        return (-b + sqrt(discr)) / (2 * a)
    elseif (discr >= 0) && (a < 0)
        return (-b - sqrt(discr)) / (2 * a)
    else
        return FT(NaN)
    end
end


#######################################################################################################################################################################################################
#
# Changes to the functions
# General
#     2022-Oct-17: move functions outside of the folder
#
#######################################################################################################################################################################################################
"""

    nanmax(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN

"""
function nanmax(x::Array)
    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : maximum( _x )
end


"""

    nanmean(x::Array)

Return the mean of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

"""
function nanmean(x::Array)
    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : mean( _x )
end


"""

    nanmedian(x::Array)

Return the median of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

"""
function nanmedian(x::Array)
    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : median( _x )
end


"""

    nanmin(x::Array)

Return the maximum of array ommiting the NaN, given
- `x` Array of numbers, can be NaN

"""
function nanmin(x::Array)
    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : minimum( _x )
end


"""

    nanpercentile(x::Array, p::Number)

Return the percentile by excluding the NaN of given
- `x` Array of data
- `p` Percentile in `[%]`

"""
function nanpercentile(x::Array, p::Number)
    @assert 0 <= p <= 100

    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : percentile( _x, p )
end


"""

    nanstd(x::Array)

Return the std of array by ommiting the NaN, given
- `x` Array of numbers, can be NaN

```
"""
function nanstd(x::Array)
    _x = filter(!isnan, x);

    return length(_x) == 0 ? NaN : std( _x )
end


#######################################################################################################################################################################################################
#
# Changes to the functions
# General
#     2022-Oct-17: move functions outside of the folder
#
#######################################################################################################################################################################################################
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
    _mean = abs( nanmean(y) );
    _diff = abs.(y .- pred) ./ _mean .* 100;

    return nanmean( _diff )
end


"""

    mase(y::Array, pred::Array)

Return the mean absolute standardized error by ommiting the NaN, given
- `y` Array of numbers, can be NaN
- `pred` Array of predictions, can be NaN

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

"""
function rmse(y::Array, pred::Array)
    return sqrt( nanmean( (y .- pred) .^ 2 ) )
end
