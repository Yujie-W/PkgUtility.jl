###############################################################################
#
# ncread Wrapper using NCDatasets
#
###############################################################################
"""
    ncread(FT, file::String, var::String)

Read data from nc file, given
- `FT` Float number type
- `file` Dataset path
- `var` Variable name

Note that this `ncread` function differs from the NetCDF.ncread in that it
    accounts for `scale_factor` and `add_offset` in the attributes if they
    exist.
"""
function ncread(FT, file::String, var::String)
    dset = Dataset(file, "r");
    dvar = dset[var][:,:];
    nvar = replace(dvar, missing=>NaN);
    data = FT.(nvar);
    dvar = nothing;
    nvar = nothing;
    close(dset);

    return data
end




function ncread(file::String, var::String, indz::Int)
    dset = Dataset(file, "r");
    dvar = dset[var][:,:,indz];
    data = replace(dvar, missing=>NaN);
    dvar = nothing;
    close(dset);

    return data
end
