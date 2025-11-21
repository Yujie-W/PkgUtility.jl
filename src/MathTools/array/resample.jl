"""

    resample(data::FT, reso_in::String, reso_out::String, year::Int)
    resample(data::FT, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat}
    resample(data::Vector{FT}, reso_in::String, reso_out::String, year::Bool) where {FT<:AbstractFloat}
    resample(data::Vector{FT}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat}
    resample(data::Matrix{FT}, reso_in::String, reso_out::String, year::Bool) where {FT<:AbstractFloat}
    resample(data::Matrix{FT}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat}
    resample(data::Array{FT,3}, reso_in::String, reso_out::String, year::Bool) where {FT<:AbstractFloat}
    resample(data::Array{FT,3}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat}

Return the resampled dataset, given
- `data` Input dataset, 3D array
- `reso_in` Input temporal resolution, one of "1H", "1D", "7D", "8D", "1M"
- `reso_out` Output temporal resolution, one of "1D", "7D", "8D", "1M", "1Y"
- `year` Year of the input data
- `leapyear` Whether the input data is for a leap year

"""
function resample end;

resample(data::FT, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, "1Y", reso_out, year);

resample(data::FT, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = resample(data, "1Y", reso_out, leapyear);

resample(data::Vector{FT}, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_out, isleapyear(year));

resample(data::Vector{FT}, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    if length(data) == 1
        return resample(data[1], "1Y", reso_out, leapyear);
    elseif length(data) == 12
        return resample(data, "1M", reso_out, leapyear);
    elseif length(data) == 46
        return resample(data, "8D", reso_out, leapyear);
    elseif length(data) == 52 || length(data) == 53
        return resample(data, "7D", reso_out, leapyear);
    elseif length(data) == (leapyear ? 366 : 365)
        return resample(data, "1D", reso_out, leapyear);
    elseif length(data) == (leapyear ? 8784 : 8760)
        return resample(data, "1H", reso_out, leapyear);
    else
        error("Input data length not consistent with any supported resolution!");
    end;
);

resample(data::Matrix{FT}, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, "1Y", reso_out, year);

resample(data::Matrix{FT}, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = resample(data, "1Y", reso_out, leapyear);

resample(data::Array{FT,3}, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_out, isleapyear(year));

resample(data::Array{FT,3}, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    if size(data,3) == 1
        return resample(data, "1Y", reso_out, leapyear);
    elseif size(data,3) == 12
        return resample(data, "1M", reso_out, leapyear);
    elseif size(data,3) == 46
        return resample(data, "8D", reso_out, leapyear);
    elseif size(data,3) == 52 || size(data,3) == 53
        return resample(data, "7D", reso_out, leapyear);
    elseif size(data,3) == (leapyear ? 366 : 365)
        return resample(data, "1D", reso_out, leapyear);
    elseif size(data,3) == (leapyear ? 8784 : 8760)
        return resample(data, "1H", reso_out, leapyear);
    else
        error("Input data length not consistent with any supported resolution!");
    end;
);

resample(data::FT, reso_in::String, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_in, reso_out, isleapyear(year));

resample(data::FT, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = resample([data;], reso_in, reso_out, leapyear);

resample(data::Vector{FT}, reso_in::String, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_in, reso_out, isleapyear(year));

resample(data::Vector{FT}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    # if the input and output resolutions are the same
    if reso_in == reso_out
        return data
    end;

    # otherwise, always resample to 1-day first
    # then, resample from 1-day to the target resolution
    new_data = reso_in == "1H" ? _truncate(data, reso_in, "1D") : _expand_to_1day(data, reso_in, leapyear);

    return reso_out == "1H" ? expand_array(new_data, 24) : _truncate(new_data, "1D", reso_out);
);

resample(data::Matrix{FT}, reso_in::String, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_in, reso_out, isleapyear(year));

resample(data::Matrix{FT}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = resample(reshape(data, size(data,1), size(data,2), 1), reso_in, reso_out, leapyear);

resample(data::Array{FT,3}, reso_in::String, reso_out::String, year::Int) where {FT<:AbstractFloat} = resample(data, reso_in, reso_out, isleapyear(year));

resample(data::Array{FT,3}, reso_in::String, reso_out::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    # if the input and output resolutions are the same
    if reso_in == reso_out
        return data
    end;

    # otherwise, always resample to 1-day first
    # then, resample from 1-day to the target resolution
    new_data = reso_in == "1H" ? _truncate(data, reso_in, "1D") : _expand_to_1day(data, reso_in, leapyear);

    return reso_out == "1H" ? expand_array(new_data, 1, 1, 24) : _truncate(new_data, "1D", reso_out);
);


# Resample data from one resolution to another
# Supported pairs:
# - 7D to 1D
# - 8D to 1D
# - 1M to 1D
# - 1Y to 1D
_expand_to_1day(data::FT, reso_in::String, leapyear::Bool) where {FT<:AbstractFloat} = _expand_to_1day([data;], reso_in, leapyear);

_expand_to_1day(data::Vector{FT}, reso_in::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    # if the input data is per day, do nothing
    if reso_in == "1D"
        return data
    end;

    # otherwise, check supported pairs
    @assert reso_in in ["7D", "8D", "1M", "1Y"] "Resampling from $reso_in to 1D is not supported!";
    nday = leapyear ? 366 : 365;

    # if the input data is per week
    if reso_in == "7D"
        @assert length(data) in [52, 53] "Input data length not consistent with 7D resolution!";
        new_data = (length(data) == 53) ? data : (vcat(data, data[end]));
        expanded = expand_array(new_data, 7);

        return expanded[1:nday]
    end;

    # if the input data is per 8 days
    if reso_in == "8D"
        @assert length(data) == 46 "Input data length not consistent with 8D resolution!";
        expanded = expand_array(data, 8);

        return expanded[1:nday]
    end;

    # if the input data is per month
    if reso_in == "1M"
        @assert length(data) == 12 "Input data length not consistent with 1M resolution!";
        expanded = ones(FT, nday) .* FT(NaN);
        for m in 1:12
            expanded[month_doys(leapyear, m)] .= expand_array(data[m], length(month_doys(leapyear, m)));
        end;

        return expanded
    end;

    # if the input data is per year
    if reso_in == "1Y"
        @assert length(data) == 1 "Input data length not consistent with 1Y resolution!";

        return expand_array(data, nday)
    end;
);

_expand_to_1day(data::Matrix{FT}, reso_in::String, leapyear::Bool) where {FT<:AbstractFloat} = _expand_to_1day(reshape(data, size(data,1), size(data,2), 1), reso_in, leapyear);

_expand_to_1day(data::Array{FT,3}, reso_in::String, leapyear::Bool) where {FT<:AbstractFloat} = (
    # if the input data is per day, do nothing
    if reso_in == "1D"
        return data
    end;

    # otherwise, check supported pairs
    @assert reso_in in ["7D", "8D", "1M", "1Y"] "Resampling from $reso_in to 1D is not supported!";
    nday = leapyear ? 366 : 365;

    # if the input data is per week
    if reso_in == "7D"
        @assert size(data,3) in [52, 53] "Input data length not consistent with 7D resolution!";
        new_data = (size(data,3) == 53) ? data : (cat(data, data[:,:,end]; dims=3));
        expanded = expand_array(new_data, 1, 1, 7);

        return expanded[:,:,1:nday]
    end;

    # if the input data is per 8 days
    if reso_in == "8D"
        @assert size(data,3) == 46 "Input data length not consistent with 8D resolution!";
        expanded = expand_array(data, 1, 1, 8);

        return expanded[:,:,1:nday]
    end;

    # if the input data is per month
    if reso_in == "1M"
        @assert size(data,3) == 12 "Input data length not consistent with 1M resolution!";
        expanded = ones(FT, size(data,1), size(data,2), nday) .* FT(NaN);
        for m in 1:12
            expanded[:,:,month_doys(leapyear, m)] .= expand_array(data[:,:,m], 1, 1, length(month_doys(leapyear, m)));
        end;

        return expanded
    end;

    # if the input data is per year
    if reso_in == "1Y"
        @assert size(data,3) == 1 "Input data length not consistent with 1Y resolution!";
        expanded = expand_array(data, 1, 1, nday);

        return expanded
    end;
);

# Resample data from one resolution to another
# Supported pairs:
# - 1H to 1D
# - 1D to 7D, 8D, 1M, 1Y
# - 8D to 1Y
# - 1M to 1Y
_truncate(data::Vector{FT}, reso_in::String, reso_out::String) where {FT<:AbstractFloat} = (
    # if the input and output resolutions are the same
    if reso_in == reso_out
        return data
    end;

    # otherwise, check supported pairs
    supported_pairs = [
        ("1H", "1D"),
        ("1D", "7D"), ("1D", "8D"), ("1D", "1M"),
        ("1D", "1Y"), ("7D", "1Y"), ("8D", "1Y"), ("1M", "1Y"),
    ];
    @assert (reso_in, reso_out) in supported_pairs "Resampling from $reso_in to $reso_out is not supported!";

    #
    # if the input data is per hour
    #
    if reso_in == "1H"
        @assert length(data) in [8760, 8784] "Input data length not consistent with 1H resolution!";

        return [nanmean(data[((h-1)*24+1):h*24]) for h in 1:(length(data) ÷ 24)]
    end;

    #
    # if the input data is per day
    #
    if reso_in == "1D" && reso_out == "7D"
        @assert length(data) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = ones(FT, 53) .* FT(NaN);
        for wk in 1:53
            resampled[wk] = nanmean(data[((wk-1)*7+1):min(wk*7, length(data))]);
        end;

        return resampled
    elseif reso_in == "1D" && reso_out == "8D"
        @assert length(data) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = ones(FT, 46) .* FT(NaN);
        for d8 in 1:46
            resampled[d8] = nanmean(data[((d8-1)*8+1):min(d8*8, length(data))]);
        end;

        return resampled
    elseif reso_in == "1D" && reso_out == "1M"
        @assert length(data) in [365, 366] "Input data length not consistent with 1D resolution!";
        leapyear = length(data) == 366;
        resampled = ones(FT, 12) .* FT(NaN);
        for m in 1:12
            resampled[m] = nanmean(data[month_doys(leapyear, m)]);
        end;

        return resampled
    end;

    #
    # if the output data is per year
    #
    if reso_in == "1D"
        @assert length(data) in [365, 366] "Input data length not consistent with 1D resolution!";
    elseif reso_in == "7D"
        @assert length(data) in [52, 53] "Input data length not consistent with 7D resolution!";
    elseif reso_in == "8D"
        @assert length(data) == 46 "Input data length not consistent with 8D resolution!";
    elseif reso_in == "1M"
        @assert length(data) == 12 "Input data length not consistent with 1M resolution!";
    end;

    return nanmean(data)
);

_truncate(data::Array{FT,3}, reso_in::String, reso_out::String) where {FT<:AbstractFloat} = (
    # if the input and output resolutions are the same
    if reso_in == reso_out
        return data
    end;

    # otherwise, check supported pairs
    supported_pairs = [
        ("1H", "1D"),
        ("1D", "7D"), ("1D", "8D"), ("1D", "1M"),
        ("1D", "1Y"), ("7D", "1Y"), ("8D", "1Y"), ("1M", "1Y"),
    ];
    @assert (reso_in, reso_out) in supported_pairs "Resampling from $reso_in to $reso_out is not supported!";

    #
    # if the input data is per hour
    #
    if reso_in == "1H"
        @assert size(data,3) in [8760, 8784] "Input data length not consistent with 1H resolution!";

        return regrid(data, size(data,1), size(data,2), size(data,3) ÷ 24)
    end;

    #
    # if the input data is per day
    #
    if reso_in == "1D" && reso_out == "7D"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = ones(FT, size(data,1), size(data,2), 53) .* FT(NaN);
        for i in axes(data,1), j in axes(data,2), wk in 1:53
            resampled[i,j,wk] = nanmean(data[i,j,((wk-1)*7+1):min(wk*7, size(data,3))]);
        end;

        return resampled
    elseif reso_in == "1D" && reso_out == "8D"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = ones(FT, size(data,1), size(data,2), 46) .* FT(NaN);
        for i in axes(data,1), j in axes(data,2), d8 in 1:46
            resampled[i,j,d8] = nanmean(data[i,j,((d8-1)*8+1):min(d8*8, size(data,3))]);
        end;

        return resampled
    elseif reso_in == "1D" && reso_out == "1M"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        leapyear = size(data,3) == 366;
        resampled = ones(FT, size(data,1), size(data,2), 12) .* FT(NaN);
        for i in axes(data,1), j in axes(data,2), m in 1:12
            resampled[i,j,m] = nanmean(data[i,j,month_doys(leapyear, m)]);
        end;

        return resampled
    end;

    #
    # if the output data is per year
    #
    if reso_in == "1D"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
    elseif reso_in == "7D"
        @assert size(data,3) in [52, 53] "Input data length not consistent with 7D resolution!";
    elseif reso_in == "8D"
        @assert size(data,3) == 46 "Input data length not consistent with 8D resolution!";
    elseif reso_in == "1M"
        @assert size(data,3) == 12 "Input data length not consistent with 1M resolution!";
    end;
    resampled = regrid(data, size(data,1), size(data,2), 1);

    return resampled[:,:,1]
);
