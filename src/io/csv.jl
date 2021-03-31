###############################################################################
#
# read CSV file as DataFrame
#
###############################################################################
"""
Reading CSV file may be troublesome for many cases, for example, when some
    lines exist before the header or when a few unit lines exist after the
    header. Here we provide a generalized function to read CSV files:

$(METHODLIST)

"""
function read_csv end




"""
When there is no unit row in the CSV file, the method is given as

    read_csv(file::String; skiprows::Int = 0)

Read CSV file as a DataFrame, given
- `file` Path to CSV file
- `skiprows` Rows to skip

---
Example
```julia
df = read_csv("test.csv");
df = read_csv("test.csv"; skiprows=0);
df = read_csv("test.csv"; skiprows=2);
```
"""
read_csv(file::String; skiprows::Int = 0) =
(
    @info tinfo("Reading data from $(file)...");

    return DataFrame(File(file; header=skiprows+1))
)








###############################################################################
#
# save DataFrame to CSV file
#
###############################################################################
"""
Saving data to CSV file may also be troublesome when we want to save the data
    using a known format, for example, when we want to save attributes in the
    file as well such as the units. To best use Julia, we provide a generalized
    function to save data as CSV:

$(METHODLIST)

"""
function save_csv! end




"""
To save the data as a plain CSV without any attribute information, one may use

    save_csv!(df::DataFrame, file::String)
    save_csv!(file::String, df::DataFrame)

Save data to CSV file, given
- `df` A DataFrame
- `file` Path of the target CSV file

---
Example
```julia
df = read_csv("in.csv"; skiprows=2);
save_csv!(df, "out.csv");
save_csv!("out.csv", df);
```
"""
save_csv!(df::DataFrame, file::String) =
(
    @info tinfo("Data written to $(file)...");
    write(file, df);

    return nothing
)




save_csv!(file::String, df::DataFrame) = save_csv!(df, file)
