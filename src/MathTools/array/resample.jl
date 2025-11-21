"""

    resample(data::Array{FT,3}, reso_in::String, reso_out::String) where {FT<:AbstractFloat}

Return the resampled dataset, given
- `data` Input dataset, 3D array
- `reso_in` Input temporal resolution, one of "1H", "1D", "8D", "1M"
- `reso_out` Output temporal resolution, one of "1D", "8D", "1M", "1Y"

"""
function resample(data::Array{FT,3}, reso_in::String, reso_out::String) where {FT<:AbstractFloat}
    supported_resolutions = ["1H", "1D", "8D", "1M", "1Y"];
    @assert reso_in in supported_resolutions "Input temporal resolution not supported";
    @assert reso_out in supported_resolutions "Output temporal resolution not supported";
    @assert findfirst(reso_in .== supported_resolutions) < findfirst(reso_out .== supported_resolutions) "Resampling from $reso_in to $reso_out is not supported!";

    # if the input data is per hour
    if reso_in == "1H"
        return reso_out == "1D" ? _resample(data, "1H", "1D") : _resample(_resample(data, "1H", "1D"), "1D", reso_out)
    end;

    # if the input data is per day
    return _resample(data, reso_in, reso_out)
end;


# Resample data from one resolution to another
# Supported pairs:
# - 1H to 1D
# - 1D to 8D, 1M, 1Y
# - 8D to 1Y
# - 1M to 1Y
_resample(data::Array{FT,3}, reso_in::String, reso_out::String) where {FT<:AbstractFloat} = (
    supported_pairs = [
        ("1H", "1D"),
        ("1D", "8D"), ("1D", "1M"), ("1D", "1Y"),
        ("8D", "1Y"),
        ("1M", "1Y"),
    ];
    @assert (reso_in, reso_out) in supported_pairs "Resampling from $reso_in to $reso_out is not supported!";

    # if the input data is per hour
    if reso_in == "1H"
        @assert size(data,3) in [8760, 8784] "Input data length not consistent with 1H resolution!";

        return regrid(data, size(data,1), size(data,2), size(data,3) ÷ 24)
    end;

    # if the input data is per day
    if reso_in == "1D" && reso_out == "8D"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = ones(FT, size(data,1), size(data,2), 46) .* FT(NaN);
        for i in axes(data,1), j in axes(data,2), d8 in 1:46
            resampled[i,j,d8] = nanmean(data[i,j,((d8-1)*8+1):min(d8*8, size(data,3))]);
        end;

        return resampled
    end;

    if reso_in == "1D" && reso_out == "1M"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        leapyear = size(data,3) == 366;
        resampled = ones(FT, size(data,1), size(data,2), 12) .* FT(NaN);
        for i in axes(data,1), j in axes(data,2), m in 1:12
            resampled[i,j,m] = nanmean(data[i,j,month_doys(leapyear, m)]);
        end;

        return resampled
    end;

    if reso_in == "1D" && reso_out == "1Y"
        @assert size(data,3) in [365, 366] "Input data length not consistent with 1D resolution!";
        resampled = regrid(data, size(data,1), size(data,2), 1);

        return resampled[:,:,1]
    end;

    # if the input data is per 8 days
    if reso_in == "8D"
        @assert size(data,3) == 46 "Input data length not consistent with 8D resolution!";
        resampled = regrid(data, size(data,1), size(data,2), 1);

        return resampled[:,:,1]
    end;

    # if the input data is per month
    if reso_in == "1M"
        @assert size(data,3) == 12 "Input data length not consistent with 1M resolution!";
        resampled = regrid(data, size(data,1), size(data,2), 1);

        return resampled[:,:,1]
    end;
);
