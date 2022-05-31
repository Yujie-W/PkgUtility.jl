###############################################################################
#
# Yujie's wrapper for CLIMAParameters
#
###############################################################################
""" Avogadro's number `[molecule mol⁻¹]` """
AVOGADRO(FT=Float64) = FT(6.02214076e23);

""" Isobaric specific heat of dry air `[J kg⁻¹ K⁻¹]` """
CP_D(FT=Float64) = GAS_R(FT) / M_DRYAIR(FT) / FT(3.5);

""" Isobaric specific heat of dry air `[J mol⁻¹ K⁻¹]` """
CP_D_MOL(FT=Float64) = GAS_R(FT) / FT(3.5);

""" Isobaric specific heat of liquid water `[J kg⁻¹ K⁻¹]` """
CP_L(FT=Float64) = FT(4181);

""" Isobaric specific heat of water vapor `[J kg⁻¹ K⁻¹]` """
CP_V(FT=Float64) = FT(1859);

""" Universal gas constant `[J mol⁻¹ K⁻¹]` """
GAS_R(FT=Float64) = FT(8.3144598);

""" Gravity of the Earth `[m s⁻²]` """
GRAVITY(FT=Float64) = FT(9.81);

""" Planck constant `[m² kg s⁻¹]` """
H_PLANCK(FT=Float64) = FT(6.626e-34);

""" Boltzmann constant `[m² kg s⁻² K⁻¹]` """
K_BOLTZMANN(FT=Float64) = FT(1.381e-23);

""" Stefan-Boltzmann constant `[W m⁻² K⁻⁴]` """
K_STEFAN(FT=Float64) = FT(5.670e-8);

""" Von Karman constant `[-]` """
K_VON_KARMAN(FT=Float64) = FT(0.4);

""" Latent heat vaporization at ``T_0`` `[K kg⁻¹]` """
LH_V0(FT=Float64) = FT(2.5008e6);

""" Light speed in vacuum `[m s⁻¹]` """
LIGHT_SPEED(FT=Float64) = FT(2.99792458e8);

""" Molar mass of dry air `[kg mol⁻¹]` """
M_DRYAIR(FT=Float64) = FT(28.97e-3);

""" Molar mass of water `[kg mol⁻¹]` """
M_H₂O(FT=Float64) = FT(18.01528e-3);

""" Mean atmospheric pressure at sea level `[Pa]` """
P_ATM(FT=Float64) = FT(1.01325e5);

""" Water vapor pressure at triple temperature `[Pa]` """
PRESS_TRIPLE(FT=Float64) = FT(611.657);

""" Gas constant water vapor `[J kg⁻¹ K⁻¹]` """
R_V(FT=Float64) = GAS_R(FT) / M_H₂O(FT);

""" Gas constant times 298.15 K `[J mol⁻¹]` """
RT_25(FT=Float64) = GAS_R(FT) * T_25(FT);

""" Freezing temperature of water `[K]` """
T_0(FT=Float64) = FT(273.15);

""" Kelvin temperature at 25 Celcius `[K]` """
T_25(FT=Float64) = T_0(FT) + 25;

""" Triple temperature of water `[K]` """
T_TRIPLE(FT=Float64) = FT(273.16);

""" Molar volume of liqiud water """
V_H₂O(FT=Float64) = M_H₂O(FT) / ρ_H₂O(FT);

""" Mean number of days per year [day] """
YEAR_D(FT=Float64) = FT(365.2422222);

""" Density of liquid water `[kg m⁻³]` """
ρ_H₂O(FT=Float64) = FT(1000);

""" Density of water times gravity `[MPa m⁻¹]` """
ρg_MPa(FT=Float64) = ρ_H₂O(FT) * GRAVITY(FT) * FT(1e-6);
