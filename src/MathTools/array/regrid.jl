"""

    regrid(data::Matrix{FT}, division::Int = 1) where {FT<:AbstractFloat}
    regrid(data::Matrix{FT}, newsize::Vector{Int}) where {FT<:AbstractFloat}
    regrid(data::Matrix{FT}, newsize::Tuple{Int,Int}) where {FT<:AbstractFloat}
    regrid(data::Array{FT,3}, division::Int = 1) where {FT<:AbstractFloat}
    regrid(data::Array{FT,3}, newsize::Vector{Int}) where {FT<:AbstractFloat}
    regrid(data::Array{FT,3}, newsize::Tuple{Int,Int,Int}) where {FT<:AbstractFloat}

Return the regridded dataset, given
- `data` Input dataset, 2D or 3D
- `division` Spatial resolution is `1/division` degree (integer truncation or expansion)
- `newsize` Target 2D size of the map (not limited to integer truncation or expansion)

"""
function regrid end;

# 2D array
regrid(data::Matrix{FT}, division::Int = 1) where {FT<:AbstractFloat} = regrid(data, 360*division, 180*division);

regrid(data::Matrix{FT}, newsize::Vector{Int}) where {FT<:AbstractFloat} = regrid(data, newsize...);

regrid(data::Matrix{FT}, newsize::Tuple{Int,Int}) where {FT<:AbstractFloat} = regrid(data, newsize...);

regrid(data::Matrix{FT}, s1::Int, s2::Int) where {FT<:AbstractFloat} = (
    # expand the data when necessary
    n1 = Int(lcm(size(data,1), s1) / size(data,1));
    n2 = Int(lcm(size(data,2), s2) / size(data,2));
    @assert n1 <= 100 && n2 <= 100 "Expansion factor too large when expanding the data!";
    expanded = expand_array(data, n1, n2);

    # truncate the data when necessary
    n1 = Int(size(expanded,1) / s1);
    n2 = Int(size(expanded,2) / s2);
    truncated = truncate_array(expanded, n1, n2);

    return truncated
);

# 3D array
regrid(data::Array{FT,3}, division::Int = 1) where {FT<:AbstractFloat} = regrid(data, 360*division, 180*division, size(data,3));

regrid(data::Array{FT,3}, newsize::Vector{Int}) where {FT<:AbstractFloat} = regrid(data, newsize...);

regrid(data::Array{FT,3}, newsize::Tuple{Int,Int,Int}) where {FT<:AbstractFloat} = regrid(data, newsize...);

regrid(data::Array{FT,3}, s1::Int, s2::Int, s3::Int) where {FT<:AbstractFloat} = (
    # expand the data when necessary
    n1 = Int(lcm(size(data,1), s1) / size(data,1));
    n2 = Int(lcm(size(data,2), s2) / size(data,2));
    n3 = Int(lcm(size(data,3), s3) / size(data,3));
    @assert n1 <= 100 && n2 <= 100 && n3 <= 100 "Expansion factor too large when expanding the data!";
    expanded = expand_array(data, n1, n2, n3);

    # truncate the data when necessary
    n1 = Int(size(expanded,1) / s1);
    n2 = Int(size(expanded,2) / s2);
    n3 = Int(size(expanded,3) / s3);
    truncated = truncate_array(expanded, n1, n2, n3);

    return truncated
);
