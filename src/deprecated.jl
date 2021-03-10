function doy_to_int(year::Int, doy::Int)
    @info "doy_to_int is deprecated, please use parse_date instead...";

    return parse_date(year, doy)
end
