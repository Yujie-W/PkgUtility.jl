module DataIO

using CSV
using JLD2

using DataFrames: DataFrame


# CSV read and write
"""

    read_csv(file::String; skiprows::Int = 0)

Read in the CSV file a data frame, given
- `file` Path to CSV file
- `skiprows` Rows to skip

"""
function read_csv(file::String; skiprows::Int = 0)
    @assert endswith(file, ".csv") "File extension needs to be `.csv`!";

    return DataFrame(CSV.File(file; header = skiprows + 1))
end;


"""

    save_csv!(df::DataFrame, file::String)
    save_csv!(file::String, df::DataFrame)

Save a data frame as a CSV file, given
- `df` A DataFrame
- `file` Path of the target CSV file

"""
function save_csv! end;

save_csv!(df::DataFrame, file::String) = (
    @assert endswith(file, ".csv") "File extension needs to be `.csv`!";
    CSV.write(file, df);

    return nothing
);

save_csv!(file::String, df::DataFrame) = save_csv!(df, file);


# JLD2 read and write
"""

    read_jld2(filename::String)
    read_jld2(filename::String, varname::String)

Load JLD2 file as a dict, given
- `filename` JLD2 file name
- `varname` Variable name

"""
function read_jld2 end;

read_jld2(filename::String) = (
    @assert endswith(filename, ".jld2") "File extension needs to be `.jld2`!";

    return JLD2.load(filename)
);

read_jld2(filename::String, varname::String) = (
    @assert endswith(filename, ".jld2") "File extension needs to be `.jld2`!";

    return JLD2.load(filename, varname)
);


"""

    save_jld2!(filename::String, dict::Dict)

Save dict to as JLD2 file, given
- `filename` JLD2 file name
- `dict` Dict to save

"""
function save_jld2!(filename::String, dict::Dict)
    @assert endswith(filename, ".jld2") "File extension needs to be `.jld2`!";

    JLD2.save(filename, dict);

    return nothing
end;


end; # module
