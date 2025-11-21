"""

    which_month(year::Int, doy::Int)

Return the month index, given
- `year` Year
- `doy` Day of year (typically 1-365, 1-366 for leap years)

"""
function which_month(year::Int, doy::Int) :: Int
    @assert 1 <= doy <= daysinyear(year);

    month_bounds = isleapyear(year) ? MDAYS_LEAP : MDAYS;
    for i in 1:12
        if month_bounds[i] < doy <= month_bounds[i+1]
            return i;
        end;
    end;
end;
