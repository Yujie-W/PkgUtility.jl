import EmeraldUtilities.UniversalConstants as UC


@testset "UniversalConstants" verbose = true begin
    @testset "Constants" begin
        @test !isnan(UC.AVOGADRO());
        @test !isnan(UC.CP_D());
        @test !isnan(UC.CP_D_MOL());
        @test !isnan(UC.CP_I());
        @test !isnan(UC.CP_I_MOL());
        @test !isnan(UC.CP_L());
        @test !isnan(UC.CP_L_MOL());
        @test !isnan(UC.CP_V());
        @test !isnan(UC.CP_V_MOL());
        @test !isnan(UC.F_N₂());
        @test !isnan(UC.F_O₂());
        @test !isnan(UC.GAS_R());
        @test !isnan(UC.GLUCOSE());
        @test !isnan(UC.GRAVITY());
        @test !isnan(UC.H_PLANCK());
        @test !isnan(UC.K_BOLTZMANN());
        @test !isnan(UC.K_STEFAN());
        @test !isnan(UC.K_VON_KARMAN());
        @test !isnan(UC.LH_M₀());
        @test !isnan(UC.LH_V₀());
        @test !isnan(UC.LIGHT_SPEED());
        @test !isnan(UC.M_DRYAIR());
        @test !isnan(UC.M_H₂O());
        @test !isnan(UC.P_ATM());
        @test !isnan(UC.PRESS_TRIPLE());
        @test !isnan(UC.R_EQUATOR());
        @test !isnan(UC.R_POLAR());
        @test !isnan(UC.R_V());
        @test !isnan(UC.RT₂₅());
        @test !isnan(UC.T₀());
        @test !isnan(UC.T₂₅());
        @test !isnan(UC.T_TRIPLE());
        @test !isnan(UC.V_H₂O());
        @test !isnan(UC.YEAR_D());
        @test !isnan(UC.Λ_THERMAL_H₂O());
        @test !isnan(UC.ρ_H₂O());
        @test !isnan(UC.ρg_MPa());
    end;

    @testset "Unit Conversion" begin
        λ = 500.0;  # nm
        E = 1.0e-6;  # J
        phot = UC.energy_to_photon(λ, E);
        E_back = UC.photon_to_energy(λ, phot);
        @test E ≈ E_back;

        λ_vec = [400.0, 500.0, 600.0];  # nm
        E_vec = [1.0e-6, 2.0e-6, 3.0e-6];  # J
        phot_vec = similar(E_vec);
        UC.energy_to_photon!(λ_vec, E_vec, phot_vec);
        E_back_vec = similar(E_vec);
        UC.photon_to_energy!(λ_vec, phot_vec, E_back_vec);
        @test all(E_vec .≈ E_back_vec);
    end;
end;
