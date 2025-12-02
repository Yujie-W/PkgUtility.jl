"""

    test_slope(xs::Tuple, y::Vector; slope::Number = 0)

Return the P value of whether linear regression is same as the provided slope, given
- `xs` A tuple of x variables
- `y` A vector of y
- `slope` Target slope

---
# Example
```julia
x1 = rand(5);
yy = rand(5);
p1 = test_slope((x1,), yy; slope = 0);
p2 = test_slope((x1,1), yy; slope = 1);
```

"""
function test_slope(xs::Tuple, y::Vector; slope::Number = 0)
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
    vecy .= y[mask] .- slope .* xs[1][mask];

    # run the fitting using GLM
    lr = lm(matx, vecy);

    return coeftable(lr).cols[4][1]
end;
