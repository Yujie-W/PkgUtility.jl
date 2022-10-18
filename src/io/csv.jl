#=
###############################################################################
#
# read CSV file as DataFrame
#
###############################################################################
"""
Reading CSV file may be troublesome for many cases, for example, when some lines exist before the header or when a few unit lines exist after the header.
    Here we provide a generalized function to read CSV files:


"""
function read_csv end




"""
When there is no unit row in the CSV file, the method is given as

    read_csv(file::String; skiprows::Int = 0, displaying::Bool = false)

Read CSV file as a DataFrame, given
- `file` Path to CSV file
- `skiprows` Rows to skip

---
Example
```julia
# read CSV without skipping any rows
df = read_csv("test.csv");
df = read_csv("test.csv"; skiprows=0, displaying=true);

# skip first 2 rows
df = read_csv("test.csv"; skiprows=2, displaying=true);
```
"""
read_csv(file::String; skiprows::Int = 0, displaying::Bool = false) =
(
    if displaying @info tinfo("Reading data from $(file)..."); end;

    return DataFrame(File(file; header=skiprows+1))
)








###############################################################################
#
# save DataFrame to CSV file
#
###############################################################################
"""
Saving data to CSV file may also be troublesome when we want to save the data using a known format, for example, when we want to save attributes in the
    file as well such as the units. To best use Julia, we provide a generalized function to save data as CSV:


"""
function save_csv! end




"""
To save the data as a plain CSV without any attribute information, one may use one of these functions. Note that the sequence of the data frame and file
    name does not matter as the function will automatically recognize the sequence:

    save_csv!(df::DataFrame, file::String; displaying::Bool = false)
    save_csv!(file::String, df::DataFrame; displaying::Bool = false)

Save data to CSV file, given
- `df` A DataFrame
- `file` Path of the target CSV file

---
Example
```julia
# save data to CSV without any rows to skip
df = read_csv("in.csv"; skiprows=2);
save_csv!(df, "out.csv");
save_csv!("out.csv", df);
```
"""
save_csv!(df::DataFrame, file::String; displaying::Bool = false) =
(
    if displaying @info tinfo("Data written to $(file)..."); end;
    write(file, df);

    return nothing
)




save_csv!(file::String, df::DataFrame; displaying::Bool = false) =
    save_csv!(df, file; displaying=displaying)




"""
In many cases, one might have the data as Vector or Matrix, for example, the result from multiple threading calculations using `pmap`. In this case,
    converting the data to a DataFrame and then save the DataFrame may be the best case here. However, the results from pmap may be a Vector (R) of Vector
    (N), or a Vector (R) of Matrix (1×N), or a Vector (R) of Tuple, or a Vector of combinations. While it is possible to use `vcat` or `hcat` to recast the
    results to certain format, one needs to be really cautious about the recasting. Here we provide a wrapper function to automatically detect the result
    format and save the data. Again, one may reverse the order of file name and data in the function parameter list:

    save_csv!(file::String,
              data::Vector,
              var_names::Vector{String};
              per_row::Bool=true)
    save_csv!(data::Vector,
              var_names::Vector{String},
              file::String;
              per_row::Bool=true)

Save data to CSV file, given
- `file` Path of the target CSV file
- `data` A Vector of data, needs to be a Vector of Tuple (N), Vector (N), or Matrix (1×N)
- `var_name` Variable names appear in the CSV file
- `per_row` If true, item in the data Vector is treated as row; othrewise, the data item is treated as column

---
Example
```julia
# when data has equal length
save_csv!("test.csv", [(1,2), (1,2)], ["A", "B"]);
save_csv!("test.csv", [[1,2], [1,2]], ["A", "B"]);
save_csv!("test.csv", [[1 2], [1 2]], ["A", "B"]);
save_csv!("test.csv", [[1,2], [1 2], (1,2)], ["A", "B"]);

# when data has unequal length
save_csv!("test.csv", [(1,2), [1 2 3], [1,2,3,4]], ["A", "B"]);
save_csv!("test.csv", [(1,2), [1 2 3], [1,2,3,4]], ["A", "B", "C", "D", "E"]);

# use data item as column rather than row (default)
save_csv!("test.csv", [[1 2], [1 2]], ["A", "B"]; per_row=false);
save_csv!("test.csv", [[1 2], [1 2 3]], ["A", "B"]; per_row=false);
```
"""
save_csv!(file::String,
          data::Vector,
          var_names::Vector{String};
          per_row::Bool=true) =
(
    # judge if all data have the same length
    _judge = all( [length(data[1])==length(data[_i]) for _i in eachindex(data)] );

    # if not the same length, fill the rest with missing
    if !_judge
        _maxl = maximum( [length(data[_i]) for _i in eachindex(data)] );
        _mat  = Matrix(undef, length(data), _maxl);
        for _i in eachindex(data)
            _mat[_i,1:length(data[_i])] .= data[_i][:];
            _mat[_i,length(data[_i])+1:_maxl] .= missing;
        end;
    else
        _mat = Matrix(undef, length(data), length(data[1]));
        for _i in eachindex(data)
            _mat[_i,:] .= data[_i][:];
        end;
    end;

    # convert the data if per_row if false
    if !per_row _mat = _mat' end;

    # determine if the length of the var names match the data
    if length(var_names) == size(_mat,2)
        _var = var_names;
    elseif length(var_names) > size(_mat,2)
        _var = var_names[1:size(_mat,2)];
    else
        _var = [var_names; ["x$(_i)" for _i in length(var_names)+1:size(_mat,2)]];
    end;

    # convert the data to DataFrame and save it
    _df = DataFrame(_mat, _var);
    save_csv!(file, _df);

    return nothing
)




save_csv!(data::Vector,
          var_names::Vector{String},
          file::String;
          per_row::Bool=true) =
    save_csv!(file, data, var_names; per_row=per_row)




"""
Further, as the above method supports filling in missing values, it is possible to not set the `var_names`:

    save_csv!(file::String, data::Vector; per_row::Bool=true)
    save_csv!(data::Vector, file::String; per_row::Bool=true)

Save data to CSV file, given
- `file` Path of the target CSV file
- `data` A Vector of data, needs to be a Vector of Tuple (N), Vector (N), or Matrix (1×N)
- `per_row` If true, item in the data Vector is treated as row; othrewise, the data item is treated as column

---
Example
```julia
# when data has equal length
save_csv!("test.csv", [[1,2], [1 2], (1,2)]);

# when data has unequal length
save_csv!("test.csv", [(1,2), [1 2 3], [1,2,3,4]]);

# use data item as column rather than row (default)
save_csv!("test.csv", [[1 2], [1 2]]; per_row=false);
save_csv!("test.csv", [[1 2], [1 2 3]]; per_row=false);
```
"""
save_csv!(file::String, data::Vector; per_row::Bool=true) =
    save_csv!(file, data, String[]; per_row=per_row)




save_csv!(data::Vector, file::String; per_row::Bool=true) =
    save_csv!(file, data, String[]; per_row=per_row)
=#
