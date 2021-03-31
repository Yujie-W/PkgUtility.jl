###############################################################################
#
# read_nc Wrapper using NCDatasets
#
###############################################################################
"""
NCDatasets.jl and NetCDF.jl both provide function to read data out from NC
    dataset. However, while NetCDF.jl is more convenient to use (less lines of
    code to read data), NCDatasets.jl is better to read a subset from the
    dataset and is able to detect the scale factor and offset. Here, we used a
    wrapper function to read NC dataset using NCDatasets.jl:

$(METHODLIST)

"""
function read_nc end




"""
When only file name and variable label are provided, `read_nc` function reads
    out all the data:

    read_nc(file::String, var::String)

Read data from NC file, given
- `file` Dataset path
- `var` Variable to read

Note that the missing data will be labeled as NaN.

---
Example
```julia
data = read_nc("test.nc", "test");
```
"""
read_nc(file::String, var::String) =
(
    _dset = Dataset(file, "r");
    _dvar = _dset[var][:,:];
    _nvar = replace(_dvar, missing=>NaN);
    _dvar = nothing;
    close(_dset);

    return _nvar
)




"""
If a float type is given, the data will be converted to FT, namely the output
    will be an array of float numbers:

    read_nc(FT, file::String, var::String)

Read data from nc file, given
- `FT` Float number type
- `file` Dataset path
- `var` Variable name

---
Example
```julia
data = read_nc(Float32, "test.nc", "test");
```
"""
read_nc(FT, file::String, var::String) = FT.(read_nc(file, var))




"""
In many cases, the NC dataset can be very huge, and reading all the data points
    into one array could be time and memory consuming. In this case, reading a
    subset of data would be the best option:

    read_nc(file::String, var::String, indz::Int)

Read a subset from nc file, given
- `file` Dataset path
- `var` Variable name
- `indz` The 3rd index of subset data to read

Note that the dataset must be a 3D array to use this method.

---
Example
```julia
data = read_nc("test.nc", "test", 1);
```
"""
read_nc(file::String, var::String, indz::Int) =
(
    _dset = Dataset(file, "r");
    _dvar = _dset[var][:,:,indz];
    _data = replace(_dvar, missing=>NaN);
    _dvar = nothing;
    close(_dset);

    return _data
)




"""
Similarly, one may want to read the subset as a certain float type using

    read_nc(FT, file::String, var::String, indz::Int)

Read a subset from nc file, given
- `FT` Float number type
- `file` Dataset path
- `var` Variable name
- `indz` The 3rd index of subset data to read

---
Example
```julia
data = read_nc(Float32, "test.nc", "test", 1);
```
"""
read_nc(FT, file::String, var::String, indz::Int) =
    FT.(read_nc(file, var, indz))
