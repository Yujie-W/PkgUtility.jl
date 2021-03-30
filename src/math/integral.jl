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
"""
numerical∫(f::Array{FT,1}, Δx::Array{FT,1}) where {FT<:AbstractFloat} =
(
    if length(Δx) == length(f)
        return f' * Δx
    else
        @warn "Dimensions not matching, use the matching parts only";
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
               x_max::FT;
               n::Int = 20
    ) where {FT<:AbstractFloat}

Intergal of given
- `f` A function
- `x_min` Minimum limit of x
- `x_max` Maximum limit of x
- `n` Number of points in the x range (evenly stepped). Default is 20.
"""
numerical∫(f::Function,
           x_min::FT,
           x_max::FT;
           n::Int = 20
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
