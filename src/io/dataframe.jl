###############################################################################
#
# create DataFrame
#
###############################################################################
"""
Create a data frame from given parameters:

$(METHODLIST)

"""
function dataframe end




"""
If no parameter is passed to `dataframe`, an empty DataFrame will be returned:

    dataframe()

Return an empty DataFrame

---
Example
```julia
df = dataframe();
```
"""
dataframe() = DataFrame()




"""
When a vector of data and a vector of headers are given, `dataframe` returns a DataFrame with the given data and header:

    dataframe(v_data::Vector, v_name::Vector{String})

Return a DataFrame for given
- `v_data` Vector of data
- `v_name` Vector of data header

Note that the data and header vectors must have the same length.
"""
dataframe(v_data::Vector, v_name::Vector{String}) =
(
    @assert length(v_data) == length(v_name);

    _df = dataframe();

    for _i in eachindex(v_data)
        _df[!,v_name[_i]] = v_data[_i];
    end;

    return _df
)
