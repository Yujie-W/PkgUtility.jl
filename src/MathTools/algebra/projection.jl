"""

    projection_area_ratio(θ_azi::FT, θ_inc::FT, α_azi::FT, α_zen::FT) where {FT}

Compute whether the light hits the upper face of the plane (positive ratio) and the ratio between projected and original areas, given
- `θ_azi`: the azimuth angle of the surface normal vector, in degrees, measured clockwise from the north direction
- `θ_inc`: the inclination angle of the surface normal vector, in degrees, measured from the horizontal direction
- `α_azi`: the azimuth angle of the light source, in degrees, measured clockwise from the north direction
- `α_zen`: the zenith angle of the light source, in degrees, measured from the vertical direction

"""
function projection_area_ratio(θ_azi::FT, θ_inc::FT, α_azi::FT, α_zen::FT) where {FT}
    # compute the normal vector of the surface
    a_x = cosd(θ_inc) * -cosd(θ_azi);
    a_y = cosd(θ_inc) *  sind(θ_azi);
    a_z = sind(θ_inc);

    # compute the light source vector
    s_x = sind(α_zen) * -cosd(α_azi);
    s_y = sind(α_zen) *  sind(α_azi);
    s_z = cosd(α_zen);

    # compute the extended point on the same surface
    (b_x, b_y, b_z) = perpendicular_point((a_x, a_y, a_z));

    # compute the A⁰ and B⁰ projected on the horizontal plane
    (p_x, p_y) = projection_point((a_x, a_y, a_z), (s_x, s_y, s_z));
    (q_x, q_y) = projection_point((b_x, b_y, b_z), (s_x, s_y, s_z));

    # projected area between OA⁰ and OB⁰, and the original area between OA and OB
    ratio = triangle_area((p_x, p_y), (q_x, q_y)) / triangle_area((a_x, a_y, a_z), (b_x, b_y, b_z));

    # the angle between OA' and OA⁰
    upper_side = (a_x * p_x + a_y * p_y) >= 0;

    return upper_side ? ratio : -ratio
end;
