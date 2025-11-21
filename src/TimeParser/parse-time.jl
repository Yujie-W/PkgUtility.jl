"""

    parse_timestamp(timestamp::Union{Int,String}, in_format::String, out_format::String)
    parse_timestamp(year::Int, doy::Int, out_format::String)
    parse_timestamp(year::Int, doy::AbstractFloat, out_format::String)

Convert timestamp, given
- `timestamp` Time stamp
- `in_format` Format of `timestamp`, default is `YYYYMMDD`
- `out_format` Output format, default is `DOY`
- `year` Year (in this case, the function will convert year and day to timestamp first)
- `doy` Day of year (typically 1-365, 1-366 for leap years)

The input format (string or integer) supports `YYYYMMDD`, `YYYYMMDDhh`, `YYYYMMDDhhmm`, `YYYYMMDDhhmmss`, and `YYYYMMDDhhmmss.mmm`, where the labels are
- `YYYY` Year number
- `MM` Month number
- `DD` Day number
- `hh` Hour number
- `mm` Minute number
- `ss` Second number
- `mmm` Millisecond number

The supported outputs are
- `DATE` A `Dates.Date` type variable
- `DATETIME` A `Dates.DateTime` type variable
- `DOY` A day of year integer
- `FDOY` A day of year float

---
Examples
```julia
    time = parse_timestamp(20200130, "YYYYMMDD", "FDOY");
    time = parse_timestamp("20200130", "YYYYMMDD", "FDOY");
    time = parse_timestamp(2020, 100, "DOY");
    time = parse_timestamp(2020, 100.23435436, "DATETIME");
```

"""
function parse_timestamp end;

parse_timestamp(timestamp::Union{Int,String}, in_format::String, out_format::String) = (
    time_stamp_str = string(timestamp);
    @assert in_format in TIME_FORMAT "in_format not found in TIME_FORMAT";
    @assert out_format in TIME_OUTPUT "out_format not found in TIME_OUTPUT";

    # get year, month, and day (and hour, minute, and second if applicable)
    i_year   = parse(Int, time_stamp_str[1:4]);
    i_month  = parse(Int, time_stamp_str[5:6]);
    i_day    = parse(Int, time_stamp_str[7:8]);

    i_hour = if in_format in ["YYYYMMDDhh", "YYYYMMDDhhmm", "YYYYMMDDhhmmss", "YYYYMMDDhhmmss.mmm"]
        parse(Int, time_stamp_str[9:10])
    else
        0
    end;

    i_minute = if in_format in ["YYYYMMDDhhmm", "YYYYMMDDhhmmss", "YYYYMMDDhhmmss.mmm"]
        parse(Int, time_stamp_str[11:12])
    else
        0
    end;

    i_second = if in_format in ["YYYYMMDDhhmmss", "YYYYMMDDhhmmss.mmm"]
        parse(Int, time_stamp_str[13:14])
    else
        0
    end;

    i_millisecond = if in_format == "YYYYMMDDhhmmss.mmm"
        parse(Int, rpad(time_stamp_str[16:end], 3, "0"))
    else
        0
    end;

    # make sure the values are valid
    @assert 0 <= i_year        <= 9999;
    @assert 1 <= i_month       <= 12;
    @assert 1 <= i_day         <= daysinmonth(i_year, i_month);
    @assert 0 <= i_hour        <= 24;
    @assert 0 <= i_minute      <= 59;
    @assert 0 <= i_second      <= 59;
    @assert 0 <= i_millisecond <= 999;

    # determine the format to return (float ddoy by default)
    if out_format == "DATE"
        return Date(i_year, i_month, i_day)
    end;

    if out_format == "DATETIME"
        return DateTime(i_year, i_month, i_day, i_hour, i_minute, i_second, i_millisecond)
    end;

    if out_format == "DOY"
        return dayofyear(i_year, i_month, i_day)
    end;

    if out_format == "FDOY"
        return dayofyear(i_year, i_month, i_day) + (i_hour + i_minute/60 + i_second/3600 + i_millisecond/3.6e6) / 24
    end;
);

parse_timestamp(year::Int, doy::Int, out_format::String) = (
    @assert 0 <= year <= 9999;
    @assert 1 <= doy  <= daysinyear(year);

    # convert the year and doy to timestamp
    i_month = which_month(year, doy);
    i_day   = doy - (isleapyear(year) ? MDAYS_LEAP[i_month] : MDAYS[i_month]);
    time_stamp_str = lpad(year, 4, "0") * lpad(i_month, 2, "0") * lpad(i_day, 2, "0");

    return parse_timestamp(time_stamp_str, "YYYYMMDD", out_format)
);

parse_timestamp(year::Int, doy::AbstractFloat, out_format::String) = (
    @assert 0 <= year <= 9999;
    @assert 1 <= doy  <  (isleapyear(year) ? 367 : 366);

    # convert the year and doy to timestamp
    i_doy      = Int(floor(doy));
    i_month    = which_month(year, i_doy);
    i_day      = i_doy - (isleapyear(year) ? MDAYS_LEAP[i_month] : MDAYS[i_month]);
    f_hour     = (doy % 1) * 24;
    i_hour     = Int(floor(f_hour));
    f_minute   = (f_hour % 1) * 60;
    i_minute   = Int(floor(f_minute));
    f_second   = (f_minute % 1) * 60;
    i_second   = Int(floor(f_second));
    f_millisec = (f_second % 1) * 1000;
    i_millisec = Int(round(f_millisec));
    time_stamp_str = lpad(year, 4, "0") * lpad(i_month, 2, "0") * lpad(i_day, 2, "0") * lpad(i_hour, 2, "0") * lpad(i_minute, 2, "0") * lpad(i_second, 2, "0") * "." * lpad(i_millisec, 3, "0");

    return parse_timestamp(time_stamp_str, "YYYYMMDDhhmmss.mmm", out_format)
);
