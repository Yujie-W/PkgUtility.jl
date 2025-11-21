"""

    NaN_test(para::Array)
    NaN_test(para::Number)
    NaN_test(para::Union{Function, Module, String, Symbol})
    NaN_test(para::Any)

Test if the variable is not NaN, given
- `para` Parameter to test

## Example
```julia
    struct SA
        a
        b
    end;

    nan_1 = NaN_test(SA(1,2));
    nan_2 = NaN_test(SA(1,NaN));
    nan_3 = NaN_test([1,2,NaN]);
    nan_4 = NaN_test([1,3,4]);
    nan_5 = NaN_test([1,2,"a"]);
```

"""
function NaN_test end;

NaN_test(para::Array) = all(NaN_test.(para));

NaN_test(para::Number) = !isnan(para);

NaN_test(para::Union{Function, Module, String, Symbol}) = true;

NaN_test(para::Any) = (
    # try to detech struct
    if !(typeof(para) <: DataType)
        try
            arr = [];
            for fn in fieldnames( typeof(para) )
                push!(arr, NaN_test( getfield(para, fn) ));
            end;

            return all(arr)
        catch e
            nothing
        end;
    end;

    return true
);
