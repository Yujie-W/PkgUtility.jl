function doy_to_int(year::Int, doy::Int)
    @warn "doy_to_int is deprecated, please use parse_timestamp instead...";

    return parse_timestamp(year, doy)
end




function int_to_doy(time_stamp::Union{Int,String})
    @warn "int_to_doy is deprecated, please use parse_timestamp instead...";

    return parse_timestamp(time_stamp; in_format="YYYYMMDD", out_format="DOY");
end




function parse_date(year::Int, doy::Int)
    @warn "parse_date is deprecated, please use parse_timestamp instead...";

    return parse_timestamp(year, doy)
end
