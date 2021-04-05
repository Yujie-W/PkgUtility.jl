###############################################################################
#
# Integral functions
#
###############################################################################
"""
Function `numerical∫` calculates the integral numerically. The supported
    methods are

$(METHODLIST)

"""
function numerical∫ end




"""
When two arrays (one for f(x) and one for Δx) are provided, `numerical∫`
    computes the sum of the mutiplication of the two using matrix mutiplication
    `fxs' * Δxs`.

    numerical∫(f::Array{FT,1}, Δx::Array{FT,1}) where {FT<:AbstractFloat}

Intergal of given
- `f` f(x) for each x
- `Δx` Δx for each x

Note that f and Δx may have different dimensions, and if so a warning will
    display.

---
Examples
```julia
FT = Float32;
f_sum = numerical∫(FT[1,2,3,4], FT[0.1,0.1,0.2,0.3]);
```
"""
numerical∫(f::Array{FT,1}, Δx::Array{FT,1}) where {FT<:AbstractFloat} =
(
    if length(Δx) == length(f)
        return f' * Δx
    else
        @warn twarn("Dimensions not matching, use the matching parts only...");
        N = min(length(f), length(Δx));
        return adjoint(view(f,1:N)) * view(Δx,1:N)
    end
)




"""
The above methods is useful for both evenly and non-evenly distributed `Δx`.
    However, for many cases `Δx` is evenly distributed and provided as a number
    rather than an array. In this scenario, a special method is given:

    numerical∫(f::Array{FT,1}, Δx::FT) where {FT<:AbstractFloat}

Intergal of given
- `f` f(x) for each x
- `Δx` Δx for x

---
Examples
```julia
FT = Float32;
f_sum = numerical∫(FT[1,2,3,4], FT(0.1));
```
"""
numerical∫(f::Array{FT,1}, Δx::FT) where {FT<:AbstractFloat} =
(
    return sum(f) * abs(Δx)
)




"""
We also provide a function to manually solve for the integral of a given
    function for a given range of x. The method is

    numerical∫(f::Function,
               x_min::FT,
               x_max::FT,
               n::Int
    ) where {FT<:AbstractFloat}

Intergal of given
- `f` A function
- `x_min` Minimum limit of x
- `x_max` Maximum limit of x
- `n` Number of points in the x range (evenly stepped)

---
Examples
```julia
FT = Float32;
func(x) = x^2;
f_sum = numerical∫(func, FT(0), FT(2), 20);
```
"""
numerical∫(f::Function,
           x_min::FT,
           x_max::FT,
           n::Int
) where {FT<:AbstractFloat} =
(
    _sum = 0;
    _dx  = (x_max - x_min) / n;
    for _i in 1:n
        _x = x_min + FT(_i-0.5) * _dx;
        _sum += f(_x);
    end;

    return _sum * _dx;
)




"""
This method automatically computes the integral of a function for an `x` within
    a range:

    numerical∫(f::Function,
               x_min::FT,
               x_max::FT,
               x_tol::FT = sqrt(eps(FT)),
               y_tol::FT = sqrt(eps(FT))
    ) where {FT<:AbstractFloat}

Intergal of given
- `f` A function
- `x_min` Minimum limit of x
- `x_max` Maximum limit of x
- `x_tol` Tolerance of Δx (x/N)
- `y_tol` Tolerance of the integral solution

---
Example
```julia
FT = Float32;
func(x) = x^2;
f_sum = numerical∫(func, FT(0), FT(2));
f_sum = numerical∫(func, FT(0), FT(2), FT(1e-3), FT(1e-3));
```
"""
numerical∫(f::Function,
           x_min::FT,
           x_max::FT,
           x_tol::FT = sqrt(eps(FT)),
           y_tol::FT = sqrt(eps(FT))
) where {FT<:AbstractFloat} =
(
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
)
