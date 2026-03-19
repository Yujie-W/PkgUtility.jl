"""

    projection_point(xyz::Tuple{FT,FT,FT}, light::Tuple{FT,FT,FT}) where {FT}

Return the projected point of a point on the horizontal plane (z = 0), given
- `xyz`: the coordinates of the point
- `light`: the vector of the light source

"""
function projection_point(xyz::Tuple{FT,FT,FT}, light::Tuple{FT,FT,FT}) where {FT}
    return xyz[1] - xyz[3] * light[1] / light[3], xyz[2] - xyz[3] * light[2] / light[3]
end;
