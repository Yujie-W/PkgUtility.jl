"""

    NaN_test(para::Array)
    NaN_test(para::Number)
    NaN_test(para::Union{Function, Module, String, Symbol})
    NaN_test(para::Any)

Test if the variable is not NaN, given
- `para` Parameter to test

"""
function NaN_test end;

NaN_test(para::Number) = !isnan(para);

NaN_test(para::Array) = all(NaN_test.(para));

NaN_test(para::Tuple) = all(NaN_test.(para));

NaN_test(para::DataType) = true;

NaN_test(para::Union{Function, Module, String, Symbol}) = true;

NaN_test(para::Union{Dict,OrderedDict}) = (
    arr = [];
    for (_,v) in para
        push!(arr, NaN_test(v));
    end;

    return all(arr)
);

NaN_test(para::ST) where {ST} = (
    if isstructtype(ST)
        arr = [];
        for fn in fieldnames( typeof(para) )
            push!(arr, NaN_test(getfield(para, fn)));
        end;

        return all(arr)
    end;

    return error("Unsupported type by NaN_test!")
);
