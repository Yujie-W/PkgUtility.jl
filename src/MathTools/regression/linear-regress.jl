"""

    linear_regress(xs::Tuple, y::Vector)

Return the linear regression results, given
- `xs` A tuple of x variables
- `y` A vector of y

---
# Example
```julia
x1 = rand(5);
x2 = rand(5); x2[2] = NaN;
yy = rand(5);
lr1 = linear_regress((x1,), yy);
lr2 = linear_regress((x1,1), yy);
lr3 = linear_regress((x1,x2), yy);
lr4 = linear_regress((x1,x2,1), yy);
```

"""
function linear_regress(xs::Tuple, y::Vector)
    # make sure that the vectors match in dimensions
    for i in eachindex(xs)
        @assert (length(xs[i]) == 1) || (length(xs[i]) == length(y) > 1) "X and Y must have the same dimension";
    end;
    @assert length(xs[1]) > 1 "First X cannot be 1";

    # create a mask to mask out NaN values
    mask = .!isnan.(y);
    for i in eachindex(xs)
        if length(xs[i]) > 1
            mask .= mask .&& .!isnan.(xs[i]);
        end;
    end;

    # copy xs to _matx
    matx = zeros(sum(mask), length(xs));
    vecy = zeros(sum(mask));
    for i in eachindex(xs)
        if length(xs[i]) > 1
            matx[:,i] .= xs[i][mask];
        else
            matx[:,i] .= xs[i];
        end;
    end;
    vecy .= y[mask];

    # run the fitting using GLM
    return LinearRegressionResult(LM = lm(matx, vecy))
end;
