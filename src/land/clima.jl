###############################################################################
#
# Yujie's wrapper for CLIMAParameters
#
###############################################################################
# Define a local struct inherited from AbstractEarthParameterSet
struct EarthParameterSet <: AbstractEarthParameterSet end
const EARTH      = EarthParameterSet();




""" Avogadro's number `[molecule mol⁻¹]` """
AVOGADRO(FT=Float64)     = FT( avogad() );

""" Isobaric specific heat of dry air `[J kg⁻¹ K⁻¹]` """
CP_D(FT=Float64)         = FT( cp_d(EARTH) );

""" Isobaric specific heat of dry air `[J mol⁻¹ K⁻¹]` """
CP_D_MOL(FT=Float64)     = CP_D(FT) * M_DRYAIR(FT);

""" Isobaric specific heat of liquid water `[J kg⁻¹ K⁻¹]` """
CP_L(FT=Float64)         = FT( cp_l(EARTH) );

""" Isobaric specific heat of water vapor `[J kg⁻¹ K⁻¹]` """
CP_V(FT=Float64)         = FT( cp_v(EARTH) );

""" Universal gas constant `[J mol⁻¹ K⁻¹]` """
GAS_R(FT=Float64)        = FT( gas_constant() );

""" Gravity of the Earth `[m s⁻²]` """
GRAVITY(FT=Float64)      = FT( grav(EARTH) );

""" Planck constant `[m² kg s⁻¹]` """
H_PLANCK(FT=Float64)     = FT( h_Planck() );

""" Stefan-Boltzmann constant `[W m⁻² K⁻⁴]` """
K_STEFAN(FT=Float64)     = FT( Stefan() );

""" Boltzmann constant `[m² kg s⁻² K⁻¹]` """
K_BOLTZMANN(FT=Float64)  = FT( k_Boltzmann() );

""" Von Karman constant `[-]` """
K_VON_KARMAN(FT=Float64) = FT( von_karman_const(EARTH) );

""" Latent heat vaporization at ``T_0`` `[K kg⁻¹]` """
LH_V0(FT=Float64)        = FT( LH_v0(EARTH) );

""" Light speed in vacuum `[m s⁻¹]` """
LIGHT_SPEED(FT=Float64)  = FT( light_speed() );

""" Molar mass of dry air `[kg mol⁻¹]` """
M_DRYAIR(FT=Float64)     = FT( molmass_dryair(EARTH) );

""" Molar mass of water `[kg mol⁻¹]` """
M_H₂O(FT=Float64)        = FT( molmass_water(EARTH) );

""" Mean atmospheric pressure at sea level `[Pa]` """
P_ATM(FT=Float64)        = FT( MSLP(EARTH) );

""" Water vapor pressure at triple temperature `[Pa]` """
PRESS_TRIPLE(FT=Float64) = FT( press_triple(EARTH) );

""" Gas constant water vapor `[J kg⁻¹ K⁻¹]` """
R_V(FT=Float64)          = FT( R_v(EARTH) );

""" Gas constant times 298.15 K `[J mol⁻¹]` """
RT_25(FT=Float64)        = GAS_R(FT) * T_25(FT);

""" Freezing temperature of water `[K]` """
T_0(FT=Float64)          = FT( T_freeze(EARTH) );

""" Kelvin temperature at 25 Celcius `[K]` """
T_25(FT=Float64)         = T_0(FT) + 25;

""" Triple temperature of water `[K]` """
T_TRIPLE(FT=Float64)     = FT( T_triple(EARTH) );

""" Molar volume of liqiud water """
V_H₂O(FT=Float64)        = M_H₂O(FT) / ρ_H₂O(FT);

""" Mean number of days per year [day] """
YEAR_D(FT=Float64)       = FT( 365.2422222 );

""" Density of liquid water `[kg m⁻³]` """
ρ_H₂O(FT=Float64)        = FT( ρ_cloud_liq(EARTH) );

""" Density of water times gravity `[MPa m⁻¹]` """
ρg_MPa(FT=Float64)       = ρ_H₂O(FT) * GRAVITY(FT) * FT(1e-6);
