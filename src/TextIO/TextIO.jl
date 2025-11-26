module TextIO

using CSV: File, write
using DataFrames: DataFrame


"""

    read_csv(file::String; skiprows::Int = 0)

Read in the CSV file a data frame, given
- `file` Path to CSV file
- `skiprows` Rows to skip

"""
function read_csv(file::String; skiprows::Int = 0)
    return DataFrame(File(file; header = skiprows + 1))
end;


"""

    save_csv!(df::DataFrame, file::String)
    save_csv!(file::String, df::DataFrame)

Save a data frame as a CSV file, given
- `df` A DataFrame
- `file` Path of the target CSV file

"""
function save_csv! end;

save_csv!(df::DataFrame, file::String) = write(file, df);

save_csv!(file::String, df::DataFrame) = write(file, df);


end; # module
