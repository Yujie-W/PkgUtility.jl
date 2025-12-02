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

FT_test(para::Union{Dict,OrderedDict}, FT) = (
    arr = [];
    for (_,v) in para
        push!(arr, FT_test(v, FT));
    end;

    return all(arr)
);

FT_test(para::Number, FT) = (
    # fail if para is float but not FT
    if typeof(para) <: AbstractFloat
        return typeof(para) == FT
    end;

    return true
);

FT_test(para::Union{Function, Module, String, Symbol}, FT) = true;

FT_test(para::ST, FT) where {ST} = (
    # try to detech struct
    if isstructtype(ST)
        arr = [];
        for fn in fieldnames( typeof(para) )
            push!(arr, FT_test(getfield(para, fn), FT));
        end;

        return all(arr)
    end;

    return error("Unsupported type by FT_test!")
);
