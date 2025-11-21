"""

    expand_array(data::Vector{FT}, n::Int) where {FT<:AbstractFloat}
    expand_array(data::Matrix{FT}, n::Int) where {FT<:AbstractFloat}
    expand_array(data::Array{FT,3}, n::Int) where {FT<:AbstractFloat}

Return a expanded array, given
- `data` Input array (vector, matrix, or 3D array)
- `n` Integer times to expand the array (only on first and second dimensions)

"""
function expand_array end;

# 1D array
expand_array(data::Vector{FT}, n::Int) where {FT<:AbstractFloat} = (
    # create a new vector to save the data
    vec = ones(FT, length(data) * n) .* FT(NaN);
    for i in axes(data,1)
        vec[(i-1)*n+1:i*n] .= data[i];
    end;

    return vec
);

# 2D array
expand_array(data::Matrix{FT}, n::Int) where {FT<:AbstractFloat} = expand_array(data, n, n);

expand_array(data::Matrix{FT}, n1::Int, n2::Int) where {FT<:AbstractFloat} = (
    # create a new matrix to save the data
    mat = ones(FT, size(data,1) * n1, size(data,2) * n2) .* FT(NaN);
    for i in axes(data,1), j in axes(data,2)
        mat[(i-1)*n1+1:i*n1, (j-1)*n2+1:j*n2] .= data[i,j];
    end;

    return mat
);

# 3D array
expand_array(data::Array{FT,3}, n::Int) where {FT<:AbstractFloat} = expand_array(data, n, n, 1);

expand_array(data::Array{FT,3}, n1::Int, n2::Int) where {FT<:AbstractFloat} = expand_array(data, n1, n2, 1);

expand_array(data::Array{FT,3}, n1::Int, n2::Int, n3::Int) where {FT<:AbstractFloat} = (
    # create a new matrix to save the data
    array = ones(FT, size(data,1) * n1, size(data,2) * n2, size(data,3) * n3) .* FT(NaN);
    for i in axes(data,1), j in axes(data,2), k in axes(data,3)
        array[(i-1)*n1+1:i*n1, (j-1)*n2+1:j*n2, (k-1)*n3+1:k*n3] .= data[i,j,k];
    end;

    return array
);
