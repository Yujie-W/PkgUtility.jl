###############################################################################
#
# Yujie's wrapper for CLIMAParameters
#
###############################################################################
# Define a local struct inherited from AbstractEarthParameterSet
struct EarthParameterSet <: AbstractEarthParameterSet end
const EARTH      = EarthParameterSet();




CP_L(FT)         = FT( cp_l(EARTH) );
CP_V(FT)         = FT( cp_v(EARTH) );
GAS_R(FT)        = FT( gas_constant() );
K_25(FT)         = FT( T_freeze(EARTH) + 25 );
K_BOLTZMANN(FT)  = FT( k_Boltzmann() );
LH_V0(FT)        = FT( LH_v0(EARTH) );
MOLMASS_H₂O(FT)  = FT( molmass_water(EARTH) );
PRESS_TRIPLE(FT) = FT( press_triple(EARTH) );
R_V(FT)          = FT( R_v(EARTH) );
T_TRIPLE(FT)     = FT( T_triple(EARTH) );
ρ_H₂O(FT)        = FT( ρ_cloud_liq(EARTH) );

MOLVOL_H₂O(FT)   = MOLMASS_H₂O(FT) / ρ_H₂O(FT);
