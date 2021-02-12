###############################################################################
#
# Convert between YYYYMMDD and DOY
#
###############################################################################
MONTH_DAYS_LEAP = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366];
MONTH_DAYS      = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365];
NDAYS_LEAP      = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
NDAYS           = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
"""
    doy_to_int(year::Int, doy::Int)

Convert date to YYYYMMDD format to work with flux tower datasets, given
- `year` Year with the format of XXXX
- `doy` Day of year (typically 1-365, 1-366 for leap years)
"""
function doy_to_int(year::Int, doy::Int)
    if isleapyear(year)
        mon = 1;
        for i in 1:12
            if MONTH_DAYS_LEAP[i] < doy <= MONTH_DAYS_LEAP[i+1]
                mon = i;
            end
        end
        day = doy - MONTH_DAYS_LEAP[mon];
    else
        mon = 1;
        for i in 1:12
            if MONTH_DAYS[i] < doy <= MONTH_DAYS[i+1]
                mon = i;
            end
        end
        day = doy - MONTH_DAYS[mon];
    end

    return string(Int(year*10000 + mon*100 + day))
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
        return MONTH_DAYS_LEAP[month] + day
    else
        @assert 1 <= day <= NDAYS[month];
        return MONTH_DAYS[month] + day
    end
end
