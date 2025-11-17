module TimeParser

using Dates: Date, DateTime, dayofyear, daysinmonth, daysinyear, isleapyear

# global constants
const MDAYS_LEAP  = [0,31,60,91,121,152,182,213,244,274,305,335,366];
const MDAYS       = [0,31,59,90,120,151,181,212,243,273,304,334,365];
const TIME_FORMAT = ["YYYYMMDD", "YYYYMMDDhh", "YYYYMMDDhhmm", "YYYYMMDDhhmmss", "YYYYMMDDhhmmss.mmm"];
const TIME_OUTPUT = ["DATE", "DATETIME", "DOY", "FDOY"];


include("month-doys.jl");
include("parse-time.jl");
include("which-month.jl");


end; # module
