function doy_to_int(year::Int, doy::Int)
    @warn twarn("doy_to_int is deprecated, use parse_timestamp instead...");

    return parse_timestamp(year, doy)
end




function int_to_doy(time_stamp::Union{Int,String})
    @warn twarn("int_to_doy is deprecated, use parse_timestamp instead...");

    return parse_timestamp(time_stamp; in_format="YYYYMMDD", out_format="DOY");
end




function parse_date(year::Int, doy::Int)
    @warn twarn("parse_date is deprecated, use parse_timestamp instead...");

    return parse_timestamp(year, doy)
end




function ncread(FT, file::String, var::String)
    @warn twarn("ncread is deprecated, use read_nc instead...");

    return read_nc(FT, file, var)
end




function ncread(file::String, var::String, indz::Int)
    @warn twarn("ncread is deprecated, use read_nc instead...");

    return read_nc(file, var, indz)
end
