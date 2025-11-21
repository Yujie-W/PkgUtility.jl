"""

    truncate_array(data::Vector{FT}, n::Int) where {FT<:AbstractFloat}
    truncate_array(data::Matrix{FT}, n::Int) where {FT<:AbstractFloat}
    truncate_array(data::Array{FT,3}, n::Int) where {FT<:AbstractFloat}

Return a truncated matrix, given
- `data` Input matrix
- `n` Integer times to truncate the matrix

"""
function truncate_array end;

# 1D array
truncate_array(data::Vector{FT}, n::Int) where {FT<:AbstractFloat} = (
    # make sure input data has higher spatial resolution than target
    @assert length(data) % n == 0 "Target resolution should be an integer division of the input!";

    # create a new vector to save the data
    vec = ones(FT, Int(length(data)/n)) .* FT(NaN);
    for i in axes(vec,1)
        vec[i] = nanmean(data[(i-1)*n+1:i*n]);
    end;

    return vec
);

# 2D array
truncate_array(data::Matrix{FT}, n::Int) where {FT<:AbstractFloat} = truncate_array(data, n, n);

truncate_array(data::Matrix{FT}, n1::Int, n2::Int) where {FT<:AbstractFloat} = (
    # make sure input data has higher spatial resolution than target
    @assert size(data,1) % n1 == 0 "Target resolution should be an integer division of the input!";
    @assert size(data,2) % n2 == 0 "Target resolution should be an integer division of the input!";

    # create a new matrix to save the data
    mat = ones(FT, Int(size(data,1)/n1), Int(size(data,2)/n2)) .* FT(NaN);
    for i in axes(mat,1), j in axes(mat,2)
        mat[i,j] = nanmean(data[(i-1)*n1+1:i*n1, (j-1)*n2+1:j*n2]);
    end;

    return mat
);

# 3D array
truncate_array(data::Array{FT,3}, n::Int) where {FT<:AbstractFloat} = truncate_array(data, n, n, 1);

truncate_array(data::Array{FT,3}, n1::Int, n2::Int) where {FT<:AbstractFloat} = truncate_array(data, n1, n2, 1);

truncate_array(data::Array{FT,3}, n1::Int, n2::Int, n3::Int) where {FT<:AbstractFloat} = (
    # make sure input data has higher spatial resolution than target
    @assert size(data,1) % n1 == 0 "Target resolution should be an integer division of the input!";
    @assert size(data,2) % n2 == 0 "Target resolution should be an integer division of the input!";
    @assert size(data,3) % n3 == 0 "Target resolution should be an integer division of the input!";

    # create a new matrix to save the data
    array = ones(FT, Int(size(data,1)/n1), Int(size(data,2)/n2), Int(size(data,3)/n3)) .* FT(NaN);
    for i in axes(array,1), j in axes(array,2), k in axes(array,3)
        array[i,j,k] = nanmean(data[(i-1)*n1+1:i*n1, (j-1)*n2+1:j*n2, (k-1)*n3+1:k*n3]);
    end;

    return array
);
