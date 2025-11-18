#######################################################################################################################################################################################################
#
# Changes to this function
# General
#     2023-Aug-25: add function (moved from EmeraldFrontier.jl)
#     2023-Aug-25: add support for single value number (not an array)
#     2024-Nov-13: move the method of read_spectrum as resample_data
#     2025-Nov-11: add supports for different output temporal resolutions (say 7D, 8D, and 1M)
#     2025-Nov-13: add supports for output temporal resolutions of 1Y
#
#######################################################################################################################################################################################################
"""

    resample_data(dat_in::Union{FT,Vector{FT}}, year::Int64; out_reso::String = "1H") where {FT}

Interpolate the data to 1H or 1D resolution, given
- `dat_in` Input data
- `year` Year of the input data
- `out_reso` Output temporal resolution

"""
function resample_data end;

resample_data(dat_in::Union{FT,Vector{FT}}, year::Int64; out_reso::String = "1H") where {FT} = (
    nday = isleapyear(year) ? 366 : 365;
    @assert length(dat_in) in [nday*24, nday, 53, 52, 46, 12, 1] "Dataset length not supported";
    @assert out_reso in ["1H", "1D", "7D", "8D", "1M", "1Y"] "Output temporal resolution not supported";

    dat_1d = if length(dat_in) == 1
        repeat([dat_in;]; inner = nday)
    elseif length(dat_in) == 12
        [([repeat(dat_in[m:m], daysinmonth(year, m)) for m in 1:12]...)...]
    elseif length(dat_in) == 46
        repeat(dat_in; inner = 8)[1:nday]
    elseif length(dat_in) in [52,53]
        repeat([dat_in;dat_in[end]]; inner = 7)[1:nday]
    elseif length(dat_in) == nday
        dat_in
    elseif length(dat_in) == nday*24
        [nanmean(dat_in[((d8-1)*24+1):(d8*24)]) for d8 in 1:nday]
    end;

    # return the data based on the output temporal resolution
    return if out_reso == "1H"
        repeat(dat_1d; inner = 24)
    elseif out_reso == "1D"
        dat_1d
    elseif out_reso == "7D"
        [nanmean(dat_1d[((wk-1)*7+1):min(wk*7, nday)]) for wk in 1:53]
    elseif out_reso == "8D"
        [nanmean(dat_1d[((d8-1)*8+1):min(d8*8, nday)]) for d8 in 1:46]
    elseif out_reso == "1M"
        [nanmean(dat_1d[month_doys(year, m; ranges = true)]) for m in 1:12]
    elseif out_reso == "1Y"
        nanmean(dat_1d)
    end;
);
