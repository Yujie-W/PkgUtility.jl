
const FAC = 1e-9 / (H_PLANCK() * LIGHT_SPEED() * AVOGADRO());


#######################################################################################################################################################################################################
#
# Changes made to this function
# General
#     2021-Oct-22: rename the function to photon
#     2021-Oct-22: add a method to convert direct from number to number
#     2025-Nov-18: rename the function from photon to energy_to_photon
#
#######################################################################################################################################################################################################
"""

    energy_to_photon(λ::FT, E::FT) where {FT}

Return the number of moles of photons, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `E` Joules of energy

"""
function energy_to_photon(λ::FT, E::FT) where {FT}
    return E * λ * FT(FAC)
end;


#######################################################################################################################################################################################################
#
# Changes made to this function
# General
#     2022-Jun-13: add function
#     2021-Jun-13: add method to save to provided 3rd variable
#     2021-Jun-13: add method to save to provided 2rd variable
#     2025-Nov-18: rename the function from photon! to energy_to_photon!
#
#######################################################################################################################################################################################################
"""

    energy_to_photon!(λ::Vector{FT}, E::Vector{FT}, phot::Vector{FT}) where {FT}
    energy_to_photon!(λ::Vector{FT}, E::Vector{FT}) where {FT}

Compute and save the number of moles of photons, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `E` Joules of energy (will be converted to moles of photons if phot in not given)
- `phot` Mole of photons (variable to save)

"""
function energy_to_photon! end;

energy_to_photon!(λ::Vector{FT}, E::Vector{FT}, phot::Vector{FT}) where {FT} = (phot .= energy_to_photon.(λ, E); return nothing);

energy_to_photon!(λ::Vector{FT}, E::Vector{FT}) where {FT} = (E .*= λ .* FT(FAC); return nothing);


#######################################################################################################################################################################################################
#
# Changes made to this function
# General
#     2021-Oct-22: define function to convert photon back to energy
#   2025-Nov-18: rename the function from energy to photon_to_energy
#
#######################################################################################################################################################################################################
"""

    photon_to_energy(λ::FT, phot::FT) where {FT}

Return the energy, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `phot` Number of moles of photon

"""
function photon_to_energy(λ::FT, phot::FT) where {FT}
    return phot / (λ * FT(FAC))
end;


#######################################################################################################################################################################################################
#
# Changes made to this function
# General
#     2022-Jun-13: add function
#     2021-Jun-13: add method to save to provided 3rd variable
#     2021-Jun-13: add method to save to provided 2rd variable
#     2025-Nov-18: rename the function from energy! to photon_to_energy!
#
#######################################################################################################################################################################################################
"""

    photon_to_energy!(λ::Vector{FT}, phot::Vector{FT}, E::Vector{FT}) where {FT}
    photon_to_energy!(λ::Vector{FT}, phot::Vector{FT}) where {FT}

Compute and save the number of moles of photons, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `phot` Mole of photons (will be converted to moles of photons if E is not given)
- `E` Joules of energy (variable to save)

"""
function photon_to_energy! end;

photon_to_energy!(λ::Vector{FT}, phot::Vector{FT}, E::Vector{FT}) where {FT} = (E .= photon_to_energy.(λ, phot); return nothing);

photon_to_energy!(λ::Vector{FT}, phot::Vector{FT}) where {FT} = (phot ./= λ .* FT(FAC); return nothing);
