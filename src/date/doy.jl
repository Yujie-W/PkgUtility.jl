###############################################################################
#
# Convert between YYYYMMDD and DOY
#
###############################################################################
"""
    month_days(year::Int, month::Int)

Return how many days for given
- `year` Year
- `month` Month
"""
function month_days(year::Int, month::Int)
    @assert 1 <= month <= 12;

    return isleapyear(year) ? NDAYS_LEAP[month] : NDAYS[month]
end




"""
    month_ind(year::Int, doy::Int)

Return which month does the day belongs to
- `year` Year
- `doy` Day of year (typically 1-365, 1-366 for leap years)
"""
function month_ind(year::Int, doy::Int)
    if isleapyear(year)
        @assert 1 <= doy <= 366;
        month = 1;
        for i in 1:12
            if MDAYS_LEAP[i] < doy <= MDAYS_LEAP[i+1]
                month = i;
                break;
            end
        end
    else
        @assert 1 <= doy <= 365;
        month = 1;
        for i in 1:12
            if MDAYS[i] < doy <= MDAYS[i+1]
                month = i;
                break;
            end
        end
    end

    return month
end




"""
    parse_date(year::Int, doy::Int, sep::String="")

Convert date to YYYY(sep)MM(sep)DD format to work with flux tower datasets,
    given
- `year` Year
- `doy` Day of year (typically 1-365, 1-366 for leap years)
- `sep` String that separates year, month, and day. Default is ""
"""
function parse_date(year::Int, doy::Int, sep::String="")
    @assert 0 <= year <= 9999;
    month = month_ind(year, doy);
    day   = doy - (isleapyear(year) ? MDAYS_LEAP[month] : MDAYS[month]);

    return string(year) * sep * lpad(month,2,"0") * sep * lpad(day,2,"0")
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
    @assert 1 <= day   <= month_days(year,month);

    if isleapyear(year)
        return MDAYS_LEAP[month] + day
    else
        return MDAYS[month] + day
    end
end
