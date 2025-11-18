#######################################################################################################################################################################################################
#
# Changes to this function
# General
#     2023-Aug-25: add function (moved from EmeraldEarth.jl)
#
#######################################################################################################################################################################################################
"""

    gapfill_data!(data::Union{FT, Vector{FT}}) where {FT}

Gap fill the data linearly, given
- `data` Input data

"""
function gapfill_data! end;

gapfill_data!(data::Union{FT, Vector{FT}}) where {FT} = (
    if sum(.!isnan.(data)) in [0, length(data)]
        return nothing
    end;

    data_3x = [data; data; data];
    gapfill_data!.([data_3x], (length(data)+1):(length(data)*2));
    data .= data_3x[(length(data)+1):(length(data)*2)];

    return nothing
);

gapfill_data!(vec_in::Vector{FT}, ind::Int) where {FT} = (
    if isnan(vec_in[ind])
        (xi,yi) = previous_number(vec_in, ind);
        (xj,yj) = next_number(vec_in, ind);
        vec_in[ind] = ((ind - xi) * yj + (xj - ind) * yi) / (xj - xi);
    end;

    return nothing
);

previous_number(vec_in::Vector{FT}, ind::Int) where {FT} = (
    xi = ind;
    yi = vec_in[ind];
    for i in ind:-1:1
        if !isnan(vec_in[i])
            xi = i;
            yi = vec_in[i];
            break;
        end;
    end;

    return xi, yi
);

next_number(vec_in::Vector{FT}, ind::Int) where {FT} = (
    xj = ind;
    yj = vec_in[ind];
    for j in ind:1:length(vec_in)
        if !isnan(vec_in[j])
            xj = j;
            yj = vec_in[j];
            break;
        end;
    end;

    return xj, yj
);
