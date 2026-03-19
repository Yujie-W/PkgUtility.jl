"""

    triangle_area(u::Tuple{FT,FT}, v::Tuple{FT,FT}) where {FT}
    triangle_area(u::Tuple{FT,FT,FT}, v::Tuple{FT,FT,FT}) where {FT}

Compute the area of a triangle defined by two vectors, given
- `u`: the first vector
- `v`: the second vector

"""
function triangle_area end;

triangle_area(u::Tuple{FT,FT}, v::Tuple{FT,FT}) where {FT} = FT(0.5) * abs(u[1]*v[2] - u[2]*v[1]);

triangle_area(u::Tuple{FT,FT,FT}, v::Tuple{FT,FT,FT}) where {FT} = FT(0.5) * sqrt((u[2]*v[3] - u[3]*v[2])^2 + (u[3]*v[1] - u[1]*v[3])^2 + (u[1]*v[2] - u[2]*v[1])^2);
