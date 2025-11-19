#######################################################################################################################################################################################################
#
# Changes to this function
# General
#     2022-Aug-24: move function outside of the folder
#     2025-Nov-17: rename the function from month_days to month_doys
#
#######################################################################################################################################################################################################
"""

    month_doys(year::Int, month::Int)

Return the day of year, given
- `year` Year
- `month` Month

"""
function month_doys(year::Int, month::Int)
    @assert 1 <= month <= 12;
    mdays = isleapyear(year) ? MDAYS_LEAP : MDAYS;

    return (mdays[month]+1):mdays[month+1]
end;
