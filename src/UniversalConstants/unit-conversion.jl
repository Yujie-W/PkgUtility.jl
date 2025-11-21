
const FAC = 1e-9 / (H_PLANCK() * LIGHT_SPEED() * AVOGADRO());


"""

    energy_to_photon(λ::FT, E::FT) where {FT}

Return the number of moles of photons, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `E` Joules of energy

"""
function energy_to_photon(λ::FT, E::FT) where {FT}
    return E * λ * FT(FAC)
end;


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


"""

    photon_to_energy(λ::FT, phot::FT) where {FT}

Return the energy, given
- `λ` Wave length in `[nm]`, converted to `[m]` by FAC
- `phot` Number of moles of photon

"""
function photon_to_energy(λ::FT, phot::FT) where {FT}
    return phot / (λ * FT(FAC))
end;


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
