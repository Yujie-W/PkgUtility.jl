#######################################################################################################################################################################################################
#
# Changes to the function
# General
#     2022-Oct-17: move functions outside of the folder
#     2023-Jan-19: move functions to EmeraldMath
#     2023-Mar-10: move function to Emerald
#
#######################################################################################################################################################################################################
"""

    lower_quadratic(a::FT, b::FT, c::FT) where {FT}

Return the lower quadratic solution or NaN, given
- `a` Parameter in `a*x^2 + b*x + c = 0`
- `b` Parameter in `a*x^2 + b*x + c = 0`
- `c` Parameter in `a*x^2 + b*x + c = 0`

"""
function lower_quadratic(a::FT, b::FT, c::FT) where {FT}
    discr = b^2 - 4*a*c;

    if (discr >= 0) && (a > 0)
        return (-b - sqrt(discr)) / (2 * a)
    elseif (discr >= 0) && (a < 0)
        return (-b + sqrt(discr)) / (2 * a)
    else
        return FT(NaN)
    end;
end;


"""

    upper_quadratic(a::FT, b::FT, c::FT) where {FT}

Return the upper quadratic solution or NaN, given
- `a` Parameter in `a*x^2 + b*x + c = 0`
- `b` Parameter in `a*x^2 + b*x + c = 0`
- `c` Parameter in `a*x^2 + b*x + c = 0`

"""
function upper_quadratic(a::FT, b::FT, c::FT) where {FT}
    discr = b^2 - 4*a*c;

    if (discr >= 0) && (a > 0)
        return (-b + sqrt(discr)) / (2 * a)
    elseif (discr >= 0) && (a < 0)
        return (-b - sqrt(discr)) / (2 * a)
    else
        return FT(NaN)
    end;
end;
