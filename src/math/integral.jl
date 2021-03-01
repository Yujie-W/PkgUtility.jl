###############################################################################
#
# Integral functions
#
###############################################################################
"""
    numerical∫(f::Array{FT,1}, dx::Array{FT,1}) where {FT<:AbstractFloat}
    numerical∫(f::Array{FT,1}, dx::FT) where {FT<:AbstractFloat}

A fast way of integrating functions, given
- `f` f(x) for each x
- `dx` Delta x for each x

Note that f and dx must have the same length
"""
function numerical∫(
            f::Array{FT,1},
            dx::Array{FT,1}
) where {FT<:AbstractFloat}
    if length(dx) == length(f)
        return f' * dx
    else
        @warn "Dimensions not matching, use the matching parts only";
        N = min(length(f), length(dx));
        return adjoint(view(f,1:N)) * view(dx,1:N)
    end
end




function numerical∫(
            f::Array{FT,1},
            dx::FT
) where {FT<:AbstractFloat}
    return sum(f) * abs(dx)
end
