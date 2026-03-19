"""

    perpendicular_point(xy::Tuple{FT,FT}) where {FT}
    perpendicular_point(xyz::Tuple{FT,FT,FT}) where {FT}

Return the coordinates of the point perpendicular to the original point, given
- `xy`: the coordinates of the point on the horizontal plane (z = 0)
- `xyz`: the coordinates of the point in the 3D space

"""
function perpendicular_point end

perpendicular_point(xy::Tuple{FT,FT}) where {FT} = (xy[1]+xy[2], xy[2]-xy[1]);

perpendicular_point(xyz::Tuple{FT,FT,FT}) where {FT} = (xyz[1]+xyz[2], xyz[2]-xyz[1], xyz[3]);
