#######################################################################################################################################################################################################
#
# Changes to these functions
# General
#     2022-Aug-24: move function outside of the folder
#     2022-Aug-24: simply the algorithm
#
#######################################################################################################################################################################################################
"""

    FT_test(para::Array, FT)
    FT_test(para::Number, FT)
    FT_test(para::Union{Function, Module, String, Symbol}, FT)
    FT_test(para::Any, FT)

Return true or false to determine if the FT is consistent, given
- `para` Parameter to run FT control
- `FT` Float type

If the testing variable is an array, the function will test if element type is float number:
- If true, the function tests if the element type is the same as given `FT`
- If false, the function tests each element recursively

The variable to test maybe a struct, but `FT_test` does not know the struct type name a priori. Thus, we try to read out the fields of the variable:
- If succeeds, the function test the fields recursively
- If fails, then do nothing

## Example
```julia
    struct SA
        a
        b
    end;
    sa = SA(1, 2.0);

    ft_1 = FT_test([1, 2, 3], Float64);
    ft_2 = FT_test(Any[1, 1.0f0, 1.0e0], Float64);
    ft_3 = FT_test([1, 2.0, "a"], Float64);
    ft_4 = FT_test(sa, Float64);
```

"""
function FT_test end;

FT_test(para::Array, FT) = (
    # fail if para is float but not FT
    if eltype(para) <: AbstractFloat
        return eltype(para) == FT
    end;

    # test all the elements
    return all(FT_test.(para, FT))
);

FT_test(para::Number, FT) = (
    # fail if para is float but not FT
    if typeof(para) <: AbstractFloat
        return typeof(para) == FT
    end;

    return true
);

FT_test(para::Union{Function, Module, String, Symbol}, FT) = true;

FT_test(para::Any, FT) = (
    # try to detech struct
    if !(typeof(para) <: DataType)
        try
            arr = [];
            for fn in fieldnames( typeof(para) )
                push!(arr, FT_test(getfield(para, fn), FT));
            end;

            return all(arr)
        catch e
            nothing
        end;
    end;

    return true
);
