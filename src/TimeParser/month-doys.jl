"""

    month_doys(year::Int, month::Int)
    month_doys(leapyear::Bool, month::Int)

Return the day of year, given
- `year` Year
- `month` Month
- `leapyear` Whether the year is a leap year

"""
function month_doys end;

month_doys(year::Int, month::Int) = month_doys(isleapyear(year), month);

month_doys(leapyear::Bool, month::Int) = (
    @assert 1 <= month <= 12;
    mdays = leapyear ? MDAYS_LEAP : MDAYS;

    return (mdays[month]+1):mdays[month+1]
);
