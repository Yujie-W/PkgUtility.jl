###############################################################################
#
# Convert between YYYYMMDD and DOY
#
###############################################################################
"""
Researchers may often run into the scenarios when they have to convert dates to
    strings or numbers, vice versa. Thought the conversions are easy to make,
    it is not convenient at all if ones need to recreate the wheel everytime.
    Thus, we provide functions to make the conversion. One of the common
    conversions is to convert time stamp to a number:

$(METHODLIST)

"""
function parse_timestamp end




"""
The time stamp can be either an integer or a string, and the integer will be
    converted to a string within the function. The supported time stamp formats
    are `YYYYMMDD`, `YYYYMMDDhh`, `YYYYMMDDhhmm`, and `YYYYMMDDhhmmss`, where
    the labels are

- `YYYY` Year number
- `MM` Month number
- `DD` Day number
- `hh` Hour number
- `mm` Minute number
- `ss` second number

The supported outputs are
- `DATE` A `Dates.Date` type variable
- `DATETIME` A `Dates.DateTime` type variable
- `DOY` A day of year integer
- `FDOY` A day of year float

    parse_timestamp(
                time_stamp::Union{Int,String};
                in_format::String = "YYYYMMDD",
                out_format::String = "DOY")

Convert time stamp, given
- `time_stamp` Time stamp
- `in_format` Format of `time_stamp`
- `out_format` Output format
"""
parse_timestamp(
            time_stamp::Union{Int,String};
            in_format::String = "YYYYMMDD",
            out_format::String = "DOY") =
(
    _time_stamp = string(time_stamp);
    @assert in_format in TIME_FORMAT;
    @assert out_format in TIME_OUTPUT;

    # get year, month, and day
    _year   = parse(Int, _time_stamp[1:4]);
    _month  = parse(Int, _time_stamp[5:6]);
    _day    = parse(Int, _time_stamp[7:8]);
    _hour   = 0;
    _minute = 0;
    _second = 0;
    @assert 0 <= _year  <= 9999;
    @assert 1 <= _month <= 12;
    @assert 1 <= _day   <= month_days(_year,_month);

    # get hour, minute, and second
    if length(in_format) >= 10
        _hour   = parse(Int, _time_stamp[9:10]);
        @assert 0 <= _hour <= 24;
    end;
    if length(in_format) >= 12
        _minute = parse(Int, _time_stamp[11:12]);
        @assert 0 <= _minute <= 59;
    end;
    if length(in_format) >= 14
        _second = parse(Int, _time_stamp[13:14]);
        @assert 0 <= _second <= 59;
    end;

    # determine the
    if out_format=="DATE"
        return Date(_year, _month, _day, _hour, _minute, _second);
    elseif out_format=="DATETIME"
        return DateTime(_year, _month, _day, _hour, _minute, _second);
    elseif out_format=="DOY"
        return (isleapyear(_year) ? MDAYS_LEAP[_month] : MDAYS[_month]) + _day;
    elseif out_format=="FDOY"
        _doy = (isleapyear(_year) ? MDAYS_LEAP[_month] : MDAYS[_month]) + _day;
        return _doy + (_hour + _minute/60 + _second/3600) / 24;
    end;
)




"""
Also, one might want to convert date to time stamp. Supported conversions are

    parse_timestamp(year::Int, doy::Int, sep::String="")

Convert date to `YYYY(sep)MM(sep)DD` format, given
- `year` Year
- `doy` Day of year (typically 1-365, 1-366 for leap years)
- `sep` String that separates year, month, and day. Default is ""
"""
parse_timestamp(year::Int, doy::Int, sep::String="") =
(
    @assert 0 <= year <= 9999;
    _month = month_ind(year, doy);
    _day   = doy - (isleapyear(year) ? MDAYS_LEAP[_month] : MDAYS[_month]);

    return string(year) * sep * lpad(_month,2,"0") * sep * lpad(_day,2,"0")
)




"""
    month_days(year::Int, month::Int)

How many days in a month, given
- `year` Year
- `month` Month
"""
function month_days(year::Int, month::Int)
    @assert 1 <= month <= 12;

    return isleapyear(year) ? NDAYS_LEAP[month] : NDAYS[month]
end




"""
    month_ind(year::Int, doy::Int)

Which month does the day of year belongs to, given
- `year` Year
- `doy` Day of year (typically 1-365, 1-366 for leap years)
"""
function month_ind(year::Int, doy::Int)
    if isleapyear(year)
        @assert 1 <= doy <= 366;
        _month = 1;
        for i in 1:12
            if MDAYS_LEAP[i] < doy <= MDAYS_LEAP[i+1]
                _month = i;
                break;
            end
        end
    else
        @assert 1 <= doy <= 365;
        _month = 1;
        for i in 1:12
            if MDAYS[i] < doy <= MDAYS[i+1]
                _month = i;
                break;
            end
        end
    end

    return _month
end
