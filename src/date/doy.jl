###############################################################################
#
# Convert between YYYYMMDD and DOY
#
###############################################################################
"""
    parse_date(year::Int, doy::Int, sep::String="")

Convert date to YYYY(sep)MM(sep)DD format to work with flux tower datasets,
    given
- `year` Year with the format of XXXX
- `doy` Day of year (typically 1-365, 1-366 for leap years)
- `sep` String that separates year, month, and day. Default is ""
"""
function parse_date(year::Int, doy::Int, sep::String="")
    @assert 0 <= year <= 9999;

    if isleapyear(year)
        @assert 1 <= doy <= 366;
        mon = 1;
        for i in 1:12
            if MDAYS_LEAP[i] < doy <= MDAYS_LEAP[i+1]
                mon = i;
            end
        end
        day = doy - MDAYS_LEAP[mon];
    else
        @assert 1 <= doy <= 365;
        mon = 1;
        for i in 1:12
            if MDAYS[i] < doy <= MDAYS[i+1]
                mon = i;
            end
        end
        day = doy - MDAYS[mon];
    end

    return string(year) * sep * lpad(mon,2,"0") * sep * lpad(day,2,"0")
end




"""
    int_to_doy(timestamp::String)

Convert date from YYYYMMDD to day of year, given
- `timestamp` Time stamp as in flux tower dataset
"""
function int_to_doy(timestamp::String)
    @assert length(timestamp) == 8;

    # get year, month, and day
    year  = parse(Int, timestamp[1:4]);
    month = parse(Int, timestamp[5:6]);
    day   = parse(Int, timestamp[7:8]);

    @assert 0 <= year  <= 9999;
    @assert 1 <= month <= 12;

    if isleapyear(year)
        @assert 1 <= day <= NDAYS_LEAP[month];
        return MDAYS_LEAP[month] + day
    else
        @assert 1 <= day <= NDAYS[month];
        return MDAYS[month] + day
    end
end
