###############################################################################
#
# Recursive FT test
#
###############################################################################
"""
Using consistent floating number type may accelerate calculations, particularly for GPUs. Thus, we provided a function to test the floating number type
    recursively:


"""
function FT_test end




"""
If the testing variable is an array, the function will test if element type is float number:
- If true, the function tests if the element type is the same as given `FT`
- If false, the function tests each element recursively

    FT_test(para::Array, FT)

Test the the floating point type of a variable, given
- `para` An array
- `FT` given FT

---
Example
```julia
ft_1 = FT_test([1, 2, 3], Float64);
ft_2 = FT_test(Any[1, 1.0f0, 1.0e0], Float64);
ft_3 = FT_test([1, 2.0, "a"], Float64);
```
"""
FT_test(para::Array, FT) =
(
    passed = true;

    # fail if para is float but not FT
    if eltype(para) <: AbstractFloat
        if eltype(para) != FT
            passed = false;
        end;
    else
        if !all(FT_test.(para, FT))
            passed = false;
        end;
    end;

    return passed
)




"""
When the given variable is a number, the following criteria are used based on the type of the number
- If the variable is a float, then compare it to `FT`
- Otherwise, return true (because integers can be mix-used with floats)

    FT_test(para::Number, FT)

Test the the floating point type of a variable, given
- `para` A number
- `FT` given FT

Example
```julia
ft_1 = FT_test(1, Float64);
ft_2 = FT_test(1.0, Float64);
ft_3 = FT_test(1.0f0, Float64);
```
"""
FT_test(para::Number, FT) =
(
    passed = true;

    # fail if para is float but not FT
    if typeof(para) <: AbstractFloat
        if typeof(para) != FT
            passed = false;
        end;
    end;

    return passed
)




"""
If the variable is a function, module, or symbol, then nothing will be done, and a true will be returned. This method is to avoid endless nested loop
    within the test of Function or Module:

    FT_test(para::Union{Function,Module,Symbol})

Test the the floating point type of a variable, given
- `para` An array
- `FT` given FT

---
Example
```julia
f(x) = x^2;
m = CLIMAParameters;

ft_1 = FT_test(f, Float64);
ft_2 = FT_test(m, Float64);
ft_3 = FT_test("haha", Float64);
```
"""
FT_test(para::Union{Function,Module,Symbol}) = true




"""
The variable to test maybe a struct, but `FT_test` does not know the struct type name a priori. Thus, we try to read out the fields of the variable:

- If succeeds, the function test the fields recursively
- If fails, then do nothing

    FT_test(para::Any, FT)

Test the the floating point type of a variable, given
- `para` A function, module, or symbol
- `FT` given FT

---
Example
```julia
struct SA
    a
    b
end
sa = SA(1, 2.0);

ft_1 = FT_test(sa);
ft_2 = FT_test();
```
"""
FT_test(para::Any, FT) =
(
    passed = true;

    # try to detech struct
    if !(typeof(para) <: DataType)
        try
            arr = [];
            for fn in fieldnames( typeof(para) )
                push!(arr, FT_test( getfield(para, fn), FT ));
            end;
            if !all(arr)
                passed = false;
            end;
        catch e
            nothing
        end;
    end;

    return passed
)








###############################################################################
#
# Recursive NaN test
#
###############################################################################
"""
Like [`FT_test`](@ref), same logic is used to test if all the elements within the tested variable are not NaN:


"""
function NaN_test end




"""
When an array is passed to the function, the function first determines if the variable is an array of number:

- If true, the function tests each element within the array directly
- If false, the function tests each element recursively

    NaN_test(para::Array)

Test the the floating point type of para is not NaN, given
- `para` An array

---
Example
```julia
nan_1 = NaN_test([1,2,NaN]);
nan_2 = NaN_test([1,3,4]);
nan_3 = NaN_test([1,2,"a"]);
```
"""
NaN_test(para::Array) =
(
    passed = true;

    # fail if para is number
    if eltype(para) <: Number
        if !all(.!isnan.(para))
            passed = false;
        end;
    else
        if !all(NaN_test.(para))
            passed = false;
        end;
    end;

    return passed
)




"""
If the variable is a number, the function tests if the number is NaN directly:

    NaN_test(para::Number)

Test if the variable is NaN, given
- `para` A number

---
Example
```julia
nan_1 = NaN_test(1);
nan_2 = NaN_test(NaN);
```
"""
NaN_test(para::Number) = !isnan(para)




"""
If the variable is a function, module, or symbol, then nothing will be done, and a true will be returned. This method is to avoid endless nested loop
    within the test of Function or Module:

    NaN_test(para::Union{Function,Module,Symbol})

Test the the floating point type of a variable, given
- `para` A function, module, or symbol

---
Example
```julia
f(x) = x^2;
m = CLIMAParameters;

nan_1 = NaN_test(f);
nan_2 = NaN_test(m);
nan_3 = NaN_test("haha");
```
"""
NaN_test(para::Union{Function,Module,Symbol}) = true




"""
If the given variable is a struct, the function will test the fields recursively:

    NaN_test(para::Any)

Test if the variable contains any NaN, given
- `para` Tested variable

---
Example
```julia
struct SA
    a
    b
end

nan_1 = NaN_test(SA(1,2));
nan_2 = NaN_test(SA(1,NaN));
```
"""
NaN_test(para::Any) =
(
    passed = true;

    # try to detech struct
    if !(typeof(para) <: DataType)
        try
            arr = [];
            for fn in fieldnames( typeof(para) )
                push!(arr, NaN_test( getfield(para, fn) ));
            end;
            if !all(arr)
                passed = false;
            end;
        catch e
            nothing
        end;
    end;

    return passed
)
